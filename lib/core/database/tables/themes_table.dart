import 'package:drift/drift.dart';

/// Themes table definition for Drift
/// Replaces the Floor ThemeModel entity
class Themes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get themeType => text()(); // 'light' or 'dark'
}
