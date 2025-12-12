import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/languages_table.dart';

part 'language_dao.g.dart';

@DriftAccessor(tables: [Languages])
class LanguageDao extends DatabaseAccessor<AppDatabase>
    with _$LanguageDaoMixin {
  LanguageDao(super.db);

  /// Get all languages
  Future<List<Language>> getAllLanguages() => select(languages).get();

  /// Get current language (first one)
  Future<Language?> getCurrentLanguage() {
    return (select(languages)..limit(1)).getSingleOrNull();
  }

  /// Watch current language (reactive stream)
  Stream<Language?> watchCurrentLanguage() {
    return (select(languages)..limit(1)).watchSingleOrNull();
  }

  /// Get language by code
  Future<Language?> getLanguageByCode(String code) {
    return (select(
      languages,
    )..where((l) => l.code.equals(code))).getSingleOrNull();
  }

  /// Insert language
  Future<int> insertLanguage(LanguagesCompanion language) {
    return into(languages).insert(language);
  }

  /// Update language
  Future<int> updateLanguage(int id, String code, String name) {
    return (update(languages)..where((l) => l.id.equals(id))).write(
      LanguagesCompanion(code: Value(code), name: Value(name)),
    );
  }

  /// Delete all and insert new (replace language)
  Future<void> saveLanguage(String code, String name) async {
    await delete(languages).go();
    await insertLanguage(LanguagesCompanion.insert(code: code, name: name));
  }
}
