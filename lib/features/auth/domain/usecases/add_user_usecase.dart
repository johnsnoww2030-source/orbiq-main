// add_user_usecase.dart
import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../failures/failure.dart';

class AddUserUseCase {
  final AuthRepository authRepository;

  AddUserUseCase(this.authRepository);

  Future<Either<Failure, void>> execute(String username, String password, String role, String nickname) {
    return authRepository.addUser(
      username: username,
      password: password,
      nickname: nickname,
      role: role,
    );
  }
}
