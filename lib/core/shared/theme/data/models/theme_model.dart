import 'package:floor/floor.dart';
import '../../domain/entities/theme_entity.dart';

@entity
class ThemeModel {
  @PrimaryKey(autoGenerate: false)
  final int id;
  final String themeType;

  ThemeModel({
    required this.id,
    required this.themeType,
  });

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
