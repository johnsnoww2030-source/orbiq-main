import 'package:drift/drift.dart';
import 'sales_invoices_table.dart';
import 'products_table.dart';

/// Sales Items table - line items for each sale
/// From PRD section 4.4
class SalesItems extends Table {
  TextColumn get itemUuid => text()();
  TextColumn get invoiceUuid =>
      text().references(SalesInvoices, #invoiceUuid)();
  TextColumn get productUuid => text().references(Products, #productUuid)();
  IntColumn get quantity => integer()();
  RealColumn get unitSellPrice => real()();
  RealColumn get costAtSale =>
      real()(); // Cost price at time of sale for profit calculation
  RealColumn get totalPrice => real()();
  RealColumn get profit => real()();

  // Phase 2: Enhanced profit calculation with currency tracking
  RealColumn get exchangeRateAtSale => real().nullable()(); // 🔒 Immutable
  RealColumn get costExchangeRate => real().nullable()(); // 🔒 Immutable
  RealColumn get profitIrr => real().nullable()(); // 🔒 Immutable
  // Note: profitUSD is computed, not stored: profitUSD = profitIRR / exchangeRateAtSale

  @override
  Set<Column> get primaryKey => {itemUuid};
}
