import 'package:dartz/dartz.dart';
import '../../domain/repositories/profit_repository.dart';
import '../../domain/entities/profit_summary.dart';
import '../../domain/entities/daily_profit.dart';
import '../../domain/services/profit_calculator.dart';
import '../models/sale_item_data.dart';
import '../../../auth/domain/failures/failure.dart';
import '../../../exchange_rate/domain/failures/exchange_rate_failure.dart';
import '../../../exchange_rate/domain/repositories/exchange_rate_repository.dart';
import '../../../../core/database/daos/sales_dao.dart';

/// Implementation of ProfitRepository
class ProfitRepositoryImpl implements ProfitRepository {
  final SalesDao salesDao;
  final ExchangeRateRepository exchangeRateRepository;
  final ProfitCalculator calculator;

  ProfitRepositoryImpl({
    required this.salesDao,
    required this.exchangeRateRepository,
    required this.calculator,
  });

  @override
  Future<Either<Failure, List<SaleItemData>>> getSaleItems({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      // Get sales items from database
      final items = await salesDao.getSalesItemsByDateRange(startDate, endDate);

      // Get current rate as fallback for items without historical rate
      double fallbackRate = 60000.0; // Default USD/IRR rate
      try {
        final rateResult = await exchangeRateRepository.getCurrentRate('USD');
        rateResult.fold((_) {}, (rate) => fallbackRate = rate.rate);
      } catch (_) {}

      // Convert to SaleItemData
      final saleItemDataList = items.map((item) {
        // Use historical rate if available, otherwise use current rate as fallback
        final rate = item.exchangeRateAtSale ?? fallbackRate;
        return SaleItemData(
          itemUuid: item.itemUuid,
          sellingPrice: item.unitSellPrice,
          costPrice: item.costAtSale,
          profitIRR: item.profitIrr ?? (item.unitSellPrice - item.costAtSale),
          exchangeRateAtSale: rate,
          costExchangeRate: item.costExchangeRate,
          soldAt: DateTime.now(), // Should get from invoice
          quantity: item.quantity,
        );
      }).toList();

      return Right(saleItemDataList);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfitSummary>> getProfitSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      // Get sale items
      final itemsResult = await getSaleItems(
        startDate: startDate,
        endDate: endDate,
      );

      return itemsResult.fold((failure) => Left(failure), (items) async {
        // Get current exchange rate
        final currentRateResult = await exchangeRateRepository.getCurrentRate(
          'USD',
        );

        return currentRateResult.fold((failure) => Left(failure), (
          exchangeRate,
        ) {
          // Calculate summary using calculator
          final summary = calculator.calculatePeriodSummary(
            items: items,
            currentExchangeRate: exchangeRate.rate,
            startDate: startDate,
            endDate: endDate,
          );

          return Right(summary);
        });
      });
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DailyProfit>>> getDailyProfits({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      // Get sale items
      final itemsResult = await getSaleItems(
        startDate: startDate,
        endDate: endDate,
      );

      return itemsResult.fold((failure) => Left(failure), (items) {
        // Calculate daily profits using calculator
        final dailyProfits = calculator.calculateDailyProfits(items);
        return Right(dailyProfits);
      });
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfitSummary>> getInvoiceProfit(
    String invoiceUuid,
  ) async {
    try {
      // Get invoice items
      final items = await salesDao.getSalesItemsByInvoice(invoiceUuid);

      // Get current exchange rate
      final currentRateResult = await exchangeRateRepository.getCurrentRate(
        'USD',
      );

      return currentRateResult.fold((failure) => Left(failure), (exchangeRate) {
        // Convert to SaleItemData - use current rate as fallback for items without historical rate
        final saleItemDataList = items.map((item) {
          return SaleItemData(
            itemUuid: item.itemUuid,
            sellingPrice: item.unitSellPrice,
            costPrice: item.costAtSale,
            profitIRR: item.profitIrr ?? (item.unitSellPrice - item.costAtSale),
            exchangeRateAtSale: item.exchangeRateAtSale ?? exchangeRate.rate,
            costExchangeRate: item.costExchangeRate,
            soldAt: DateTime.now(),
            quantity: item.quantity,
          );
        }).toList();

        // Calculate summary
        final summary = calculator.calculatePeriodSummary(
          items: saleItemDataList,
          currentExchangeRate: exchangeRate.rate,
          startDate: DateTime.now(),
          endDate: DateTime.now(),
        );

        return Right(summary);
      });
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
