import 'package:floor/floor.dart';

@entity
class LanguageModel {
  @primaryKey
  final int id;
  final String code;
  final String name;

  LanguageModel({
    this.id = 1, // همیشه از ID 1 برای رکورد منفرد زبان استفاده می‌کنیم
    required this.code,
    required this.name,
  });
}
