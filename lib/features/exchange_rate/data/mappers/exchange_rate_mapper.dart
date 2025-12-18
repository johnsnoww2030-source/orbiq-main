import '../../domain/entities/exchange_rate.dart';
import '../../../../core/database/app_database.dart';
import 'package:drift/drift.dart' as drift;

/// Mapper between Database DTO and Domain Entity
class ExchangeRateMapper {
  /// Convert database DTO to domain entity
  static ExchangeRate toEntity(ExchangeRateEventData data) {
    return ExchangeRate(
      id: data.id,
      currencyCode: data.currencyCode,
      rate: data.rate,
      recordedAt: data.recordedAt,
      source: data.source,
      confidence: data.confidence,
      notes: data.notes,
      recordedBy: data.recordedBy,
    );
  }

  /// Convert domain entity to database companion (for insert)
  static ExchangeRateEventsCompanion toCompanion({
    required String currencyCode,
    required double rate,
    required DateTime recordedAt,
    required String source,
    required double confidence,
    String? notes,
    required String recordedBy,
  }) {
    return ExchangeRateEventsCompanion.insert(
      currencyCode: currencyCode,
      rate: rate,
      recordedAt: recordedAt,
      source: source,
      confidence: drift.Value(confidence),
      notes: drift.Value(notes),
      recordedBy: recordedBy,
    );
  }

  /// Convert list of database DTOs to list of domain entities
  static List<ExchangeRate> toEntityList(List<ExchangeRateEventData> dataList) {
    return dataList.map((data) => toEntity(data)).toList();
  }
}
