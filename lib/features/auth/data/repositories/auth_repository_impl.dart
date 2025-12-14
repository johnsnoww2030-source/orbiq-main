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
        if (userEntity.isFirstLogin) {
          return Left(FirstLoginFailure());
        } else {
          return Right(userEntity);
        }
      } else {
        return Left(LoginFailure(type: AuthFailureType.invalidCredentials));
      }
    } catch (e) {
      return Left(
        GeneralFailure(type: AuthFailureType.general, message: e.toString()),
      );
    }
  }

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
        return Left(GeneralFailure(type: AuthFailureType.userNotFound));
      }
    } catch (e) {
      return Left(
        GeneralFailure(type: AuthFailureType.general, message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logout(String userUuid) async {
    try {
      await localDataSource.logoutUser(userUuid);
      return const Right(null);
    } catch (error) {
      return Left(GeneralFailure(type: AuthFailureType.logoutFailed));
    }
  }

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
        password: password,
        role: role,
        isFirstLogin: true,
        loggedin: false,
        nickname: nickname,
      );
      await localDataSource.insertUser(newUser);
      return const Right(null);
    } catch (error) {
      return Left(
        GeneralFailure(
          type: AuthFailureType.addUserFailed,
          message: error.toString(),
        ),
      );
    }
  }
}
