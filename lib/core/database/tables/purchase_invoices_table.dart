import 'package:drift/drift.dart';

/// Purchase Invoices table - for tracking purchases from suppliers
/// From PRD section 4.1
class PurchaseInvoices extends Table {
  TextColumn get purchaseUuid => text()();
  TextColumn get supplierName => text().nullable()();
  DateTimeColumn get purchaseDate => dateTime()();
  RealColumn get totalCost => real().withDefault(const Constant(0.0))();
  RealColumn get additionalCosts =>
      real().withDefault(const Constant(0.0))(); // Shipping, etc.
  RealColumn get finalTotal => real().withDefault(const Constant(0.0))();
  TextColumn get notes => text().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {purchaseUuid};
}
