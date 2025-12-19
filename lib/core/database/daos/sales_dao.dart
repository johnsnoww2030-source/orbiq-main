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

  /// Get sales items in date range (Phase 2)
  Future<List<SalesItem>> getSalesItemsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    // Get invoices in range first
    final invoices = await getSalesInDateRange(startDate, endDate);

    // Get all items for those invoices
    final List<SalesItem> allItems = [];
    for (final invoice in invoices) {
      final items = await getItemsByInvoiceUuid(invoice.invoiceUuid);
      allItems.addAll(items);
    }
    return allItems;
  }

  /// Get sales items by invoice (Phase 2)
  Future<List<SalesItem>> getSalesItemsByInvoice(String invoiceUuid) {
    return getItemsByInvoiceUuid(invoiceUuid);
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

  // === Report Methods ===

  /// Get sales invoices in date range
  Future<List<SalesInvoice>> getSalesInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return (select(
      salesInvoices,
    )..where((i) => i.invoiceDate.isBetweenValues(startDate, endDate))).get();
  }

  /// Get total revenue in date range
  Future<double> getRevenueInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final invoices = await getSalesInDateRange(startDate, endDate);
    return invoices.fold<double>(0.0, (sum, inv) => sum + inv.totalAmount);
  }

  /// Get total profit in date range
  Future<double> getProfitInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final invoices = await getSalesInDateRange(startDate, endDate);
    double totalProfit = 0.0;
    for (final invoice in invoices) {
      final items = await getItemsByInvoiceUuid(invoice.invoiceUuid);
      totalProfit += items.fold<double>(0.0, (sum, item) => sum + item.profit);
    }
    return totalProfit;
  }

  /// Get sales count in date range
  Future<int> getSalesCountInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final invoices = await getSalesInDateRange(startDate, endDate);
    return invoices.length;
  }

  /// Get top selling products
  Future<List<Map<String, dynamic>>> getTopSellingProducts(int limit) async {
    final allItems = await select(salesItems).get();

    // Group by product, sum quantity and revenue
    final Map<String, Map<String, dynamic>> productMap = {};
    for (final item in allItems) {
      final key = item.productUuid;
      if (productMap.containsKey(key)) {
        productMap[key]!['quantity'] += item.quantity;
        productMap[key]!['revenue'] += item.totalPrice;
        productMap[key]!['profit'] += item.profit;
      } else {
        productMap[key] = {
          'productUuid': key,
          'quantity': item.quantity,
          'revenue': item.totalPrice,
          'profit': item.profit,
        };
      }
    }

    // Sort by quantity and take top N
    final sorted = productMap.values.toList()
      ..sort((a, b) => (b['quantity'] as int).compareTo(a['quantity'] as int));

    return sorted.take(limit).toList();
  }

  /// Get daily sales for chart (grouped by day)
  Future<List<Map<String, dynamic>>> getDailySales(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final invoices = await getSalesInDateRange(startDate, endDate);

    // Group by day
    final Map<String, Map<String, dynamic>> dailyMap = {};
    for (final invoice in invoices) {
      final dayKey =
          '${invoice.invoiceDate.year}-${invoice.invoiceDate.month.toString().padLeft(2, '0')}-${invoice.invoiceDate.day.toString().padLeft(2, '0')}';
      if (dailyMap.containsKey(dayKey)) {
        dailyMap[dayKey]!['revenue'] += invoice.totalAmount;
        dailyMap[dayKey]!['count'] += 1;
      } else {
        dailyMap[dayKey] = {
          'date': invoice.invoiceDate,
          'revenue': invoice.totalAmount,
          'count': 1,
        };
      }
    }

    // Sort by date
    final sorted = dailyMap.values.toList()
      ..sort(
        (a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime),
      );

    return sorted;
  }
}
