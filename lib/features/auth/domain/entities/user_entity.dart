import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? uuid; // UUID for Drift
  final String username;
  final String password;
  final String role;
  final bool isFirstLogin;
  final bool loggedin;
  final String nickname;

  const UserEntity({
    this.id,
    this.uuid,
    required this.username,
    required this.password,
    required this.nickname,
    required this.role,
    required this.isFirstLogin,
    required this.loggedin,
  });

  @override
  List<Object?> get props => [
    id,
    uuid,
    username,
    role,
    isFirstLogin,
    loggedin,
    nickname,
  ];

  UserEntity copyWith({
    int? id,
    String? uuid,
    String? username,
    String? password,
    String? role,
    bool? isFirstLogin,
    bool? loggedin,
    String? nickname,
  }) {
    return UserEntity(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      isFirstLogin: isFirstLogin ?? this.isFirstLogin,
      loggedin: loggedin ?? this.loggedin,
      nickname: nickname ?? this.nickname,
    );
  }
}
