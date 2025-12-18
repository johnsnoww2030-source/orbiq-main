import 'package:drift/drift.dart';
import 'purchase_invoices_table.dart';
import 'products_table.dart';

/// Purchase Items table - line items for each purchase
/// From PRD section 4.2
class PurchaseItems extends Table {
  TextColumn get itemUuid => text()();
  TextColumn get purchaseUuid =>
      text().references(PurchaseInvoices, #purchaseUuid)();
  TextColumn get productUuid => text().references(Products, #productUuid)();
  IntColumn get quantity => integer()();
  RealColumn get unitBuyPrice => real()();
  RealColumn get totalPrice => real()();

  // Phase 2: Currency fields
  TextColumn get currencyCode => text().withDefault(const Constant('IRR'))();
  RealColumn get exchangeRateAtPurchase => real().nullable()(); // 🔒 Immutable
  RealColumn get costInBaseCurrency => real().nullable()();

  @override
  Set<Column> get primaryKey => {itemUuid};
}
