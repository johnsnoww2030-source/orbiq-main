import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  final bool isManager;

  AuthSuccess(this.user, {required this.isManager});
  int get userId => user.id!;

  @override
  List<Object> get props => [
        user,
        isManager
      ];
}

class AuthFirstLogin extends AuthState {
  final String username;

  AuthFirstLogin(this.username);

  @override
  List<Object> get props => [
        username
      ];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object> get props => [
        message
      ];
}

class PasswordUpdateSuccess extends AuthState {}

// اضافه کردن وضعیت Unauthenticated برای خروج کاربر
class UnauthenticatedState extends AuthState {}

class UserAddedSuccess extends AuthState {}
