import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/exchange_rate.dart';
import '../repositories/exchange_rate_repository.dart';
import '../../../auth/domain/failures/failure.dart';

/// Parameters for adding a new exchange rate event
class AddRateEventParams extends Equatable {
  final String currencyCode;
  final double rate;
  final String source;
  final String recordedBy;
  final double confidence;
  final String? notes;

  const AddRateEventParams({
    required this.currencyCode,
    required this.rate,
    required this.source,
    required this.recordedBy,
    this.confidence = 1.0,
    this.notes,
  });

  @override
  List<Object?> get props => [
    currencyCode,
    rate,
    source,
    recordedBy,
    confidence,
    notes,
  ];
}

/// Use case for adding a new exchange rate event
/// Implements BR-2.2: Exchange rate validation
class AddRateEventUseCase {
  final ExchangeRateRepository repository;

  AddRateEventUseCase(this.repository);

  Future<Either<Failure, ExchangeRate>> call(AddRateEventParams params) async {
    // Validation: Rate must be positive (BR-2.2)
    if (params.rate <= 0) {
      return Left(ValidationFailure('Exchange rate must be greater than 0'));
    }

    // Validation: Confidence must be between 0 and 1
    if (params.confidence < 0 || params.confidence > 1) {
      return Left(ValidationFailure('Confidence must be between 0.0 and 1.0'));
    }

    // Validation: Valid source
    const validSources = [
      'manual',
      'api_bonbast',
      'api_tgju',
      'market_avg',
      'correction',
    ];
    if (!validSources.contains(params.source)) {
      return Left(ValidationFailure('Invalid source: ${params.source}'));
    }

    return repository.addRateEvent(
      currencyCode: params.currencyCode,
      rate: params.rate,
      source: params.source,
      recordedBy: params.recordedBy,
      confidence: params.confidence,
      notes: params.notes,
    );
  }
}

/// Validation Failure class
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
