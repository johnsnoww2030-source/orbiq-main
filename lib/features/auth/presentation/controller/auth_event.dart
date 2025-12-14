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
  List<Object> get props => [username, password];
}

class UpdatePasswordRequested extends AuthEvent {
  final String username;
  final String newPassword;

  UpdatePasswordRequested({required this.username, required this.newPassword});

  @override
  List<Object> get props => [username, newPassword];
}

/// رویداد خروج از سیستم - استفاده از uuid به جای userId
class LogoutRequested extends AuthEvent {
  final String userUuid;

  LogoutRequested({required this.userUuid});

  @override
  List<Object> get props => [userUuid];
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
  List<Object> get props => [username, password, role, nickname];
}
