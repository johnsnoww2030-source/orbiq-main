import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  LoginRequested(this.username, this.password);

  @override
  List<Object> get props => [
        username,
        password
      ];
}

class UpdatePasswordRequested extends AuthEvent {
  final String username;
  final String newPassword;

  UpdatePasswordRequested({required this.username, required this.newPassword});

  @override
  List<Object> get props => [
        username,
        newPassword
      ];
}

class LogoutRequested extends AuthEvent {
  final int userId;

  LogoutRequested({required this.userId});

  @override
  List<Object> get props => [
        userId
      ];
}

class AddUserRequested extends AuthEvent {
  final String username;
  final String password;
  final String role;
  final String nickname;

  AddUserRequested({
    required this.username,
    required this.password,
    required this.role,
    required this.nickname,
  });

  @override
  List<Object> get props => [
        username,
        password,
        role,
        nickname,
      ];
}

// اضافه کردن این کلاس جدید در انتهای فایل
class RefreshAuth extends AuthEvent {}
