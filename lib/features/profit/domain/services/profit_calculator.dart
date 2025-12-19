import '../entities/profit.dart';
import '../entities/profit_summary.dart';
import '../entities/daily_profit.dart';
import '../../data/models/sale_item_data.dart';

/// Profit Calculator Service
/// Pure calculation functions (no async, no side effects)
/// BR-2.9, BR-2.10, BR-2.11
class ProfitCalculator {
  /// Calculate profit in USD (Computed - Never Stored)
  /// BR-2.9: profitUSD = profitIRR / exchangeRateAtSale
  double getProfitUSD(double profitIRR, double exchangeRateAtSale) {
    if (exchangeRateAtSale <= 0) return 0;
    return profitIRR / exchangeRateAtSale;
  }

  /// Calculate total historical profit in USD
  /// Uses exchange rate at time of each sale
  double getTotalHistoricalProfitUSD(List<SaleItemData> items) {
    return items.fold(0.0, (sum, item) {
      return sum + getProfitUSD(item.profitIRR, item.exchangeRateAtSale);
    });
  }

  /// Calculate current value in USD with today's rate
  /// BR-2.10: currentValue = SUM(profitIRR) / currentRate
  double getCurrentValueUSD(double totalProfitIRR, double currentRate) {
    if (currentRate <= 0) return 0;
    return totalProfitIRR / currentRate;
  }

  /// Calculate effective exchange rate
  /// BR-2.9: effectiveRate = SUM(profitIRR) / SUM(profitUSD)
  double getEffectiveRate(double totalProfitIRR, double totalProfitUSD) {
    if (totalProfitUSD == 0) return 0;
    return totalProfitIRR / totalProfitUSD;
  }

  /// Calculate value change percentage
  /// BR-2.10: valueLoss% = (historical - current) / historical × 100
  double getValueChangePercent(double historicalUSD, double currentUSD) {
    if (historicalUSD == 0) return 0;
    return ((currentUSD - historicalUSD) / historicalUSD) * 100;
  }

  /// Calculate FX revaluation impact
  /// BR-2.11: Compare historical vs current value
  FXRevaluationImpact getFXImpact({
    required double totalProfitIRR,
    required double historicalRate,
    required double currentRate,
  }) {
    final historicalValueUSD = totalProfitIRR / historicalRate;
    final currentValueUSD = getCurrentValueUSD(totalProfitIRR, currentRate);
    final difference = currentValueUSD - historicalValueUSD;
    final differencePercent = getValueChangePercent(
      historicalValueUSD,
      currentValueUSD,
    );

    return FXRevaluationImpact(
      historicalValueUSD: historicalValueUSD,
      currentValueUSD: currentValueUSD,
      valueDifferenceUSD: difference,
      valueDifferencePercent: differencePercent,
      historicalRate: historicalRate,
      currentRate: currentRate,
    );
  }

  /// Calculate operational profit for a single item
  OperationalProfit calculateItemProfit({
    required double sellingPrice,
    required double costPrice,
    required double exchangeRateAtSale,
  }) {
    final profitIRR = sellingPrice - costPrice;
    final profitUSD = getProfitUSD(profitIRR, exchangeRateAtSale);
    final profitPercent = costPrice > 0
        ? ((profitIRR / costPrice) * 100).toDouble()
        : 0.0;

    return OperationalProfit(
      profitIRR: profitIRR,
      profitUSD: profitUSD,
      profitPercent: profitPercent,
    );
  }

  /// Calculate profit summary for a period
  ProfitSummary calculatePeriodSummary({
    required List<SaleItemData> items,
    required double currentExchangeRate,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (items.isEmpty) {
      return ProfitSummary(
        totalSalesIRR: 0,
        totalCostIRR: 0,
        totalProfitIRR: 0,
        totalProfitUSD: 0,
        currentValueUSD: 0,
        effectiveRate: 0,
        valueDifferenceUSD: 0,
        valueDifferencePercent: 0,
        invoiceCount: 0,
        itemCount: 0,
        startDate: startDate,
        endDate: endDate,
      );
    }

    // Calculate totals
    final totalSalesIRR = items.fold<double>(
      0.0,
      (sum, item) => sum + item.sellingPrice,
    );
    final totalCostIRR = items.fold<double>(
      0.0,
      (sum, item) => sum + item.costPrice,
    );
    final totalProfitIRR = items.fold<double>(
      0.0,
      (sum, item) => sum + item.profitIRR,
    );

    // Calculate historical profit USD
    final totalProfitUSD = getTotalHistoricalProfitUSD(items);

    // Calculate current value
    final currentValueUSD = getCurrentValueUSD(
      totalProfitIRR,
      currentExchangeRate,
    );

    // Calculate effective rate
    final effectiveRate = getEffectiveRate(totalProfitIRR, totalProfitUSD);

    // Calculate value difference
    final valueDifferenceUSD = currentValueUSD - totalProfitUSD;
    final valueDifferencePercent = getValueChangePercent(
      totalProfitUSD,
      currentValueUSD,
    );

    // Count unique invoices (assuming items have invoice reference)
    final invoiceCount =
        items.length; // Simplified - should count unique invoices

    return ProfitSummary(
      totalSalesIRR: totalSalesIRR,
      totalCostIRR: totalCostIRR,
      totalProfitIRR: totalProfitIRR,
      totalProfitUSD: totalProfitUSD,
      currentValueUSD: currentValueUSD,
      effectiveRate: effectiveRate,
      valueDifferenceUSD: valueDifferenceUSD,
      valueDifferencePercent: valueDifferencePercent,
      invoiceCount: invoiceCount,
      itemCount: items.length,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Group items by date and calculate daily profits
  List<DailyProfit> calculateDailyProfits(List<SaleItemData> items) {
    if (items.isEmpty) return [];

    // Group by date
    final Map<DateTime, List<SaleItemData>> dailyGroups = {};
    for (final item in items) {
      final dateOnly = DateTime(
        item.soldAt.year,
        item.soldAt.month,
        item.soldAt.day,
      );
      dailyGroups.putIfAbsent(dateOnly, () => []).add(item);
    }

    // Calculate daily profits
    return dailyGroups.entries.map((entry) {
      final date = entry.key;
      final dayItems = entry.value;

      final salesIRR = dayItems.fold<double>(
        0.0,
        (sum, item) => sum + item.sellingPrice,
      );
      final costIRR = dayItems.fold<double>(
        0.0,
        (sum, item) => sum + item.costPrice,
      );
      final profitIRR = dayItems.fold<double>(
        0.0,
        (sum, item) => sum + item.profitIRR,
      );
      final profitUSD = getTotalHistoricalProfitUSD(dayItems);

      // Calculate average rate for the day
      final totalRate = dayItems.fold<double>(
        0.0,
        (sum, item) => sum + item.exchangeRateAtSale,
      );
      final averageRate = dayItems.isNotEmpty
          ? (totalRate / dayItems.length).toDouble()
          : 0.0;

      return DailyProfit(
        date: date,
        salesIRR: salesIRR,
        costIRR: costIRR,
        profitIRR: profitIRR,
        profitUSD: profitUSD,
        averageRate: averageRate,
        invoiceCount: dayItems.length,
      );
    }).toList()..sort((a, b) => a.date.compareTo(b.date));
  }
}
