import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/exchange_rate.dart';
import '../repositories/exchange_rate_repository.dart';
import '../../../auth/domain/failures/failure.dart';

/// Parameters for getting exchange rate history
class GetRateHistoryParams extends Equatable {
  final String currencyCode;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? limit;

  const GetRateHistoryParams({
    required this.currencyCode,
    this.fromDate,
    this.toDate,
    this.limit,
  });

  @override
  List<Object?> get props => [currencyCode, fromDate, toDate, limit];
}

/// Use case for getting exchange rate history
class GetRateHistoryUseCase {
  final ExchangeRateRepository repository;

  GetRateHistoryUseCase(this.repository);

  Future<Either<Failure, List<ExchangeRate>>> call(
    GetRateHistoryParams params,
  ) {
    return repository.getRateHistory(
      currencyCode: params.currencyCode,
      fromDate: params.fromDate,
      toDate: params.toDate,
      limit: params.limit,
    );
  }
}
