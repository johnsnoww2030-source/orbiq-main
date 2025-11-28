import 'dart:async';
import 'package:orbiq/core/shared/localization/data/data_sources/local/language_dao.dart';
import 'package:orbiq/core/shared/localization/data/models/language_model.dart';
import 'package:orbiq/core/shared/product/data/data_source/local/product_dao.dart';
import 'package:orbiq/core/shared/product/data/models/product_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:orbiq/features/auth/data/data_sources/local/user_dao.dart';
import 'package:orbiq/features/auth/data/models/user_model.dart';
import 'package:orbiq/features/payment/data/data_sources/local/payment_dao.dart';
import 'package:orbiq/features/payment/data/model/payment_model.dart';
import 'package:orbiq/core/shared/theme/data/data_sources/local/theme_dao.dart';
import 'package:orbiq/core/shared/theme/data/models/theme_model.dart';

part 'database.g.dart';

@Database(version: 5, entities: [
  ProductModel,
  UserModel,
  PaymentModel,
  ThemeModel,
  LanguageModel,
])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
  UserDao get userDao;
  PaymentDao get paymentDao;
  ThemeDao get themeDao;
  LanguageDao get languageDao;
}
