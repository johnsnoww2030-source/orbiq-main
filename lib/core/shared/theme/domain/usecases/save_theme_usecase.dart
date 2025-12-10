import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';
import '../../../../utils/error/failures.dart';
import '../../../../utils/usecase/usecase.dart';

@injectable
class SaveThemeUseCase implements UseCase<void, ThemeEntity> {
  final ThemeRepository repository;

  SaveThemeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ThemeEntity params) {
    return repository.saveTheme(params);
  }
}
