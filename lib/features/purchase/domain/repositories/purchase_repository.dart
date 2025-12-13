import 'package:dartz/dartz.dart';
import '../entities/purchase_entity.dart';
import '../failures/purchase_failure.dart';

/// Abstract repository interface for Purchase operations
abstract class PurchaseRepository {
  /// Get all purchase invoices
  Future<Either<PurchaseFailure, List<PurchaseEntity>>> getAllPurchases();

  /// Get purchase by UUID with items
  Future<Either<PurchaseFailure, PurchaseEntity>> getPurchaseByUuid(
    String uuid,
  );

  /// Create a new purchase with items and update product stock/WAC
  Future<Either<PurchaseFailure, PurchaseEntity>> createPurchase(
    PurchaseEntity purchase,
  );

  /// Update an existing purchase
  Future<Either<PurchaseFailure, PurchaseEntity>> updatePurchase(
    PurchaseEntity purchase,
  );

  /// Delete a purchase (and rollback stock)
  Future<Either<PurchaseFailure, void>> deletePurchase(String uuid);

  /// Watch all purchases (reactive stream)
  Stream<List<PurchaseEntity>> watchAllPurchases();
}
