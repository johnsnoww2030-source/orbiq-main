import 'package:equatable/equatable.dart';

/// Base class for all Exchange Rate events
sealed class ExchangeRateEvent extends Equatable {
  const ExchangeRateEvent();

  @override
  List<Object?> get props => [];
}

/// Load current rates for all tracked currencies
class LoadCurrentRatesEvent extends ExchangeRateEvent {
  final List<String> currencyCodes;

  const LoadCurrentRatesEvent(this.currencyCodes);

  @override
  List<Object?> get props => [currencyCodes];
}

/// Load rate history for a specific currency
class LoadRateHistoryEvent extends ExchangeRateEvent {
  final String currencyCode;
  final DateTime? fromDate;
  final DateTime? toDate;

  const LoadRateHistoryEvent({
    required this.currencyCode,
    this.fromDate,
    this.toDate,
  });

  @override
  List<Object?> get props => [currencyCode, fromDate, toDate];
}

/// Add a new exchange rate
class AddExchangeRateEvent extends ExchangeRateEvent {
  final String currencyCode;
  final double rate;
  final String source;
  final double confidence;
  final String? notes;

  const AddExchangeRateEvent({
    required this.currencyCode,
    required this.rate,
    required this.source,
    this.confidence = 1.0,
    this.notes,
  });

  @override
  List<Object?> get props => [currencyCode, rate, source, confidence, notes];
}

/// Watch rate changes (for reactive updates)
class WatchRateEvent extends ExchangeRateEvent {
  final String currencyCode;

  const WatchRateEvent(this.currencyCode);

  @override
  List<Object?> get props => [currencyCode];
}

/// Refresh rates from cache
class RefreshRatesEvent extends ExchangeRateEvent {
  const RefreshRatesEvent();
}
