import 'package:dartz/dartz.dart';
import '../entities/exchange_rate.dart';
import '../repositories/exchange_rate_repository.dart';
import '../../../auth/domain/failures/failure.dart';

/// Use case for getting exchange rate at a specific date
/// Implements BR-2.4: Historical rate fallback logic
class GetRateAtDateUseCase {
  final ExchangeRateRepository repository;

  GetRateAtDateUseCase(this.repository);

  Future<Either<Failure, ExchangeRate>> call({
    required String currencyCode,
    required DateTime date,
  }) {
    return repository.getRateAtDate(currencyCode, date);
  }
}
