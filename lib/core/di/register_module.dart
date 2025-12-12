import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/core/database/daos/user_dao.dart';
import 'package:orbiq/core/database/daos/theme_dao.dart';
import 'package:orbiq/core/database/daos/language_dao.dart';
import 'package:orbiq/core/database/daos/sales_dao.dart';
import 'package:orbiq/core/database/daos/purchase_dao.dart';
import 'package:orbiq/core/database/daos/event_dao.dart';

/// Module for registering external dependencies (Dio, Database, DAOs)
@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<AppDatabase> get database async => AppDatabase();

  @lazySingleton
  Dio get dio => Dio();

  // Core DAOs
  @lazySingleton
  ProductDao productDao(AppDatabase db) => db.productDao;

  @lazySingleton
  UserDao userDao(AppDatabase db) => db.userDao;

  @lazySingleton
  ThemeDao themeDao(AppDatabase db) => db.themeDao;

  @lazySingleton
  LanguageDao languageDao(AppDatabase db) => db.languageDao;

  // PRD DAOs
  @lazySingleton
  SalesDao salesDao(AppDatabase db) => db.salesDao;

  @lazySingleton
  PurchaseDao purchaseDao(AppDatabase db) => db.purchaseDao;

  @lazySingleton
  EventDao eventDao(AppDatabase db) => db.eventDao;
}
