import 'package:floor/floor.dart';
import '../../models/theme_model.dart';

@dao
abstract class ThemeDao {
  @Query('SELECT * FROM ThemeModel WHERE id = 1')
  Future<ThemeModel?> getTheme();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveTheme(ThemeModel theme);
}
