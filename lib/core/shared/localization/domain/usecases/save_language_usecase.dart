import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/shared/localization/domain/entities/language_entity.dart';
import 'package:orbiq/core/shared/localization/domain/repositories/language_repository.dart';

@injectable
class SaveLanguageUseCase {
  final LanguageRepository repository;

  SaveLanguageUseCase(this.repository);

  Future<Either<Exception, void>> call(LanguageEntity language) async {
    return await repository.saveLanguage(language);
  }
}
