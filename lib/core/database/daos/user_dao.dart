import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/users_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  /// Get all users
  Future<List<User>> getAllUsers() => select(users).get();

  /// Get user by UUID
  Future<User?> getUserByUuid(String uuid) {
    return (select(
      users,
    )..where((u) => u.userUuid.equals(uuid))).getSingleOrNull();
  }

  /// Get user by username
  Future<User?> getUserByUsername(String username) {
    return (select(
      users,
    )..where((u) => u.username.equals(username))).getSingleOrNull();
  }

  /// Insert a new user
  Future<int> insertUser(UsersCompanion user) {
    return into(users).insert(user);
  }

  /// Update an existing user
  Future<bool> updateUser(User user) {
    return update(users).replace(user);
  }

  /// Update login status
  Future<int> updateLoginStatus(String uuid, bool loggedIn) {
    return (update(users)..where((u) => u.userUuid.equals(uuid))).write(
      UsersCompanion(
        loggedIn: Value(loggedIn),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update password
  Future<int> updatePassword(String uuid, String newPassword) {
    return (update(users)..where((u) => u.userUuid.equals(uuid))).write(
      UsersCompanion(
        password: Value(newPassword),
        isFirstLogin: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Delete a user by UUID
  Future<int> deleteUser(String uuid) {
    return (delete(users)..where((u) => u.userUuid.equals(uuid))).go();
  }

  /// Get logged in user
  Future<User?> getLoggedInUser() {
    return (select(
      users,
    )..where((u) => u.loggedIn.equals(true))).getSingleOrNull();
  }
}
