import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/products_table.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  /// Get all products
  Future<List<Product>> getAllProducts() => select(products).get();

  /// Watch all products (reactive stream)
  Stream<List<Product>> watchAllProducts() => select(products).watch();

  /// Get product by UUID
  Future<Product?> getProductByUuid(String uuid) {
    return (select(
      products,
    )..where((p) => p.productUuid.equals(uuid))).getSingleOrNull();
  }

  /// Get product by serial number (barcode)
  Future<Product?> getProductBySerialNumber(String serial) {
    return (select(
      products,
    )..where((p) => p.serialNumber.equals(serial))).getSingleOrNull();
  }

  /// Insert a new product
  Future<int> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  /// Update an existing product
  Future<bool> updateProduct(Product product) {
    return update(products).replace(product);
  }

  /// Update a product by UUID using Companion
  Future<int> updateProductByUuid(String uuid, ProductsCompanion companion) {
    return (update(
      products,
    )..where((p) => p.productUuid.equals(uuid))).write(companion);
  }

  /// Delete a product by UUID
  Future<int> deleteProduct(String uuid) {
    return (delete(products)..where((p) => p.productUuid.equals(uuid))).go();
  }

  /// Update stock for a product
  Future<int> updateStock(String uuid, int newStock) {
    return (update(products)..where((p) => p.productUuid.equals(uuid))).write(
      ProductsCompanion(
        currentStock: Value(newStock),
        lastStockUpdate: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Get products with low stock
  Future<List<Product>> getProductsLowStock() {
    return (select(
      products,
    )..where((p) => p.currentStock.isSmallerOrEqual(p.reorderPoint))).get();
  }

  /// Update average buy price
  Future<int> updateAvgBuyPrice(String uuid, double newAvgPrice) {
    return (update(products)..where((p) => p.productUuid.equals(uuid))).write(
      ProductsCompanion(
        avgBuyPrice: Value(newAvgPrice),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update stock and WAC (Weighted Average Cost) atomically
  /// WAC Formula: newWAC = (oldStock × oldWAC + newQty × newPrice) / (oldStock + newQty)
  Future<void> updateStockAndWAC({
    required String uuid,
    required int additionalQty,
    required double newUnitPrice,
  }) async {
    final product = await getProductByUuid(uuid);
    if (product == null) return;

    final oldStock = product.currentStock;
    final oldWAC = product.avgBuyPrice;
    final newStock = oldStock + additionalQty;

    // Calculate new WAC
    double newWAC;
    if (newStock > 0) {
      newWAC = (oldStock * oldWAC + additionalQty * newUnitPrice) / newStock;
    } else {
      newWAC = newUnitPrice;
    }

    await (update(products)..where((p) => p.productUuid.equals(uuid))).write(
      ProductsCompanion(
        currentStock: Value(newStock),
        avgBuyPrice: Value(newWAC),
        lastStockUpdate: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update product original (selling) price
  Future<void> updateOriginalPrice(String uuid, double newPrice) async {
    await (update(products)..where((p) => p.productUuid.equals(uuid))).write(
      ProductsCompanion(
        originalPrice: Value(newPrice),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  // === Dashboard Methods ===

  /// Get products with zero or negative stock
  Future<List<Product>> getOutOfStockProducts() {
    return (select(
      products,
    )..where((p) => p.currentStock.isSmallerOrEqualValue(0))).get();
  }

  /// Get total product count
  Future<int> getProductCount() async {
    final all = await select(products).get();
    return all.length;
  }

  /// Get low stock product count
  /// Uses same logic as products_management_page: stock > 0 && stock <= (reorderPoint > 0 ? reorderPoint : 5)
  Future<int> getLowStockCount() async {
    final all = await select(products).get();
    return all.where((p) {
      final threshold = p.reorderPoint > 0 ? p.reorderPoint : 5;
      return p.currentStock > 0 && p.currentStock <= threshold;
    }).length;
  }

  /// Get out of stock product count (stock <= 0)
  Future<int> getOutOfStockCount() async {
    final all = await select(products).get();
    return all.where((p) => p.currentStock <= 0).length;
  }

  /// Get low stock products list (for dashboard alerts)
  /// Uses same logic as products_management_page
  Future<List<Product>> getLowStockProductsList() async {
    final all = await select(products).get();
    return all.where((p) {
      final threshold = p.reorderPoint > 0 ? p.reorderPoint : 5;
      return p.currentStock > 0 && p.currentStock <= threshold;
    }).toList();
  }

  /// Get total inventory value (sum of currentStock * avgBuyPrice)
  Future<double> getTotalInventoryValue() async {
    final all = await select(products).get();
    return all.fold<double>(
      0.0,
      (sum, p) => sum + (p.currentStock * p.avgBuyPrice),
    );
  }
}
