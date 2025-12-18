import 'package:dartz/dartz.dart';
import '../entities/exchange_rate.dart';
import '../repositories/exchange_rate_repository.dart';
import '../../../auth/domain/failures/failure.dart';

/// Use case for getting the current exchange rate
class GetCurrentRateUseCase {
  final ExchangeRateRepository repository;

  GetCurrentRateUseCase(this.repository);

  Future<Either<Failure, ExchangeRate>> call(String currencyCode) {
    return repository.getCurrentRate(currencyCode);
  }
}
