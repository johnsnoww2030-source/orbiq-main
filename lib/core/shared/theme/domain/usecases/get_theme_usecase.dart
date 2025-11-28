import 'package:dartz/dartz.dart';
import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';
import '../../../../utils/error/failures.dart';
import '../../../../utils/usecase/usecase.dart';

class GetThemeUseCase implements UseCase<ThemeEntity, NoParams> {
  final ThemeRepository repository;

  GetThemeUseCase(this.repository);

  @override
  Future<Either<Failure, ThemeEntity>> call(NoParams params) {
    return repository.getTheme();
  }
}
