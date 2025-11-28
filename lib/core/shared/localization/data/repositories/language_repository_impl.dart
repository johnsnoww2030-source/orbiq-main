import 'package:dartz/dartz.dart';
import 'package:orbiq/core/shared/localization/data/data_sources/local/language_local_data_source.dart';
import 'package:orbiq/core/shared/localization/domain/entities/language_entity.dart';
import 'package:orbiq/core/shared/localization/domain/repositories/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageLocalDataSource localDataSource;

  LanguageRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Exception, LanguageEntity>> getLanguage() async {
    try {
      final language = await localDataSource.getLanguage();
      return Right(language);
    } catch (e) {
      return Left(Exception('Failed to get language: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> saveLanguage(LanguageEntity language) async {
    try {
      await localDataSource.saveLanguage(language);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to save language: $e'));
    }
  }
}
