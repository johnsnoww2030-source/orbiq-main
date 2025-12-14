// domain/failures/failure.dart

import 'package:equatable/equatable.dart';

/// Enum for identifying failure types (for localization in UI)
enum AuthFailureType {
  invalidCredentials,
  firstLogin,
  userNotFound,
  logoutFailed,
  addUserFailed,
  general,
}

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginFailure extends Failure {
  final AuthFailureType type;

  const LoginFailure({required this.type, String message = ''})
    : super(message);

  @override
  List<Object?> get props => [message, type];
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error']);
}

class GeneralFailure extends Failure {
  final AuthFailureType type;

  const GeneralFailure({required this.type, String message = ''})
    : super(message);

  @override
  List<Object?> get props => [message, type];
}

class FirstLoginFailure extends Failure {
  const FirstLoginFailure([super.message = 'First login required']);
}
