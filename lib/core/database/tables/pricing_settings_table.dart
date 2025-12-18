import 'package:drift/drift.dart';

/// Pricing Settings table - singleton table for global pricing configuration
/// Only one record allowed (id = 1)
/// From PRD Phase 2 - Section 5.2
@DataClassName('PricingSettingsData')
class PricingSettings extends Table {
  /// Primary key - always 1 (singleton)
  IntColumn get id => integer().withDefault(const Constant(1))();

  /// Minimum profit margin percentage
  RealColumn get minProfitMargin => real().withDefault(const Constant(20.0))();

  /// Default profit margin percentage
  RealColumn get defaultProfitMargin =>
      real().withDefault(const Constant(30.0))();

  /// Maximum profit margin percentage
  RealColumn get maxProfitMargin => real().withDefault(const Constant(50.0))();

  /// Base currency code (default: IRR)
  TextColumn get baseCurrency => text().withDefault(const Constant('IRR'))();

  /// JSON array of tracked currencies (e.g., ["USD","EUR","AED"])
  TextColumn get trackCurrencies =>
      text().withDefault(const Constant('["USD","EUR","AED"]'))();

  /// Rounding step for price calculation (default: 10000 = 10,000 Toman)
  IntColumn get roundingStep => integer().withDefault(const Constant(10000))();

  /// Last update timestamp
  DateTimeColumn get updatedAt => dateTime().nullable()();

  /// User UUID who last updated settings
  TextColumn get updatedBy => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK(min_profit_margin >= 0)',
    'CHECK(max_profit_margin <= 200)',
    'CHECK(min_profit_margin < default_profit_margin)',
    'CHECK(default_profit_margin < max_profit_margin)',
    'CHECK(id = 1)', // Ensure singleton
  ];
}
