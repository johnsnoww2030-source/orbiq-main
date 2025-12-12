/// LanguageModel for data layer operations
/// Maps between domain entities and Drift Language
class LanguageModel {
  final int id;
  final String code;
  final String name;

  LanguageModel({
    this.id = 1, // همیشه از ID 1 برای رکورد منفرد زبان استفاده می‌کنیم
    required this.code,
    required this.name,
  });
}
