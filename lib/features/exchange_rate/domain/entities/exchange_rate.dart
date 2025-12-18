import 'package:equatable/equatable.dart';

/// Exchange Rate Entity
/// Represents a historical exchange rate record
/// Immutable value object from Domain layer
class ExchangeRate extends Equatable {
  final int id;
  final String currencyCode; // USD, EUR, AED
  final double rate; // Exchange rate to base currency (IRR)
  final DateTime recordedAt;
  final String source; // manual, api_bonbast, api_tgju, market_avg, correction
  final double confidence; // 0.0 to 1.0
  final String? notes;
  final String recordedBy; // User UUID

  const ExchangeRate({
    required this.id,
    required this.currencyCode,
    required this.rate,
    required this.recordedAt,
    required this.source,
    required this.confidence,
    this.notes,
    required this.recordedBy,
  });

  @override
  List<Object?> get props => [
    id,
    currencyCode,
    rate,
    recordedAt,
    source,
    confidence,
    notes,
    recordedBy,
  ];

  /// Copy with method for creating modified copies
  ExchangeRate copyWith({
    int? id,
    String? currencyCode,
    double? rate,
    DateTime? recordedAt,
    String? source,
    double? confidence,
    String? notes,
    String? recordedBy,
  }) {
    return ExchangeRate(
      id: id ?? this.id,
      currencyCode: currencyCode ?? this.currencyCode,
      rate: rate ?? this.rate,
      recordedAt: recordedAt ?? this.recordedAt,
      source: source ?? this.source,
      confidence: confidence ?? this.confidence,
      notes: notes ?? this.notes,
      recordedBy: recordedBy ?? this.recordedBy,
    );
  }
}
