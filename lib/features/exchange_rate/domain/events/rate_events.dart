import 'package:orbiq/core/events/domain_event.dart';

/// Event fired when exchange rate is updated
class ExchangeRateUpdatedEvent extends DomainEvent {
  final String currencyCode;
  final double previousRate;
  final double newRate;
  final String source;
  final double changePercent;

  ExchangeRateUpdatedEvent({
    required this.currencyCode,
    required this.previousRate,
    required this.newRate,
    required this.source,
    super.correlationId,
  }) : changePercent = previousRate > 0
           ? ((newRate - previousRate) / previousRate) * 100
           : 0;

  /// Check if this is a significant rate change (>5%)
  bool get isSignificantChange => changePercent.abs() > 5;

  @override
  List<Object?> get props => [
    ...super.props,
    currencyCode,
    previousRate,
    newRate,
    source,
    changePercent,
  ];
}

/// Event fired when rate is fetched from external API
class ExchangeRateFetchedEvent extends DomainEvent {
  final String currencyCode;
  final double rate;
  final String apiSource;
  final bool isSuccessful;
  final String? errorMessage;

  ExchangeRateFetchedEvent({
    required this.currencyCode,
    required this.rate,
    required this.apiSource,
    required this.isSuccessful,
    this.errorMessage,
    super.correlationId,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    currencyCode,
    rate,
    apiSource,
    isSuccessful,
    errorMessage,
  ];
}
