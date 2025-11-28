// import 'package:dartz/dartz.dart';
// import 'package:orbiq/features/auth/data/data_sources/local/auth_local_data_source.dart';
// import 'package:orbiq/features/auth/data/mappers/user_mapper.dart';
// import 'package:orbiq/features/auth/domain/entities/user_entity.dart';
// import 'package:orbiq/features/auth/domain/failures/failure.dart';
// import 'package:orbiq/features/auth/domain/repositories/auth_repository.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final AuthLocalDataSource localDataSource;
//   AuthRepositoryImpl(this.localDataSource);

//   @override
//   Future<Either<Failure, UserEntity>> login(String username, String password) async {
//     try {
//       final userModel = await localDataSource.loginUser(username);

//       if (userModel != null && UserMapper.checkPassword(password, userModel.password)) {
//         // اگر موفقیت‌آمیز بود
//         if (userModel.isFirstLogin) {
//           // هدایت به صفحه تنظیمات رمز عبور جدید
//           return Left(FirstLoginFailure('اولین ورود مدیر، لطفا رمز عبور جدید را تنظیم کنید.'));
//         } else {
//           // ورود موفق
//           return Right(UserMapper.toEntity(userModel));
//         }
//       } else {
//         // اگر رمز عبور یا نام کاربری اشتباه بود
//         return Left(LoginFailure('نام کاربری یا رمز عبور اشتباه است.'));
//       }
//     } catch (e) {
//       // در صورت وقوع خطا

//       return Left(GeneralFailure(e.toString()));
//     }
//   }

//   // متد برای به‌روزرسانی رمز عبور در اولین ورود
//   @override
//   Future<Either<Failure, void>> updatePasswordForFirstLogin(String username, String newPassword) async {
//     try {
//       final userModel = await localDataSource.loginUser(username);

//       if (userModel != null) {
//         userModel.password = UserMapper.hashPassword(newPassword); // هش کردن رمز عبور جدید
//         userModel.isFirstLogin = false; // تغییر وضعیت اولین ورود
//         await localDataSource.updateUser(userModel);
//         return const Right(null);
//       } else {
//         return Left(GeneralFailure('کاربر یافت نشد.'));
//       }
//     } catch (e) {
//       return Left(GeneralFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> logout(int userId) async {
//     try {
//       await localDataSource.logoutUser(userId); // فراخوانی خروج از دیتابیس
//       return const Right(null); // در صورت موفقیت، Right برمی‌گردد
//     } catch (error) {
//       return Left(GeneralFailure('Failed to log out')); // در صورت خطا، Left با پیام خطا برمی‌گردد
//     }
//   }

// }

import 'package:dartz/dartz.dart';
import 'package:orbiq/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:orbiq/features/auth/data/mappers/user_mapper.dart';
import 'package:orbiq/features/auth/data/models/user_model.dart';
import 'package:orbiq/features/auth/domain/entities/user_entity.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';
import 'package:orbiq/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(String username, String password) async {
    try {
      final userModel = await localDataSource.loginUser(username);

      if (userModel != null && UserMapper.checkPassword(password, userModel.password)) {
        // اگر موفقیت‌آمیز بود
        if (userModel.isFirstLogin) {
          // هدایت به صفحه تنظیمات رمز عبور جدید
          return Left(FirstLoginFailure('اولین ورود مدیر، لطفا رمز عبور جدید را تنظیم کنید.'));
        } else {
          // ورود موفق
          return Right(UserMapper.toEntity(userModel));
        }
      } else {
        // اگر رمز عبور یا نام کاربری اشتباه بود
        return Left(LoginFailure('نام کاربری یا رمز عبور اشتباه است.'));
      }
    } catch (e) {
      // در صورت وقوع خطا
      return Left(GeneralFailure(e.toString()));
    }
  }

  // متد برای به‌روزرسانی رمز عبور در اولین ورود
  @override
  Future<Either<Failure, void>> updatePasswordForFirstLogin(String username, String newPassword) async {
    try {
      final userModel = await localDataSource.loginUser(username);

      if (userModel != null) {
        userModel.password = UserMapper.hashPassword(newPassword); // هش کردن رمز عبور جدید
        userModel.isFirstLogin = false; // تغییر وضعیت اولین ورود
        await localDataSource.updateUser(userModel);
        return const Right(null);
      } else {
        return Left(GeneralFailure('کاربر یافت نشد.'));
      }
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout(int userId) async {
    try {
      await localDataSource.logoutUser(userId); // فراخوانی خروج از دیتابیس
      return const Right(null); // در صورت موفقیت، Right برمی‌گردد
    } catch (error) {
      return Left(GeneralFailure('Failed to log out')); // در صورت خطا، Left با پیام خطا برمی‌گردد
    }
  }

  // متد جدید برای افزودن کاربر
  @override
  Future<Either<Failure, void>> addUser({
    required String username,
    required String password,
    required String role,
    required String nickname,
  }) async {
    try {
      final hashedPassword = UserMapper.hashPassword(password); // هش کردن رمز عبور
      final newUser = UserModel(
        username: username,
        password: hashedPassword,
        role: role,
        isFirstLogin: true,
        loggedin: false,
        nickname: nickname,
      );
      await localDataSource.insertUser(newUser); // تبدیل UserEntity به UserModel و افزودن به دیتابیس
      return const Right(null); // بازگشت موفقیت‌آمیز
    } catch (error) {
      return Left(GeneralFailure('Failed to add user: ${error.toString()}')); // در صورت خطا
    }
  }
}
