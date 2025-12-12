import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'package:orbiq/features/auth/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

/// Mapper for converting between Drift User and domain UserEntity
class UserMapper {
  static const _uuid = Uuid();

  // تابع هش کردن رمز عبور با الگوریتم SHA-256
  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // تبدیل رمز عبور به بایت
    var digest = sha256.convert(bytes); // هش کردن با استفاده از SHA-256
    return digest.toString(); // برگرداندن هش به صورت رشته
  }

  // تابع برای بررسی تطابق رمز عبور وارد شده با رمز عبور هش‌شده
  static bool checkPassword(String plainPassword, String hashedPassword) {
    var hashedInputPassword = hashPassword(plainPassword);
    return hashedInputPassword == hashedPassword;
  }

  /// Convert domain UserEntity to Drift UsersCompanion for insert
  static UsersCompanion toCompanion(UserEntity entity, {String? existingUuid}) {
    final now = DateTime.now();
    return UsersCompanion(
      userUuid: Value(existingUuid ?? _uuid.v4()),
      username: Value(entity.username),
      password: Value(hashPassword(entity.password)),
      role: Value(entity.role),
      nickname: Value(entity.nickname),
      isFirstLogin: Value(entity.isFirstLogin),
      loggedIn: Value(entity.loggedin),
      createdAt: Value(now),
      updatedAt: Value(now),
    );
  }

  /// Convert Drift User to domain UserEntity
  static UserEntity toEntity(User user) {
    return UserEntity(
      id: null, // UUID is used instead of int id
      uuid: user.userUuid,
      username: user.username,
      password: user.password, // هش‌شده است
      role: user.role,
      nickname: user.nickname,
      isFirstLogin: user.isFirstLogin,
      loggedin: user.loggedIn,
    );
  }
}
