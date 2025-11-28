import 'package:floor/floor.dart';

@Entity(tableName: 'users')
class UserModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String username;
  String password;
  final String role;
  final String nickname; // فیلد جدید
  bool isFirstLogin;
  bool loggedin;

  UserModel({
    required this.username,
    required this.password,
    required this.role,
    required this.isFirstLogin,
    required this.nickname,
    this.id,
    this.loggedin = false,
  });
}
