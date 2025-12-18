import 'package:dartz/dartz.dart';
import '../entities/exchange_rate.dart';
import '../../../auth/domain/failures/failure.dart';

/// Exchange Rate Repository Interface
/// Defines contract for exchange rate data operations
/// Following Dependency Inversion Principle - Domain doesn't depend on Data layer
abstract class ExchangeRateRepository {
  /// Get the current (latest) exchange rate for a currency
  Future<Either<Failure, ExchangeRate>> getCurrentRate(String currencyCode);

  /// Get exchange rate at a specific date
  /// Returns exact rate if exists, otherwise nearest previous rate
  /// If no previous rate exists, returns first available rate
  Future<Either<Failure, ExchangeRate>> getRateAtDate(
    String currencyCode,
    DateTime date,
  );

  /// Add a new exchange rate event
  /// Returns the inserted record with generated ID
  Future<Either<Failure, ExchangeRate>> addRateEvent({
    required String currencyCode,
    required double rate,
    required String source,
    required String recordedBy,
    double confidence = 1.0,
    String? notes,
  });

  /// Get exchange rate history for a currency within a date range
  Future<Either<Failure, List<ExchangeRate>>> getRateHistory({
    required String currencyCode,
    DateTime? fromDate,
    DateTime? toDate,
    int? limit,
  });

  /// Get all current rates for all tracked currencies
  Future<Either<Failure, Map<String, ExchangeRate>>> getAllCurrentRates(
    List<String> currencyCodes,
  );

  /// Watch current rate for a currency (for reactive UI)
  /// Returns a stream of exchange rates
  Stream<Either<Failure, ExchangeRate>> watchCurrentRate(String currencyCode);
}
