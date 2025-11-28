// lib/core/shared/database/database.dart
// Add this to your existing database.dart file

import 'package:floor/floor.dart';
import 'package:orbiq/core/shared/localization/data/models/language_model.dart';

@dao
abstract class LanguageDao {
  @Query('SELECT * FROM LanguageModel LIMIT 1')
  Future<LanguageModel?> getLanguage();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertLanguage(LanguageModel language);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateLanguage(LanguageModel language);

  @Query('DELETE FROM LanguageModel')
  Future<void> deleteAllLanguages();
}
