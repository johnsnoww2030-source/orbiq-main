import 'package:injectable/injectable.dart';
import '../../models/theme_model.dart';
import 'theme_dao.dart';
import '../../../domain/entities/theme_entity.dart';

@lazySingleton
class ThemeLocalDataSource {
  final ThemeDao themeDao;

  ThemeLocalDataSource(this.themeDao);

  Future<ThemeEntity> getTheme() async {
    final themeModel = await themeDao.getTheme();
    if (themeModel != null) {
      return themeModel.toEntity();
    }
    // اگر تمی ذخیره نشده باشد، تم روشن را به عنوان پیش‌فرض برمی‌گرداند
    return const ThemeEntity(type: ThemeType.light);
  }

  Future<void> saveTheme(ThemeEntity theme) async {
    final themeModel = ThemeModel.fromEntity(theme);
    await themeDao.saveTheme(themeModel);
  }
}
