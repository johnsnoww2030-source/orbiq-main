// Failure classes for Exchange Rate feature
import '../../../auth/domain/failures/failure.dart';

class ExchangeRateFailure extends Failure {
  const ExchangeRateFailure([String message = 'Exchange rate operation failed'])
    : super(message);
}

class ExchangeRateNotFoundFailure extends Failure {
  const ExchangeRateNotFoundFailure([
    String message = 'Exchange rate not found',
  ]) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([String message = 'Database operation failed'])
    : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}
