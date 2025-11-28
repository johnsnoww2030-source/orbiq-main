import '../entities/theme_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../utils/error/failures.dart';

abstract class ThemeRepository {
  Future<Either<Failure, ThemeEntity>> getTheme();
  Future<Either<Failure, void>> saveTheme(ThemeEntity theme);
}
