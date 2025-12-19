import 'package:equatable/equatable.dart';

/// Base class for Pricing Settings events
sealed class PricingSettingsEvent extends Equatable {
  const PricingSettingsEvent();

  @override
  List<Object?> get props => [];
}

/// Load current pricing settings
class LoadPricingSettingsEvent extends PricingSettingsEvent {
  const LoadPricingSettingsEvent();
}

/// Update pricing settings
class UpdatePricingSettingsEvent extends PricingSettingsEvent {
  final double minProfitMargin;
  final double defaultProfitMargin;
  final double maxProfitMargin;
  final int roundingStep;
  final List<String> trackCurrencies;

  const UpdatePricingSettingsEvent({
    required this.minProfitMargin,
    required this.defaultProfitMargin,
    required this.maxProfitMargin,
    required this.roundingStep,
    required this.trackCurrencies,
  });

  @override
  List<Object?> get props => [
    minProfitMargin,
    defaultProfitMargin,
    maxProfitMargin,
    roundingStep,
    trackCurrencies,
  ];
}

/// Calculate prices for a product
class CalculatePricesEvent extends PricingSettingsEvent {
  final double costPrice;
  final String? currencyCode;
  final double? exchangeRate;

  const CalculatePricesEvent({
    required this.costPrice,
    this.currencyCode,
    this.exchangeRate,
  });

  @override
  List<Object?> get props => [costPrice, currencyCode, exchangeRate];
}

/// Validate a selling price
class ValidatePriceEvent extends PricingSettingsEvent {
  final double sellingPrice;
  final double minPrice;
  final double maxPrice;

  const ValidatePriceEvent({
    required this.sellingPrice,
    required this.minPrice,
    required this.maxPrice,
  });

  @override
  List<Object?> get props => [sellingPrice, minPrice, maxPrice];
}
