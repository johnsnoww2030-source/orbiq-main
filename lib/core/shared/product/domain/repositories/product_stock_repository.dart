import 'package:dartz/dartz.dart';
import '../entities/product_entity.dart';

/// Abstract repository for product stock operations
/// Used by Sales and Purchase features to manage stock and WAC
abstract class ProductStockRepository {
  /// Get product by UUID
  Future<Either<String, ProductEntity>> getProductByUuid(String uuid);

  /// Update stock for a product (after sale)
  Future<Either<String, void>> updateStock(String uuid, int newStock);

  /// Update stock and WAC atomically (after purchase)
  /// WAC Formula: newWAC = (oldStock × oldWAC + newQty × newPrice) / (oldStock + newQty)
  Future<Either<String, void>> updateStockAndWAC({
    required String uuid,
    required int additionalQty,
    required double newUnitPrice,
  });

  /// Update original price for a product (price suggestion)
  Future<Either<String, void>> updateOriginalPrice(
    String uuid,
    double newPrice,
  );

  /// Rollback stock after purchase deletion
  /// Reduces stock by the given quantity
  Future<Either<String, void>> rollbackPurchaseStock({
    required String uuid,
    required int quantity,
  });
}
