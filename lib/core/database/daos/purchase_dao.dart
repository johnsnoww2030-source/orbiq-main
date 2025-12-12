import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/purchase_invoices_table.dart';
import '../tables/purchase_items_table.dart';

part 'purchase_dao.g.dart';

@DriftAccessor(tables: [PurchaseInvoices, PurchaseItems])
class PurchaseDao extends DatabaseAccessor<AppDatabase>
    with _$PurchaseDaoMixin {
  PurchaseDao(super.db);

  // === Invoice operations ===

  /// Get all purchase invoices
  Future<List<PurchaseInvoice>> getAllInvoices() =>
      select(purchaseInvoices).get();

  /// Watch all purchase invoices (reactive stream)
  Stream<List<PurchaseInvoice>> watchAllInvoices() =>
      select(purchaseInvoices).watch();

  /// Get invoice by UUID
  Future<PurchaseInvoice?> getInvoiceByUuid(String uuid) {
    return (select(
      purchaseInvoices,
    )..where((i) => i.purchaseUuid.equals(uuid))).getSingleOrNull();
  }

  /// Insert a new invoice
  Future<int> insertInvoice(PurchaseInvoicesCompanion invoice) {
    return into(purchaseInvoices).insert(invoice);
  }

  /// Update an existing invoice
  Future<bool> updateInvoice(PurchaseInvoice invoice) {
    return update(purchaseInvoices).replace(invoice);
  }

  /// Delete an invoice by UUID
  Future<int> deleteInvoice(String uuid) {
    return (delete(
      purchaseInvoices,
    )..where((i) => i.purchaseUuid.equals(uuid))).go();
  }

  // === Item operations ===

  /// Get items by purchase UUID
  Future<List<PurchaseItem>> getItemsByPurchaseUuid(String purchaseUuid) {
    return (select(
      purchaseItems,
    )..where((i) => i.purchaseUuid.equals(purchaseUuid))).get();
  }

  /// Insert a purchase item
  Future<int> insertItem(PurchaseItemsCompanion item) {
    return into(purchaseItems).insert(item);
  }

  /// Insert invoice with items (transaction)
  Future<void> insertInvoiceWithItems(
    PurchaseInvoicesCompanion invoice,
    List<PurchaseItemsCompanion> items,
  ) async {
    await transaction(() async {
      await into(purchaseInvoices).insert(invoice);
      for (final item in items) {
        await into(purchaseItems).insert(item);
      }
    });
  }
}
