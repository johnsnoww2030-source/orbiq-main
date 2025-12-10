import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/adaptor/database_provider.dart';
import 'package:orbiq/core/shared/database/database.dart';
import 'package:orbiq/core/shared/product/data/data_source/local/product_dao.dart';
import 'package:orbiq/features/auth/data/data_sources/local/user_dao.dart';
import 'package:orbiq/features/payment/data/data_sources/local/payment_dao.dart';
import 'package:orbiq/core/shared/theme/data/data_sources/local/theme_dao.dart';
import 'package:orbiq/core/shared/localization/data/data_sources/local/language_dao.dart';

/// Module for registering external dependencies (Dio, Database, DAOs)
@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<AppDatabase> get database => DatabaseProvider().databaseInstance;

  @lazySingleton
  Dio get dio => Dio();

  // DAOs from database
  @lazySingleton
  ProductDao productDao(AppDatabase db) => db.productDao;

  @lazySingleton
  UserDao userDao(AppDatabase db) => db.userDao;

  @lazySingleton
  PaymentDao paymentDao(AppDatabase db) => db.paymentDao;

  @lazySingleton
  ThemeDao themeDao(AppDatabase db) => db.themeDao;

  @lazySingleton
  LanguageDao languageDao(AppDatabase db) => db.languageDao;
}
