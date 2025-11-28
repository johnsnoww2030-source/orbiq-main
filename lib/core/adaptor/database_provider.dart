// ignore_for_file: unused_local_variable

import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:orbiq/core/shared/database/database.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  late final AppDatabase database;
  final Completer<AppDatabase> _dbCompleter = Completer<AppDatabase>();

  factory DatabaseProvider() {
    return _instance;
  }

  DatabaseProvider._internal() {
    _initDatabase();
  }

  //final directory = await getApplicationSupportDirectory();
  Future<void> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'app_database.db');

    final migration1to2 = Migration(3, 4, (database) async {
      await database.execute('''
    CREATE TABLE IF NOT EXISTS payments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER NOT NULL,
      userNickname TEXT NOT NULL,
      totalPrice REAL NOT NULL,
      productDetails TEXT NOT NULL -- فیلد جدید برای ذخیره لیست محصولات به صورت JSON

    )
  ''');
    });

    final migration2to3 = Migration(2, 3, (database) async {
      await database.execute('''
    CREATE TABLE IF NOT EXISTS new_products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      serialNumber TEXT NOT NULL,
      description TEXT NOT NULL,
      brand TEXT NOT NULL,
      model TEXT NOT NULL,
      color TEXT NOT NULL,
      material TEXT NOT NULL,
      purchaseDate INTEGER NOT NULL,
      originalPrice REAL NOT NULL,
      discountedPrice REAL NOT NULL,
      discountStartDate INTEGER,
      discountEndDate INTEGER,
      currentStock INTEGER NOT NULL,
      reorderPoint INTEGER NOT NULL,
      lastStockUpdate INTEGER NOT NULL,
      serialNumber TEXT NOT NULL
    )
  ''');

      await database.execute('''
    INSERT INTO new_products (id, name, serialNumber, description, brand, model, color, material, purchaseDate, originalPrice, discountedPrice, discountStartDate, discountEndDate, currentStock, reorderPoint, lastStockUpdate, serialNumber)
    SELECT id, name, serialNumber, description, brand, model, color, material, purchaseDate, originalPrice, discountedPrice, discountStartDate, discountEndDate, currentStock, reorderPoint, lastStockUpdate, serialNumber FROM products
  ''');

      await database.execute('DROP TABLE products');

      await database.execute('ALTER TABLE new_products RENAME TO products');
    });
    final migration3to4 = Migration(3, 4, (database) async {
      await database.execute('''
        ALTER TABLE payments ADD COLUMN paymentDateTime INTEGER NOT NULL DEFAULT 0
      ''');
    });

    final migration4To5 = Migration(4, 5, (database) async {
      // ایجاد جدول تم
      await database.execute('''
    CREATE TABLE IF NOT EXISTS ThemeModel (
      id INTEGER PRIMARY KEY NOT NULL,
      themeType TEXT NOT NULL
    )
  ''');

      // درج مقدار پیش‌فرض برای تم (تم روشن)
      await database.execute('''
    INSERT INTO ThemeModel (id, themeType)
    VALUES (1, 'light')
  ''');
    });

    final Migration migration5to6 = Migration(5, 6, (database) async {
      await database.execute(
        'CREATE TABLE IF NOT EXISTS LanguageModel (id INTEGER PRIMARY KEY NOT NULL, code TEXT NOT NULL, name TEXT NOT NULL)',
      );
    });

    final db = await $FloorAppDatabase.databaseBuilder(path).addMigrations([
      // migration1to2,
      // migration2to3,
      // migration3to4 // Add the new migration
      // migration4To5
      migration5to6,
    ]).build();

    database = db;
    _dbCompleter.complete(db);
  }

  Future<AppDatabase> get databaseInstance => _dbCompleter.future;
}
