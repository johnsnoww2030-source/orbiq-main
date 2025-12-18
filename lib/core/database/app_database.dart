import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Tables
import 'tables/products_table.dart';
import 'tables/users_table.dart';
import 'tables/themes_table.dart';
import 'tables/languages_table.dart';
// PRD Tables
import 'tables/sales_invoices_table.dart';
import 'tables/sales_items_table.dart';
import 'tables/purchase_invoices_table.dart';
import 'tables/purchase_items_table.dart';
import 'tables/events_table.dart';
// Phase 2 Tables
import 'tables/exchange_rate_events_table.dart';
import 'tables/pricing_settings_table.dart';

// DAOs
import 'daos/product_dao.dart';
import 'daos/user_dao.dart';
import 'daos/theme_dao.dart';
import 'daos/language_dao.dart';
// PRD DAOs
import 'daos/sales_dao.dart';
import 'daos/purchase_dao.dart';
import 'daos/event_dao.dart';
// Phase 2 DAOs
import 'daos/exchange_rate_dao.dart';
import 'daos/pricing_settings_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    // Core tables
    Products,
    Users,
    Themes,
    Languages,
    // PRD tables
    SalesInvoices,
    SalesItems,
    PurchaseInvoices,
    PurchaseItems,
    Events,
    // Phase 2 tables
    ExchangeRateEvents,
    PricingSettings,
  ],
  daos: [
    // Core DAOs
    ProductDao,
    UserDao,
    ThemeDao,
    LanguageDao,
    // PRD DAOs
    SalesDao,
    PurchaseDao,
    EventDao,
    // Phase 2 DAOs
    ExchangeRateDao,
    PricingSettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Insert default theme
        await into(themes).insert(ThemesCompanion.insert(themeType: 'light'));
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Future migrations will go here
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'orbiq_drift.db'));
    return NativeDatabase.createInBackground(file);
  });
}
