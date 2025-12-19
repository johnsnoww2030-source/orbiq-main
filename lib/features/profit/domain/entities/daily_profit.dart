import 'package:equatable/equatable.dart';

/// Daily Profit
/// Represents profit for a single day
class DailyProfit extends Equatable {
  final DateTime date; // Date
  final double salesIRR; // Total sales
  final double costIRR; // Total cost
  final double profitIRR; // Total profit
  final double profitUSD; // Profit in USD (with that day's rates)
  final double averageRate; // Average exchange rate for that day
  final int invoiceCount; // Number of invoices

  const DailyProfit({
    required this.date,
    required this.salesIRR,
    required this.costIRR,
    required this.profitIRR,
    required this.profitUSD,
    required this.averageRate,
    required this.invoiceCount,
  });

  @override
  List<Object?> get props => [
    date,
    salesIRR,
    costIRR,
    profitIRR,
    profitUSD,
    averageRate,
    invoiceCount,
  ];

  /// Profit margin for this day
  double get profitMargin => costIRR > 0 ? (profitIRR / costIRR) * 100 : 0;
}
