import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/sales_invoices_table.dart';
import '../tables/sales_items_table.dart';

part 'sales_dao.g.dart';

@DriftAccessor(tables: [SalesInvoices, SalesItems])
class SalesDao extends DatabaseAccessor<AppDatabase> with _$SalesDaoMixin {
  SalesDao(super.db);

  // === Invoice operations ===

  /// Get all sales invoices
  Future<List<SalesInvoice>> getAllInvoices() => select(salesInvoices).get();

  /// Watch all sales invoices (reactive stream)
  Stream<List<SalesInvoice>> watchAllInvoices() =>
      select(salesInvoices).watch();

  /// Get invoice by UUID
  Future<SalesInvoice?> getInvoiceByUuid(String uuid) {
    return (select(
      salesInvoices,
    )..where((i) => i.invoiceUuid.equals(uuid))).getSingleOrNull();
  }

  /// Insert a new invoice
  Future<int> insertInvoice(SalesInvoicesCompanion invoice) {
    return into(salesInvoices).insert(invoice);
  }

  /// Update an existing invoice
  Future<bool> updateInvoice(SalesInvoice invoice) {
    return update(salesInvoices).replace(invoice);
  }

  /// Update invoice status
  Future<int> updateStatus(String uuid, String status) {
    return (update(
      salesInvoices,
    )..where((i) => i.invoiceUuid.equals(uuid))).write(
      SalesInvoicesCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Delete an invoice by UUID
  Future<int> deleteInvoice(String uuid) {
    return (delete(
      salesInvoices,
    )..where((i) => i.invoiceUuid.equals(uuid))).go();
  }

  // === Item operations ===

  /// Get items by invoice UUID
  Future<List<SalesItem>> getItemsByInvoiceUuid(String invoiceUuid) {
    return (select(
      salesItems,
    )..where((i) => i.invoiceUuid.equals(invoiceUuid))).get();
  }

  /// Insert a sales item
  Future<int> insertItem(SalesItemsCompanion item) {
    return into(salesItems).insert(item);
  }

  /// Insert invoice with items (transaction)
  Future<void> insertInvoiceWithItems(
    SalesInvoicesCompanion invoice,
    List<SalesItemsCompanion> items,
  ) async {
    await transaction(() async {
      await into(salesInvoices).insert(invoice);
      for (final item in items) {
        await into(salesItems).insert(item);
      }
    });
  }

  // === Reports ===

  /// Get today's sales
  Future<List<SalesInvoice>> getTodaySales() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(
      salesInvoices,
    )..where((i) => i.invoiceDate.isBetweenValues(startOfDay, endOfDay))).get();
  }

  /// Get total revenue
  Future<double> getTotalRevenue() async {
    final all = await select(salesInvoices).get();
    return all.fold<double>(
      0.0,
      (double sum, invoice) => sum + invoice.totalAmount,
    );
  }

  /// Get total profit from items
  Future<double> getTotalProfit() async {
    final all = await select(salesItems).get();
    return all.fold<double>(0.0, (double sum, item) => sum + item.profit);
  }
}
