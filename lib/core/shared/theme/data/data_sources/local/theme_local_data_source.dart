import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/theme_dao.dart';
import '../../../domain/entities/theme_entity.dart';

@lazySingleton
class ThemeLocalDataSource {
  final ThemeDao themeDao;

  ThemeLocalDataSource(this.themeDao);

  Future<ThemeEntity> getTheme() async {
    final theme = await themeDao.getCurrentTheme();
    if (theme != null) {
      return ThemeEntity(
        type: theme.themeType == 'dark' ? ThemeType.dark : ThemeType.light,
      );
    }
    // اگر تمی ذخیره نشده باشد، تم روشن را به عنوان پیش‌فرض برمی‌گرداند
    return const ThemeEntity(type: ThemeType.light);
  }

  Future<void> saveTheme(ThemeEntity theme) async {
    final themeType = theme.type == ThemeType.dark ? 'dark' : 'light';
    await themeDao.saveTheme(themeType);
  }
}
