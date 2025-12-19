// Failure classes for Exchange Rate feature
import '../../../auth/domain/failures/failure.dart';

class ExchangeRateFailure extends Failure {
  const ExchangeRateFailure([super.message = 'Exchange rate operation failed']);
}

class ExchangeRateNotFoundFailure extends Failure {
  const ExchangeRateNotFoundFailure([
    super.message = 'Exchange rate not found',
  ]);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'Database operation failed']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
