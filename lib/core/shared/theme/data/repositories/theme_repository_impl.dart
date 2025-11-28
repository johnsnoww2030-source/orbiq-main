import 'package:dartz/dartz.dart';
import '../data_sources/local/theme_local_data_source.dart';
import '../../domain/entities/theme_entity.dart';
import '../../domain/repositories/theme_repository.dart';
import '../../../../utils/error/failures.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, ThemeEntity>> getTheme() async {
    try {
      final theme = await localDataSource.getTheme();
      return Right(theme);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveTheme(ThemeEntity theme) async {
    try {
      await localDataSource.saveTheme(theme);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
