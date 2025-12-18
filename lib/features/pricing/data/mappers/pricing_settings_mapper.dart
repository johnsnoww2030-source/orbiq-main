import 'dart:convert';
import '../../domain/entities/pricing_settings.dart';
import '../../../../core/database/app_database.dart';
import 'package:drift/drift.dart' as drift;

/// Mapper for PricingSettings
class PricingSettingsMapper {
  /// Convert database DTO to domain entity
  static PricingSettings toEntity(PricingSettingsData data) {
    final currenciesList = (jsonDecode(data.trackCurrencies) as List)
        .map((e) => e.toString())
        .toList();

    return PricingSettings(
      id: data.id,
      minProfitMargin: data.minProfitMargin,
      defaultProfitMargin: data.defaultProfitMargin,
      maxProfitMargin: data.maxProfitMargin,
      baseCurrency: data.baseCurrency,
      trackCurrencies: currenciesList,
      roundingStep: data.roundingStep,
      updatedAt: data.updatedAt,
      updatedBy: data.updatedBy,
    );
  }

  /// Convert domain entity to database companion
  static PricingSettingsCompanion toCompanion(
    PricingSettings settings,
    String updatedBy,
  ) {
    return PricingSettingsCompanion(
      id: const drift.Value(1),
      minProfitMargin: drift.Value(settings.minProfitMargin),
      defaultProfitMargin: drift.Value(settings.defaultProfitMargin),
      maxProfitMargin: drift.Value(settings.maxProfitMargin),
      baseCurrency: drift.Value(settings.baseCurrency),
      trackCurrencies: drift.Value(jsonEncode(settings.trackCurrencies)),
      roundingStep: drift.Value(settings.roundingStep),
      updatedAt: drift.Value(DateTime.now()),
      updatedBy: drift.Value(updatedBy),
    );
  }
}
