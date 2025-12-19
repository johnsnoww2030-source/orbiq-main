import 'package:equatable/equatable.dart';
import '../../domain/entities/pricing_settings.dart';
import '../../domain/value_objects/price_range.dart';
import '../../domain/repositories/pricing_repository.dart';

/// Base class for Pricing Settings states
sealed class PricingSettingsState extends Equatable {
  const PricingSettingsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PricingSettingsInitial extends PricingSettingsState {
  const PricingSettingsInitial();
}

/// Loading state
class PricingSettingsLoading extends PricingSettingsState {
  const PricingSettingsLoading();
}

/// Settings loaded successfully
class PricingSettingsLoaded extends PricingSettingsState {
  final PricingSettings settings;

  const PricingSettingsLoaded(this.settings);

  @override
  List<Object?> get props => [settings];
}

/// Settings updated successfully
class PricingSettingsUpdated extends PricingSettingsState {
  final PricingSettings settings;

  const PricingSettingsUpdated(this.settings);

  @override
  List<Object?> get props => [settings];
}

/// Prices calculated
class PricesCalculated extends PricingSettingsState {
  final PriceRange priceRange;
  final double costPrice;
  final String? currencyCode;
  final double? exchangeRate;

  const PricesCalculated({
    required this.priceRange,
    required this.costPrice,
    this.currencyCode,
    this.exchangeRate,
  });

  @override
  List<Object?> get props => [
    priceRange,
    costPrice,
    currencyCode,
    exchangeRate,
  ];
}

/// Price validation result
class PriceValidated extends PricingSettingsState {
  final PriceValidationResult result;
  final double sellingPrice;
  final double minPrice;
  final double maxPrice;
  final bool requiresPin; // For below minimum price

  const PriceValidated({
    required this.result,
    required this.sellingPrice,
    required this.minPrice,
    required this.maxPrice,
    this.requiresPin = false,
  });

  @override
  List<Object?> get props => [
    result,
    sellingPrice,
    minPrice,
    maxPrice,
    requiresPin,
  ];

  /// Get warning color
  String get warningColor {
    switch (result) {
      case PriceValidationResult.valid:
        return 'green';
      case PriceValidationResult.aboveMaximum:
        return 'yellow';
      case PriceValidationResult.belowMinimum:
        return 'red';
    }
  }

  /// Get warning message key (for localization)
  String get warningMessageKey {
    switch (result) {
      case PriceValidationResult.valid:
        return 'price_valid';
      case PriceValidationResult.aboveMaximum:
        return 'price_above_maximum';
      case PriceValidationResult.belowMinimum:
        return 'price_below_minimum_requires_pin';
    }
  }
}

/// Error state
class PricingSettingsError extends PricingSettingsState {
  final String message;

  const PricingSettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
