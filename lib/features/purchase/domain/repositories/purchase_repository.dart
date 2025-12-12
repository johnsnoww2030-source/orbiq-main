import 'package:dartz/dartz.dart';
import '../entities/purchase_entity.dart';

/// Abstract repository interface for Purchase operations
abstract class PurchaseRepository {
  /// Get all purchase invoices
  Future<Either<String, List<PurchaseEntity>>> getAllPurchases();

  /// Get purchase by UUID with items
  Future<Either<String, PurchaseEntity>> getPurchaseByUuid(String uuid);

  /// Create a new purchase with items and update product stock/WAC
  Future<Either<String, PurchaseEntity>> createPurchase(
    PurchaseEntity purchase,
  );

  /// Delete a purchase (and rollback stock if needed)
  Future<Either<String, void>> deletePurchase(String uuid);

  /// Watch all purchases (reactive stream)
  Stream<List<PurchaseEntity>> watchAllPurchases();
}
