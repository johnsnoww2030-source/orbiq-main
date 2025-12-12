import '../../domain/entities/theme_entity.dart';

/// ThemeModel for data layer operations
/// Maps between ThemeEntity (domain) and Drift Theme (data)
class ThemeModel {
  final int id;
  final String themeType;

  ThemeModel({required this.id, required this.themeType});

  factory ThemeModel.fromEntity(ThemeEntity entity) {
    return ThemeModel(
      id: 1, // همیشه یک رکورد داریم
      themeType: entity.type.toString().split('.').last,
    );
  }

  ThemeEntity toEntity() {
    return ThemeEntity(
      type: themeType == 'dark' ? ThemeType.dark : ThemeType.light,
    );
  }
}
