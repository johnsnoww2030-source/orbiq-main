import 'package:drift/drift.dart';

/// Exchange Rate Events table - historical exchange rate records
/// Immutable, append-only table for tracking currency exchange rates
/// From PRD Phase 2 - Section 5.1
@DataClassName('ExchangeRateEventData')
class ExchangeRateEvents extends Table {
  /// Auto-increment primary key
  IntColumn get id => integer().autoIncrement()();

  /// Currency code (USD, EUR, AED)
  TextColumn get currencyCode => text()();

  /// Exchange rate to base currency (IRR)
  RealColumn get rate => real()();

  /// Timestamp when rate was recorded (Immutable 🔒)
  DateTimeColumn get recordedAt => dateTime()();

  /// Source of the rate: manual, api_bonbast, api_tgju, market_avg, correction
  TextColumn get source => text()();

  /// Confidence score (0.0 to 1.0)
  RealColumn get confidence => real().withDefault(const Constant(1.0))();

  /// Optional notes
  TextColumn get notes => text().nullable()();

  /// User UUID who recorded this rate
  TextColumn get recordedBy => text()();

  @override
  List<String> get customConstraints => [
    'CHECK(rate > 0)',
    'CHECK(confidence >= 0 AND confidence <= 1)',
    'CHECK(source IN ("manual", "api_bonbast", "api_tgju", "market_avg", "correction"))',
  ];
}
