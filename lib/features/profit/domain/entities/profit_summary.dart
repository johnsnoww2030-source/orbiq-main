import 'package:equatable/equatable.dart';

/// Profit Summary for a period
/// Aggregates all profit information
class ProfitSummary extends Equatable {
  final double totalSalesIRR; // Total sales in IRR
  final double totalCostIRR; // Total cost in IRR
  final double totalProfitIRR; // Total profit in IRR
  final double totalProfitUSD; // Total profit in USD (historical rates)
  final double currentValueUSD; // Current value with today's rate
  final double effectiveRate; // Effective exchange rate
  final double valueDifferenceUSD; // Loss/gain in value
  final double valueDifferencePercent; // Percentage change
  final int invoiceCount; // Number of invoices
  final int itemCount; // Number of items sold
  final DateTime startDate; // Period start
  final DateTime endDate; // Period end

  const ProfitSummary({
    required this.totalSalesIRR,
    required this.totalCostIRR,
    required this.totalProfitIRR,
    required this.totalProfitUSD,
    required this.currentValueUSD,
    required this.effectiveRate,
    required this.valueDifferenceUSD,
    required this.valueDifferencePercent,
    required this.invoiceCount,
    required this.itemCount,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [
    totalSalesIRR,
    totalCostIRR,
    totalProfitIRR,
    totalProfitUSD,
    currentValueUSD,
    effectiveRate,
    valueDifferenceUSD,
    valueDifferencePercent,
    invoiceCount,
    itemCount,
    startDate,
    endDate,
  ];

  /// Profit margin percentage
  double get profitMarginPercent =>
      totalCostIRR > 0 ? (totalProfitIRR / totalCostIRR) * 100 : 0;

  /// Average profit per invoice
  double get averageProfitPerInvoice =>
      invoiceCount > 0 ? totalProfitIRR / invoiceCount : 0;

  /// Check if there's value loss
  bool get hasValueLoss => valueDifferenceUSD < 0;
}
