import 'package:injectable/injectable.dart';
import 'package:orbiq/core/shared/localization/data/data_sources/local/language_dao.dart';
import 'package:orbiq/core/shared/localization/data/models/language_model.dart';
import 'package:orbiq/core/shared/localization/domain/entities/language_entity.dart';

@lazySingleton
class LanguageLocalDataSource {
  final LanguageDao languageDao;

  LanguageLocalDataSource(this.languageDao);

  Future<LanguageEntity> getLanguage() async {
    try {
      final languageModel = await languageDao.getLanguage();
      if (languageModel != null) {
        return _modelToEntity(languageModel);
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
      final languageModel = _entityToModel(language);
      final existingLanguage = await languageDao.getLanguage();

      if (existingLanguage != null) {
        await languageDao.updateLanguage(languageModel);
      } else {
        await languageDao.insertLanguage(languageModel);
      }
    } catch (e) {
      // خطا را لاگ می‌کنیم اما exception نمی‌اندازیم
      // ignore: avoid_print
      print('Failed to save language: $e');
    }
  }

  LanguageEntity _modelToEntity(LanguageModel model) {
    return LanguageEntity(
      code: model.code == 'fa' ? LanguageCode.fa : LanguageCode.en,
      name: model.name,
    );
  }

  LanguageModel _entityToModel(LanguageEntity entity) {
    return LanguageModel(
      code: entity.code.toString().split('.').last,
      name: entity.name,
    );
  }
}
