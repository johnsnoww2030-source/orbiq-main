import 'package:equatable/equatable.dart';
import '../../domain/entities/exchange_rate.dart';

/// Base class for all Exchange Rate states
sealed class ExchangeRateState extends Equatable {
  const ExchangeRateState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any data is loaded
class ExchangeRateInitial extends ExchangeRateState {
  const ExchangeRateInitial();
}

/// Loading state
class ExchangeRateLoading extends ExchangeRateState {
  const ExchangeRateLoading();
}

/// Successfully loaded current rates
class ExchangeRatesLoaded extends ExchangeRateState {
  final Map<String, ExchangeRate> currentRates;
  final DateTime loadedAt;

  const ExchangeRatesLoaded({
    required this.currentRates,
    required this.loadedAt,
  });

  @override
  List<Object?> get props => [currentRates, loadedAt];

  /// Get rate for a specific currency
  ExchangeRate? getRate(String currencyCode) => currentRates[currencyCode];

  /// Check if rate has changed significantly (>5%)
  bool hasSignificantChange(String currencyCode, double previousRate) {
    final current = currentRates[currencyCode]?.rate;
    if (current == null) return false;
    final change = ((current - previousRate) / previousRate).abs();
    return change > 0.05; // 5% threshold
  }
}

/// Rate history loaded
class RateHistoryLoaded extends ExchangeRateState {
  final String currencyCode;
  final List<ExchangeRate> history;
  final DateTime fromDate;
  final DateTime toDate;

  const RateHistoryLoaded({
    required this.currencyCode,
    required this.history,
    required this.fromDate,
    required this.toDate,
  });

  @override
  List<Object?> get props => [currencyCode, history, fromDate, toDate];

  /// Get min and max rates in history
  double get minRate => history.isEmpty
      ? 0
      : history.map((e) => e.rate).reduce((a, b) => a < b ? a : b);

  double get maxRate => history.isEmpty
      ? 0
      : history.map((e) => e.rate).reduce((a, b) => a > b ? a : b);

  /// Get average rate
  double get averageRate => history.isEmpty
      ? 0
      : history.map((e) => e.rate).reduce((a, b) => a + b) / history.length;
}

/// Rate added successfully
class ExchangeRateAdded extends ExchangeRateState {
  final ExchangeRate rate;
  final bool hasSignificantChange;

  const ExchangeRateAdded({
    required this.rate,
    this.hasSignificantChange = false,
  });

  @override
  List<Object?> get props => [rate, hasSignificantChange];
}

/// Error state
class ExchangeRateError extends ExchangeRateState {
  final String message;
  final String? errorCode;

  const ExchangeRateError({required this.message, this.errorCode});

  @override
  List<Object?> get props => [message, errorCode];
}

/// Warning state (e.g., rate changed >10%)
class ExchangeRateWarning extends ExchangeRateState {
  final String message;
  final double previousRate;
  final double newRate;
  final double changePercent;

  const ExchangeRateWarning({
    required this.message,
    required this.previousRate,
    required this.newRate,
    required this.changePercent,
  });

  @override
  List<Object?> get props => [message, previousRate, newRate, changePercent];
}
