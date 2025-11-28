import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:orbiq/features/auth/data/models/user_model.dart';
import 'package:orbiq/features/auth/domain/entities/user_entity.dart';

class UserMapper {
  // تابع هش کردن رمز عبور با الگوریتم SHA-256
  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // تبدیل رمز عبور به بایت
    var digest = sha256.convert(bytes); // هش کردن با استفاده از SHA-256
    return digest.toString(); // برگرداندن هش به صورت رشته
  }

  // تابع برای بررسی تطابق رمز عبور وارد شده با رمز عبور هش‌شده
  static bool checkPassword(String plainPassword, String hashedPassword) {
    // هش کردن رمز عبور وارد شده
    var hashedInputPassword = hashPassword(plainPassword);

    // مقایسه رمز عبور هش‌شده وارد شده با رمز عبور ذخیره شده در دیتابیس
    return hashedInputPassword == hashedPassword;
  }

  static UserModel toModel(UserEntity entity) {
    return UserModel(
        id: entity.id,
        username: entity.username,
        password: hashPassword(entity.password), // هش کردن رمز عبور
        role: entity.role,
        isFirstLogin: entity.isFirstLogin,
        loggedin: entity.loggedin,
        nickname: entity.nickname);
  }

  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      username: model.username,
      password: model.password, // هش‌شده است
      role: model.role,
      isFirstLogin: model.isFirstLogin,
      loggedin: model.loggedin,
      nickname: model.nickname,
    );
  }
}
