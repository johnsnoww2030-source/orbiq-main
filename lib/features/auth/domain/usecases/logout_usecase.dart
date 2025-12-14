import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';
import '../failures/failure.dart';

@injectable
class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  /// اجرای خروج با استفاده از uuid
  Future<Either<Failure, void>> execute(String userUuid) async {
    return await authRepository.logout(userUuid);
  }
}
