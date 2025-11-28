import 'package:dartz/dartz.dart';
import 'package:orbiq/features/auth/domain/entities/user_entity.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';

abstract class AuthRepository {
  // عملیات ورود
  Future<Either<Failure, UserEntity>> login(String username, String password);

  //عملیات تغییر رمزعبور در اولین ورود
  Future<Either<Failure, void>> updatePasswordForFirstLogin(String username, String newPassword);

  //متد خروج کاربر
  Future<Either<Failure, void>> logout(int userId);

  Future<Either<Failure, void>> addUser({
    required String username,
    required String password,
    required String role,
    required String nickname,
  });

  // // عملیات ثبت‌نام
  // Future<Either<Failure, void>> registerUser(UserEntity userEntity);

  // // عملیات تغییر رمز عبور
  // Future<Either<Failure, void>> changePassword(int userId, String newPassword);
}
