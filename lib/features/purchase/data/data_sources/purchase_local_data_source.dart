import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/purchase_dao.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/features/purchase/data/mappers/purchase_mapper.dart';
import 'package:orbiq/features/purchase/domain/entities/purchase_entity.dart';

/// Local data source for Purchase operations - wraps PurchaseDao
@injectable
class PurchaseLocalDataSource {
  final PurchaseDao _purchaseDao;
  final ProductDao _productDao;

  PurchaseLocalDataSource(this._purchaseDao, this._productDao);

  /// Get all purchases
  Future<List<PurchaseEntity>> getAllPurchases() async {
    final invoices = await _purchaseDao.getAllInvoices();
    final List<PurchaseEntity> purchases = [];

    for (final invoice in invoices) {
      final items = await _purchaseDao.getItemsByPurchaseUuid(
        invoice.purchaseUuid,
      );
      final itemEntities = await _mapItemsWithProductNames(items);
      purchases.add(PurchaseMapper.fromDrift(invoice, itemEntities));
    }

    return purchases;
  }

  /// Watch all purchases (reactive stream)
  Stream<List<PurchaseEntity>> watchAllPurchases() {
    return _purchaseDao.watchAllInvoices().asyncMap((invoices) async {
      final List<PurchaseEntity> purchases = [];
      for (final invoice in invoices) {
        final items = await _purchaseDao.getItemsByPurchaseUuid(
          invoice.purchaseUuid,
        );
        final itemEntities = await _mapItemsWithProductNames(items);
        purchases.add(PurchaseMapper.fromDrift(invoice, itemEntities));
      }
      return purchases;
    });
  }

  /// Get purchase by UUID
  Future<PurchaseEntity?> getPurchaseByUuid(String uuid) async {
    final invoice = await _purchaseDao.getInvoiceByUuid(uuid);
    if (invoice == null) return null;

    final items = await _purchaseDao.getItemsByPurchaseUuid(uuid);
    final itemEntities = await _mapItemsWithProductNames(items);
    return PurchaseMapper.fromDrift(invoice, itemEntities);
  }

  /// Insert a new purchase with items
  Future<String> insertPurchaseWithItems(PurchaseEntity purchase) async {
    final companion = PurchaseMapper.toCompanion(purchase);
    final purchaseUuid = companion.purchaseUuid.value;

    final itemCompanions = purchase.items
        .map((item) => PurchaseMapper.itemToCompanion(item, purchaseUuid))
        .toList();

    await _purchaseDao.insertInvoiceWithItems(companion, itemCompanions);
    return purchaseUuid;
  }

  /// Delete a purchase
  Future<int> deletePurchase(String uuid) async {
    return _purchaseDao.deleteInvoice(uuid);
  }

  /// Helper to map items with product names from ProductDao
  Future<List<PurchaseItemEntity>> _mapItemsWithProductNames(
    List<dynamic> items,
  ) async {
    final List<PurchaseItemEntity> itemEntities = [];

    for (final item in items) {
      final product = await _productDao.getProductByUuid(item.productUuid);
      final productName = product?.name;
      itemEntities.add(PurchaseMapper.itemFromDrift(item, productName));
    }

    return itemEntities;
  }
}
