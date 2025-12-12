import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/language_dao.dart';
import 'package:orbiq/core/shared/localization/domain/entities/language_entity.dart';

@lazySingleton
class LanguageLocalDataSource {
  final LanguageDao languageDao;

  LanguageLocalDataSource(this.languageDao);

  Future<LanguageEntity> getLanguage() async {
    try {
      final language = await languageDao.getCurrentLanguage();
      if (language != null) {
        return LanguageEntity(
          code: language.code == 'fa' ? LanguageCode.fa : LanguageCode.en,
          name: language.name,
        );
      } else {
        // اگر زبانی تنظیم نشده باشد، به طور پیش‌فرض فارسی را برمی‌گرداند
        final defaultLanguage = LanguageEntity.persian();
        await saveLanguage(defaultLanguage);
        return defaultLanguage;
      }
    } catch (e) {
      // در صورت خطا، زبان پیش‌فرض را برمی‌گرداند
      return LanguageEntity.persian();
    }
  }

  Future<void> saveLanguage(LanguageEntity language) async {
    try {
      final code = language.code.toString().split('.').last;
      await languageDao.saveLanguage(code, language.name);
    } catch (e) {
      // خطا را لاگ می‌کنیم اما exception نمی‌اندازیم
      // ignore: avoid_print
      print('Failed to save language: $e');
    }
  }
}
