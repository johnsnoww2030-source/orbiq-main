import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../failures/failure.dart';

@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute(
    String username,
    String password,
  ) {
    return repository.login(username, password);
  }
}
