import 'package:floor/floor.dart';
import 'package:orbiq/features/auth/data/models/user_model.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM users WHERE username = :username')
  Future<UserModel?> getUserByUsername(String username);

  @insert
  Future<void> insertUser(UserModel user);

  @update
  Future<void> updateUser(UserModel user);

  @Query('SELECT * FROM users WHERE id = :id')
  Future<UserModel?> getUserById(int id);

  @Query('SELECT isFirstLogin FROM users WHERE username = :username')
  Future<bool?> isUserFirstLogin(String username);

  // متد جدید برای به‌روزرسانی وضعیت ورود کاربر
  @Query('UPDATE users SET loggedin = :loggedin WHERE id = :id')
  Future<void> updateLoginStatus(int id, bool loggedin);
}
