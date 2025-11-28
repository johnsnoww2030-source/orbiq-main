import 'package:orbiq/features/auth/data/mappers/user_mapper.dart';
import 'package:orbiq/features/auth/data/models/user_model.dart';
import 'user_dao.dart';

class AuthLocalDataSource {
  final UserDao userDao;

  AuthLocalDataSource(this.userDao);

  Future<UserModel?> loginUser(String username) async {
    final userModel = await userDao.getUserByUsername(username);
    if (userModel != null) {
      // وقتی کاربر یافت شد، وضعیت ورود او را به true تغییر می‌دهیم
      await userDao.updateLoginStatus(userModel.id!, true);
    }
    return userModel;
  }

  Future<void> insertUser(UserModel user) {
    return userDao.insertUser(user);
  }

  Future<void> updateUser(UserModel user) {
    return userDao.updateUser(user);
  }

  Future<UserModel?> getUserById(int id) {
    return userDao.getUserById(id);
  }

  // متد جدید برای خروج کاربر و تنظیم وضعیت loggedin به false
  Future<void> logoutUser(int userId) async {
    // وضعیت loggedin کاربر را به false تنظیم می‌کنیم
    await userDao.updateLoginStatus(userId, false);
  }

  Future<void> seedAdminUser() async {
    final existingAdmin = await userDao.getUserByUsername('admin');
    if (existingAdmin == null) {
      final adminUser = UserModel(
        id: 1,
        username: 'admin',
        password: UserMapper.hashPassword('admin'), // رمز عبور هش شده
        role: 'admin',
        nickname: 'admin',
        isFirstLogin: true,
        loggedin: false,
      );
      await userDao.insertUser(adminUser); // اگر کاربر مدیر وجود نداشت، اضافه شود
    }
  }
}
