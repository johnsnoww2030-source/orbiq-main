import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'package:orbiq/core/database/daos/user_dao.dart';
import 'package:orbiq/features/auth/data/mappers/user_mapper.dart';
import 'package:orbiq/features/auth/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class AuthLocalDataSource {
  final UserDao userDao;
  static const _uuid = Uuid();

  AuthLocalDataSource(this.userDao);

  Future<UserEntity?> loginUser(String username) async {
    final user = await userDao.getUserByUsername(username);
    if (user != null) {
      // وقتی کاربر یافت شد، وضعیت ورود او را به true تغییر می‌دهیم
      await userDao.updateLoginStatus(user.userUuid, true);
      return UserMapper.toEntity(user);
    }
    return null;
  }

  Future<void> insertUser(UserEntity entity) async {
    final companion = UserMapper.toCompanion(entity);
    await userDao.insertUser(companion);
  }

  Future<void> updateUser(UserEntity entity) async {
    if (entity.uuid != null) {
      final user = await userDao.getUserByUuid(entity.uuid!);
      if (user != null) {
        final updated = User(
          userUuid: user.userUuid,
          username: entity.username,
          password: entity.password,
          role: entity.role,
          nickname: entity.nickname,
          isFirstLogin: entity.isFirstLogin,
          loggedIn: entity.loggedin,
          createdAt: user.createdAt,
          updatedAt: DateTime.now(),
        );
        await userDao.updateUser(updated);
      }
    }
  }

  Future<UserEntity?> getUserByUuid(String uuid) async {
    final user = await userDao.getUserByUuid(uuid);
    return user != null ? UserMapper.toEntity(user) : null;
  }

  Future<UserEntity?> getLoggedInUser() async {
    final user = await userDao.getLoggedInUser();
    return user != null ? UserMapper.toEntity(user) : null;
  }

  // متد جدید برای خروج کاربر و تنظیم وضعیت loggedin به false
  Future<void> logoutUser(String userUuid) async {
    await userDao.updateLoginStatus(userUuid, false);
  }

  Future<void> seedAdminUser() async {
    final existingAdmin = await userDao.getUserByUsername('admin');
    if (existingAdmin == null) {
      final now = DateTime.now();
      final adminCompanion = UsersCompanion(
        userUuid: Value(_uuid.v4()),
        username: const Value('admin'),
        password: Value(UserMapper.hashPassword('admin')),
        role: const Value('admin'),
        nickname: const Value('admin'),
        isFirstLogin: const Value(true),
        loggedIn: const Value(false),
        createdAt: Value(now),
        updatedAt: Value(now),
      );
      await userDao.insertUser(adminCompanion);
    }
  }
}
