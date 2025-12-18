import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/pricing_settings_table.dart';

part 'pricing_settings_dao.g.dart';

/// DAO for managing pricing settings (singleton table)
@DriftAccessor(tables: [PricingSettings])
class PricingSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$PricingSettingsDaoMixin {
  PricingSettingsDao(AppDatabase db) : super(db);

  /// Get the current pricing settings (always returns the singleton record)
  Future<PricingSettingsData?> getSettings() {
    return (select(
      pricingSettings,
    )..where((tbl) => tbl.id.equals(1))).getSingleOrNull();
  }

  /// Update pricing settings
  /// Since this is a singleton, we use update with id = 1
  Future<bool> updateSettings(PricingSettingsCompanion settings) {
    return update(pricingSettings).replace(
      PricingSettingsCompanion(
        id: const Value(1),
        minProfitMargin: settings.minProfitMargin,
        defaultProfitMargin: settings.defaultProfitMargin,
        maxProfitMargin: settings.maxProfitMargin,
        baseCurrency: settings.baseCurrency,
        trackCurrencies: settings.trackCurrencies,
        roundingStep: settings.roundingStep,
        updatedAt: Value(DateTime.now()),
        updatedBy: settings.updatedBy,
      ),
    );
  }

  /// Initialize default settings if not exists
  Future<void> initializeDefaultSettings() async {
    final existing = await getSettings();
    if (existing == null) {
      await into(pricingSettings).insert(
        PricingSettingsCompanion.insert(
          id: const Value(1),
          minProfitMargin: const Value(20.0),
          defaultProfitMargin: const Value(30.0),
          maxProfitMargin: const Value(50.0),
          baseCurrency: const Value('IRR'),
          trackCurrencies: const Value('["USD","EUR","AED"]'),
          roundingStep: const Value(10000),
        ),
      );
    }
  }

  /// Watch settings for reactive UI
  Stream<PricingSettingsData?> watchSettings() {
    return (select(
      pricingSettings,
    )..where((tbl) => tbl.id.equals(1))).watchSingleOrNull();
  }
}
