import 'package:dartz/dartz.dart';
import '../entities/pricing_settings.dart';
import '../value_objects/price_range.dart';
import '../../../auth/domain/failures/failure.dart';

/// Pricing Repository Interface
/// Defines contract for pricing operations
abstract class PricingRepository {
  /// Get current pricing settings
  Future<Either<Failure, PricingSettings>> getSettings();

  /// Save pricing settings
  /// Validates constraints before saving (BR-2.5)
  Future<Either<Failure, PricingSettings>> saveSettings(
    PricingSettings settings,
  );

  /// Calculate three prices based on cost price
  /// Implements BR-2.6
  Either<Failure, PriceRange> calculatePrices({
    required double costPrice,
    PricingSettings? settings, // If null, use stored settings
  });

  /// Convert price from foreign currency to base currency
  /// Implements BR-2.7
  Either<Failure, double> convertToBaseCurrency({
    required double amount,
    required String fromCurrency,
    required double exchangeRate,
  });

  /// Validate selling price against min/max
  /// Implements BR-2.8
  PriceValidationResult validateSellingPrice({
    required double sellingPrice,
    required double minPrice,
    required double maxPrice,
  });

  /// Round price according to rounding step
  double roundPrice(double price, {int? step});
}

/// Price Validation Result
enum PriceValidationResult {
  valid, // Price is within range
  belowMinimum, // Price < minPrice (RED warning + PIN required)
  aboveMaximum, // Price > maxPrice (YELLOW warning)
}
