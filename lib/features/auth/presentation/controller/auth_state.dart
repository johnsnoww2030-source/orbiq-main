import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final UserEntity user;
  final bool isManager;

  const AuthSuccess(this.user, {required this.isManager});

  @override
  List<Object?> get props => [user, isManager];
}

class AuthFirstLogin extends AuthState {
  final String username;

  const AuthFirstLogin(this.username);

  @override
  List<Object?> get props => [username];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordUpdateSuccess extends AuthState {
  const PasswordUpdateSuccess();

  @override
  List<Object?> get props => [];
}

class UnauthenticatedState extends AuthState {
  const UnauthenticatedState();

  @override
  List<Object?> get props => [];
}

class UserAddedSuccess extends AuthState {
  const UserAddedSuccess();

  @override
  List<Object?> get props => [];
}

// Extension to get userId from AuthSuccess
extension AuthSuccessExtension on AuthState {
  int? get userId {
    final state = this;
    if (state is AuthSuccess) {
      return state.user.id;
    }
    return null;
  }
}
