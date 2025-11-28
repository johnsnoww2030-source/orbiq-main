import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../failures/failure.dart';

class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<Either<Failure, void>> execute(int userId) async {
    // فراخوانی مخزن و دریافت نتیجه (موفقیت یا خطا)
    return await authRepository.logout(userId);
  }
}
