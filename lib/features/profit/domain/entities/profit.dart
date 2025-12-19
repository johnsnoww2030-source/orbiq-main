import 'package:equatable/equatable.dart';

/// Operational Profit
/// Represents profit from sale operation (selling - cost)
class OperationalProfit extends Equatable {
  final double profitIRR; // Profit in IRR
  final double profitUSD; // Profit in USD (computed)
  final double profitPercent; // Profit percentage

  const OperationalProfit({
    required this.profitIRR,
    required this.profitUSD,
    required this.profitPercent,
  });

  @override
  List<Object?> get props => [profitIRR, profitUSD, profitPercent];
}

/// FX Revaluation Impact
/// Represents impact of exchange rate changes on profit
class FXRevaluationImpact extends Equatable {
  final double historicalValueUSD; // Value at sale time
  final double currentValueUSD; // Value at current rate
  final double valueDifferenceUSD; // Difference
  final double valueDifferencePercent; // Percentage change
  final double historicalRate; // Average rate at sale time
  final double currentRate; // Current rate

  const FXRevaluationImpact({
    required this.historicalValueUSD,
    required this.currentValueUSD,
    required this.valueDifferenceUSD,
    required this.valueDifferencePercent,
    required this.historicalRate,
    required this.currentRate,
  });

  @override
  List<Object?> get props => [
    historicalValueUSD,
    currentValueUSD,
    valueDifferenceUSD,
    valueDifferencePercent,
    historicalRate,
    currentRate,
  ];

  /// Check if there's a loss in value
  bool get hasValueLoss => valueDifferenceUSD < 0;

  /// Check if there's a gain in value
  bool get hasValueGain => valueDifferenceUSD > 0;
}
