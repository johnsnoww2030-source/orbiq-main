import 'package:equatable/equatable.dart';

/// Price Range Value Object
/// Represents the three prices: min, selling, max
class PriceRange extends Equatable {
  final double minPrice; // Floor price (minimum profit)
  final double sellingPrice; // Default selling price
  final double maxPrice; // Ceiling price (maximum profit)
  final double minProfitPercent; // Min profit percentage used
  final double defaultProfitPercent; // Default profit percentage used
  final double maxProfitPercent; // Max profit percentage used
  final double costPrice; // Original cost price

  const PriceRange({
    required this.minPrice,
    required this.sellingPrice,
    required this.maxPrice,
    required this.minProfitPercent,
    required this.defaultProfitPercent,
    required this.maxProfitPercent,
    required this.costPrice,
  });

  @override
  List<Object?> get props => [
    minPrice,
    sellingPrice,
    maxPrice,
    minProfitPercent,
    defaultProfitPercent,
    maxProfitPercent,
    costPrice,
  ];

  /// Calculate actual profit for a given price
  double profitAtPrice(double price) => price - costPrice;

  /// Calculate profit percentage for a given price
  double profitPercentAtPrice(double price) =>
      ((price - costPrice) / costPrice) * 100;

  /// Check if price is within valid range
  bool isPriceValid(double price) => price >= minPrice && price <= maxPrice;

  /// Check if price is below floor
  bool isBelowFloor(double price) => price < minPrice;

  /// Check if price is above ceiling
  bool isAboveCeiling(double price) => price > maxPrice;
}
