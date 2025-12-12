import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/themes_table.dart';

part 'theme_dao.g.dart';

@DriftAccessor(tables: [Themes])
class ThemeDao extends DatabaseAccessor<AppDatabase> with _$ThemeDaoMixin {
  ThemeDao(super.db);

  /// Get current theme
  Future<Theme?> getCurrentTheme() {
    return (select(themes)..limit(1)).getSingleOrNull();
  }

  /// Watch current theme (reactive stream)
  Stream<Theme?> watchCurrentTheme() {
    return (select(themes)..limit(1)).watchSingleOrNull();
  }

  /// Insert theme
  Future<int> insertTheme(ThemesCompanion theme) {
    return into(themes).insert(theme);
  }

  /// Update theme type
  Future<int> updateThemeType(int id, String themeType) {
    return (update(themes)..where((t) => t.id.equals(id))).write(
      ThemesCompanion(themeType: Value(themeType)),
    );
  }

  /// Save or update theme (upsert)
  Future<void> saveTheme(String themeType) async {
    final existing = await getCurrentTheme();
    if (existing != null) {
      await updateThemeType(existing.id, themeType);
    } else {
      await insertTheme(ThemesCompanion.insert(themeType: themeType));
    }
  }
}
