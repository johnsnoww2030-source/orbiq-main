import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';
import '../failures/failure.dart';

@injectable
class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<Either<Failure, void>> execute(int userId) async {
    // فراخوانی مخزن و دریافت نتیجه (موفقیت یا خطا)
    return await authRepository.logout(userId);
  }
}
