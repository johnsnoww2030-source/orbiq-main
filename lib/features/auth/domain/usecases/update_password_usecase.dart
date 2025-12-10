import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../failures/failure.dart';
import '../repositories/auth_repository.dart';

@injectable
class UpdatePasswordUseCase {
  final AuthRepository repository;

  UpdatePasswordUseCase(this.repository);

  Future<Either<Failure, void>> execute(String username, String newPassword) {
    return repository.updatePasswordForFirstLogin(username, newPassword);
  }
}
