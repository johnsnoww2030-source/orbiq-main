import 'package:equatable/equatable.dart';
import '../entities/profit.dart';
import '../services/profit_calculator.dart';

/// Parameters for CalculateSaleProfitUseCase
class CalculateSaleProfitParams extends Equatable {
  final double sellingPrice;
  final double costPrice;
  final double exchangeRateAtSale;

  const CalculateSaleProfitParams({
    required this.sellingPrice,
    required this.costPrice,
    required this.exchangeRateAtSale,
  });

  @override
  List<Object?> get props => [sellingPrice, costPrice, exchangeRateAtSale];
}

/// Use Case: Calculate Sale Profit
/// Calculates profit for a sale item (to be stored in SalesItems)
/// Returns profitIRR, profitUSD, exchangeRateAtSale
class CalculateSaleProfitUseCase {
  final ProfitCalculator calculator;

  CalculateSaleProfitUseCase(this.calculator);

  /// Calculate profit
  /// This is used when creating a sale item to calculate profitIRR
  /// exchangeRateAtSale should be retrieved from ExchangeRateRepository
  OperationalProfit call(CalculateSaleProfitParams params) {
    return calculator.calculateItemProfit(
      sellingPrice: params.sellingPrice,
      costPrice: params.costPrice,
      exchangeRateAtSale: params.exchangeRateAtSale,
    );
  }
}
