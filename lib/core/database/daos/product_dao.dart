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
}
