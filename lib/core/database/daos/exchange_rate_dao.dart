import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/exchange_rate_events_table.dart';

part 'exchange_rate_dao.g.dart';

/// DAO for managing exchange rate events
/// Implements append-only, immutable pattern for exchange rates
@DriftAccessor(tables: [ExchangeRateEvents])
class ExchangeRateDao extends DatabaseAccessor<AppDatabase>
    with _$ExchangeRateDaoMixin {
  ExchangeRateDao(AppDatabase db) : super(db);

  /// Get the current (latest) exchange rate for a currency
  Future<ExchangeRateEventData?> getCurrentRate(String currencyCode) {
    return (select(exchangeRateEvents)
          ..where((tbl) => tbl.currencyCode.equals(currencyCode))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.recordedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get exchange rate at a specific date
  /// Returns exact rate if exists, otherwise nearest previous rate
  /// If no previous rate exists, returns first available rate
  Future<ExchangeRateEventData?> getRateAtDate(
    String currencyCode,
    DateTime date,
  ) async {
    // Try to get exact rate for that date
    final exactRate =
        await (select(exchangeRateEvents)
              ..where(
                (tbl) =>
                    tbl.currencyCode.equals(currencyCode) &
                    tbl.recordedAt.equals(date),
              )
              ..limit(1))
            .getSingleOrNull();

    if (exactRate != null) return exactRate;

    // Get nearest previous rate
    final previousRate =
        await (select(exchangeRateEvents)
              ..where(
                (tbl) =>
                    tbl.currencyCode.equals(currencyCode) &
                    tbl.recordedAt.isSmallerThanValue(date),
              )
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.recordedAt)])
              ..limit(1))
            .getSingleOrNull();

    if (previousRate != null) return previousRate;

    // No previous rate, get first available rate
    return (select(exchangeRateEvents)
          ..where((tbl) => tbl.currencyCode.equals(currencyCode))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.recordedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Add a new exchange rate event (append-only)
  /// Returns the inserted record with generated ID
  Future<ExchangeRateEventData> addRateEvent(
    ExchangeRateEventsCompanion entry,
  ) async {
    final id = await into(exchangeRateEvents).insert(entry);
    return (select(
      exchangeRateEvents,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  /// Get exchange rate history for a currency within a date range
  Future<List<ExchangeRateEventData>> getRateHistory({
    required String currencyCode,
    DateTime? fromDate,
    DateTime? toDate,
    int? limit,
  }) {
    final query = select(exchangeRateEvents)
      ..where((tbl) => tbl.currencyCode.equals(currencyCode));

    if (fromDate != null) {
      query.where((tbl) => tbl.recordedAt.isBiggerOrEqualValue(fromDate));
    }

    if (toDate != null) {
      query.where((tbl) => tbl.recordedAt.isSmallerOrEqualValue(toDate));
    }

    query.orderBy([(tbl) => OrderingTerm.desc(tbl.recordedAt)]);

    if (limit != null) {
      query.limit(limit);
    }

    return query.get();
  }

  /// Get all current rates for all tracked currencies
  Future<Map<String, ExchangeRateEventData>> getAllCurrentRates(
    List<String> currencyCodes,
  ) async {
    final Map<String, ExchangeRateEventData> rates = {};

    for (final code in currencyCodes) {
      final rate = await getCurrentRate(code);
      if (rate != null) {
        rates[code] = rate;
      }
    }

    return rates;
  }

  /// Watch current rate for a currency (for reactive UI)
  Stream<ExchangeRateEventData?> watchCurrentRate(String currencyCode) {
    return (select(exchangeRateEvents)
          ..where((tbl) => tbl.currencyCode.equals(currencyCode))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.recordedAt)])
          ..limit(1))
        .watchSingleOrNull();
  }
}
