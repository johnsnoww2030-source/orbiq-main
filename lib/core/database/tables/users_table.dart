import 'package:drift/drift.dart';

/// Users table definition for Drift
/// Replaces the Floor UserModel entity
class Users extends Table {
  // UUID as primary key instead of auto-increment int
  TextColumn get userUuid => text()();

  TextColumn get username => text().unique()();
  TextColumn get password => text()();
  TextColumn get role => text()();
  TextColumn get nickname => text()();

  BoolColumn get isFirstLogin => boolean().withDefault(const Constant(true))();
  BoolColumn get loggedIn => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {userUuid};
}
