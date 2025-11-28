class UserEntity {
  final int? id;
  final String username;
  final String password;
  final String role;
  final bool isFirstLogin;
  final bool loggedin;
  final String nickname;

  UserEntity({
    required this.id,
    required this.username,
    required this.password,
    required this.nickname,
    required this.role,
    required this.isFirstLogin,
    required this.loggedin,
  });
}
