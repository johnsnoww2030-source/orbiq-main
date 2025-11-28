// domain/failures/failure.dart
abstract class Failure {
  final String message;

  Failure(this.message);
}

class LoginFailure extends Failure {
  LoginFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class GeneralFailure extends Failure {
  GeneralFailure(super.message);
}

class FirstLoginFailure extends Failure {
  FirstLoginFailure(super.message);
}
