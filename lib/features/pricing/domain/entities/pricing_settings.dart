import 'package:equatable/equatable.dart';

/// Pricing Settings Entity
/// Represents global pricing configuration (singleton)
class PricingSettings extends Equatable {
  final int id; // Always 1 (singleton)
  final double minProfitMargin; // Minimum profit percentage
  final double defaultProfitMargin; // Default profit percentage
  final double maxProfitMargin; // Maximum profit percentage
  final String baseCurrency; // Base currency (IRR)
  final List<String> trackCurrencies; // List of tracked currencies
  final int roundingStep; // Rounding step for prices (e.g., 10000)
  final DateTime? updatedAt;
  final String? updatedBy;

  const PricingSettings({
    this.id = 1,
    required this.minProfitMargin,
    required this.defaultProfitMargin,
    required this.maxProfitMargin,
    required this.baseCurrency,
    required this.trackCurrencies,
    required this.roundingStep,
    this.updatedAt,
    this.updatedBy,
  });

  @override
  List<Object?> get props => [
    id,
    minProfitMargin,
    defaultProfitMargin,
    maxProfitMargin,
    baseCurrency,
    trackCurrencies,
    roundingStep,
    updatedAt,
    updatedBy,
  ];

  PricingSettings copyWith({
    double? minProfitMargin,
    double? defaultProfitMargin,
    double? maxProfitMargin,
    String? baseCurrency,
    List<String>? trackCurrencies,
    int? roundingStep,
    DateTime? updatedAt,
    String? updatedBy,
  }) {
    return PricingSettings(
      minProfitMargin: minProfitMargin ?? this.minProfitMargin,
      defaultProfitMargin: defaultProfitMargin ?? this.defaultProfitMargin,
      maxProfitMargin: maxProfitMargin ?? this.maxProfitMargin,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      trackCurrencies: trackCurrencies ?? this.trackCurrencies,
      roundingStep: roundingStep ?? this.roundingStep,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  /// Factory for default settings
  factory PricingSettings.defaultSettings() {
    return const PricingSettings(
      id: 1,
      minProfitMargin: 20.0,
      defaultProfitMargin: 30.0,
      maxProfitMargin: 50.0,
      baseCurrency: 'IRR',
      trackCurrencies: ['USD', 'EUR', 'AED'],
      roundingStep: 10000,
    );
  }
}
