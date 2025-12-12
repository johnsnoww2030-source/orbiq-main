import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:orbiq/features/auth/data/mappers/user_mapper.dart';
import 'package:orbiq/features/auth/domain/entities/user_entity.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';
import 'package:orbiq/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(
    String username,
    String password,
  ) async {
    try {
      final userEntity = await localDataSource.loginUser(username);

      if (userEntity != null &&
          UserMapper.checkPassword(password, userEntity.password)) {
        // اگر موفقیت‌آمیز بود
        if (userEntity.isFirstLogin) {
          // هدایت به صفحه تنظیمات رمز عبور جدید
          return Left(
            FirstLoginFailure(
              'اولین ورود مدیر، لطفا رمز عبور جدید را تنظیم کنید.',
            ),
          );
        } else {
          // ورود موفق
          return Right(userEntity);
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
  Future<Either<Failure, void>> updatePasswordForFirstLogin(
    String username,
    String newPassword,
  ) async {
    try {
      final userEntity = await localDataSource.loginUser(username);

      if (userEntity != null) {
        final updatedUser = userEntity.copyWith(
          password: UserMapper.hashPassword(newPassword),
          isFirstLogin: false,
        );
        await localDataSource.updateUser(updatedUser);
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
      // Note: Now using UUID. Get logged in user first
      final loggedInUser = await localDataSource.getLoggedInUser();
      if (loggedInUser?.uuid != null) {
        await localDataSource.logoutUser(loggedInUser!.uuid!);
      }
      return const Right(null);
    } catch (error) {
      return Left(GeneralFailure('Failed to log out'));
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
      final newUser = UserEntity(
        username: username,
        password: password, // Will be hashed in mapper
        role: role,
        isFirstLogin: true,
        loggedin: false,
        nickname: nickname,
      );
      await localDataSource.insertUser(newUser);
      return const Right(null);
    } catch (error) {
      return Left(GeneralFailure('Failed to add user: ${error.toString()}'));
    }
  }
}
