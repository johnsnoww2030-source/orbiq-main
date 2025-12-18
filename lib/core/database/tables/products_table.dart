import 'package:drift/drift.dart';

/// Products table definition for Drift
/// Replaces the Floor ProductModel entity
class Products extends Table {
  // UUID as primary key instead of auto-increment int
  TextColumn get productUuid => text()();

  TextColumn get name => text()();
  TextColumn get serialNumber => text().unique()();
  TextColumn get description => text()();
  TextColumn get brand => text()();
  TextColumn get model => text()();
  TextColumn get color => text()();
  TextColumn get material => text()();

  // Store as DateTime directly (Drift handles conversion)
  DateTimeColumn get purchaseDate => dateTime()();

  RealColumn get originalPrice => real()();
  RealColumn get discountedPrice => real()();
  DateTimeColumn get discountStartDate => dateTime().nullable()();
  DateTimeColumn get discountEndDate => dateTime().nullable()();

  IntColumn get currentStock => integer().withDefault(const Constant(0))();
  IntColumn get reorderPoint => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastStockUpdate => dateTime()();

  // New fields from PRD
  RealColumn get avgBuyPrice => real().withDefault(const Constant(0.0))();
  IntColumn get minMarginPercent => integer().withDefault(const Constant(20))();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  // Phase 2: Currency and pricing fields
  TextColumn get baseCurrencyCode =>
      text().withDefault(const Constant('IRR'))();
  RealColumn get costExchangeRate => real().nullable()();
  RealColumn get minPrice => real().nullable()();
  RealColumn get sellingPrice => real().nullable()();
  RealColumn get maxPrice => real().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {productUuid};
}
