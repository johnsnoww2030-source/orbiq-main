import 'package:equatable/equatable.dart';

/// Sale Item Data Model
/// Contains data needed for profit calculations
/// This is NOT a database entity, just a data carrier
class SaleItemData extends Equatable {
  final String itemUuid;
  final double sellingPrice; // Unit selling price
  final double costPrice; // Cost price at sale time
  final double profitIRR; // Profit in IRR (stored)
  final double exchangeRateAtSale; // Exchange rate at sale time (Immutable 🔒)
  final double?
  costExchangeRate; // Exchange rate at purchase time (Immutable 🔒)
  final DateTime soldAt; // Sale timestamp
  final int quantity; // Quantity sold

  const SaleItemData({
    required this.itemUuid,
    required this.sellingPrice,
    required this.costPrice,
    required this.profitIRR,
    required this.exchangeRateAtSale,
    this.costExchangeRate,
    required this.soldAt,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
    itemUuid,
    sellingPrice,
    costPrice,
    profitIRR,
    exchangeRateAtSale,
    costExchangeRate,
    soldAt,
    quantity,
  ];

  /// Calculate profit in USD (computed, never stored)
  /// BR-2.9: profitUSD = profitIRR / exchangeRateAtSale
  double get profitUSD =>
      exchangeRateAtSale > 0 ? profitIRR / exchangeRateAtSale : 0;

  /// Profit percentage
  double get profitPercent => costPrice > 0 ? (profitIRR / costPrice) * 100 : 0;
}
