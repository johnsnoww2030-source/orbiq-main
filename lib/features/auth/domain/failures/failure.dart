// domain/failures/failure.dart

/// Enum for identifying failure types (for localization in UI)
enum AuthFailureType {
  invalidCredentials,
  firstLogin,
  userNotFound,
  logoutFailed,
  addUserFailed,
  general,
}

abstract class Failure {
  final String message;

  Failure(this.message);
}

class LoginFailure extends Failure {
  final AuthFailureType type;

  LoginFailure({required this.type, String? message}) : super(message ?? '');
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class GeneralFailure extends Failure {
  final AuthFailureType type;

  GeneralFailure({required this.type, String? message}) : super(message ?? '');
}

class FirstLoginFailure extends Failure {
  FirstLoginFailure([super.message = '']);
}
