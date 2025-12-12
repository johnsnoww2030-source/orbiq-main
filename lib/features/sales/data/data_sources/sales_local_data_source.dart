import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/sales_dao.dart';
import 'package:orbiq/features/sales/data/mappers/sales_mapper.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';

/// Local data source for Sales operations
@injectable
class SalesLocalDataSource {
  final SalesDao _salesDao;

  SalesLocalDataSource(this._salesDao);

  /// Get all sales invoices with items
  Future<List<SalesEntity>> getAllSales() async {
    final invoices = await _salesDao.getAllInvoices();
    final List<SalesEntity> sales = [];

    for (final invoice in invoices) {
      final items = await _salesDao.getItemsByInvoiceUuid(invoice.invoiceUuid);
      final itemEntities = items
          .map((i) => SalesMapper.itemFromDrift(i))
          .toList();
      sales.add(SalesMapper.fromDrift(invoice, itemEntities));
    }

    return sales;
  }

  /// Get sale by UUID with items
  Future<SalesEntity?> getSaleByUuid(String uuid) async {
    final invoice = await _salesDao.getInvoiceByUuid(uuid);
    if (invoice == null) return null;

    final items = await _salesDao.getItemsByInvoiceUuid(uuid);
    final itemEntities = items
        .map((i) => SalesMapper.itemFromDrift(i))
        .toList();
    return SalesMapper.fromDrift(invoice, itemEntities);
  }

  /// Insert sale with items
  Future<String> insertSaleWithItems(SalesEntity sale) async {
    final companion = SalesMapper.toCompanion(sale);
    final invoiceUuid = companion.invoiceUuid.value;

    final itemCompanions = sale.items
        .map((item) => SalesMapper.itemToCompanion(item, invoiceUuid))
        .toList();

    await _salesDao.insertInvoiceWithItems(companion, itemCompanions);
    return invoiceUuid;
  }

  /// Get today's sales
  Future<List<SalesEntity>> getTodaySales() async {
    final invoices = await _salesDao.getTodaySales();
    final List<SalesEntity> sales = [];

    for (final invoice in invoices) {
      final items = await _salesDao.getItemsByInvoiceUuid(invoice.invoiceUuid);
      final itemEntities = items
          .map((i) => SalesMapper.itemFromDrift(i))
          .toList();
      sales.add(SalesMapper.fromDrift(invoice, itemEntities));
    }

    return sales;
  }

  /// Update sale status
  Future<void> updateStatus(String uuid, String status) async {
    await _salesDao.updateStatus(uuid, status);
  }

  /// Delete sale
  Future<void> deleteSale(String uuid) async {
    await _salesDao.deleteInvoice(uuid);
  }

  /// Get total revenue
  Future<double> getTotalRevenue() => _salesDao.getTotalRevenue();

  /// Get total profit
  Future<double> getTotalProfit() => _salesDao.getTotalProfit();

  /// Watch all sales
  Stream<List<SalesEntity>> watchAllSales() {
    return _salesDao.watchAllInvoices().asyncMap((invoices) async {
      final List<SalesEntity> sales = [];
      for (final invoice in invoices) {
        final items = await _salesDao.getItemsByInvoiceUuid(
          invoice.invoiceUuid,
        );
        final itemEntities = items
            .map((i) => SalesMapper.itemFromDrift(i))
            .toList();
        sales.add(SalesMapper.fromDrift(invoice, itemEntities));
      }
      return sales;
    });
  }
}
