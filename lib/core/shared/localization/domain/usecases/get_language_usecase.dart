import 'package:dartz/dartz.dart';
import 'package:orbiq/core/shared/localization/domain/entities/language_entity.dart';
import 'package:orbiq/core/shared/localization/domain/repositories/language_repository.dart';

class GetLanguageUseCase {
  final LanguageRepository repository;

  GetLanguageUseCase(this.repository);

  Future<Either<Exception, LanguageEntity>> call() async {
    return await repository.getLanguage();
  }
}
