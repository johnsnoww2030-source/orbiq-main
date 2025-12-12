import 'package:drift/drift.dart';

/// Languages table definition for Drift
/// Replaces the Floor LanguageModel entity
class Languages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()(); // 'fa', 'en', 'ar'
  TextColumn get name => text()(); // Language display name
}
