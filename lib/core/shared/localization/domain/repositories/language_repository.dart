// lib/core/shared/localization/domain/repositories/language_repository.dart
import 'package:dartz/dartz.dart';
import 'package:orbiq/core/shared/localization/domain/entities/language_entity.dart';

abstract class LanguageRepository {
  Future<Either<Exception, LanguageEntity>> getLanguage();
  Future<Either<Exception, void>> saveLanguage(LanguageEntity language);
}
