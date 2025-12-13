import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/services/event_service.dart';
import 'package:orbiq/core/shared/product/domain/repositories/product_stock_repository.dart';
import 'package:orbiq/features/purchase/data/data_sources/purchase_local_data_source.dart';
import 'package:orbiq/features/purchase/domain/entities/purchase_entity.dart';
import 'package:orbiq/features/purchase/domain/failures/purchase_failure.dart';
import 'package:orbiq/features/purchase/domain/repositories/purchase_repository.dart';

/// Repository implementation for Purchase operations with WAC logic
@Injectable(as: PurchaseRepository)
class PurchaseRepositoryImpl implements PurchaseRepository {
  final PurchaseLocalDataSource _localDataSource;
  final ProductStockRepository _productStockRepository;
  final EventService _eventService;

  PurchaseRepositoryImpl(
    this._localDataSource,
    this._productStockRepository,
    this._eventService,
  );

  @override
  Future<Either<PurchaseFailure, List<PurchaseEntity>>>
  getAllPurchases() async {
    try {
      final purchases = await _localDataSource.getAllPurchases();
      return Right(purchases);
    } catch (e) {
      return Left(PurchaseDatabaseFailure('خطا در دریافت لیست خریدها: $e'));
    }
  }

  @override
  Future<Either<PurchaseFailure, PurchaseEntity>> getPurchaseByUuid(
    String uuid,
  ) async {
    try {
      final purchase = await _localDataSource.getPurchaseByUuid(uuid);
      if (purchase == null) {
        return const Left(PurchaseNotFoundFailure());
      }
      return Right(purchase);
    } catch (e) {
      return Left(PurchaseDatabaseFailure('خطا در دریافت اطلاعات خرید: $e'));
    }
  }

  @override
  Future<Either<PurchaseFailure, PurchaseEntity>> createPurchase(
    PurchaseEntity purchase,
  ) async {
    try {
      // Validate items
      if (purchase.items.isEmpty) {
        return const Left(EmptyItemsFailure());
      }

      // 1. Calculate totals
      double totalCost = 0;
      for (final item in purchase.items) {
        totalCost += item.totalPrice;
      }
      final finalTotal = totalCost + purchase.additionalCosts;

      // 2. Create purchase with calculated totals
      final purchaseWithTotals = purchase.copyWith(
        totalCost: totalCost,
        finalTotal: finalTotal,
      );

      // 3. Insert purchase and items
      final purchaseUuid = await _localDataSource.insertPurchaseWithItems(
        purchaseWithTotals,
      );

      // 4. Calculate total quantity for shipping cost distribution
      int totalQuantity = 0;
      for (final item in purchase.items) {
        totalQuantity += item.quantity;
      }

      // 5. Update stock and WAC for each product + log events
      // Shipping cost is distributed proportionally by quantity
      for (final item in purchase.items) {
        // Calculate effective unit price including shipping cost share
        // effectiveUnitPrice = unitBuyPrice + (additionalCosts / totalQuantity)
        double effectiveUnitPrice = item.unitBuyPrice;
        if (purchase.additionalCosts > 0 && totalQuantity > 0) {
          // Shipping cost per unit across all items
          final shippingPerUnit = purchase.additionalCosts / totalQuantity;
          effectiveUnitPrice = item.unitBuyPrice + shippingPerUnit;
        }

        await _productStockRepository.updateStockAndWAC(
          uuid: item.productUuid,
          additionalQty: item.quantity,
          newUnitPrice: effectiveUnitPrice,
        );

        // Log stock added event (log original unitBuyPrice, not effective)
        await _eventService.logStockAdded(
          productId: item.productUuid,
          productName: item.productName ?? 'Unknown',
          quantity: item.quantity,
          unitPrice: item.unitBuyPrice,
          purchaseId: purchaseUuid,
        );
      }

      // 6. Log purchase created event
      await _eventService.logPurchaseCreated(
        purchaseId: purchaseUuid,
        supplierName: purchase.supplierName ?? 'Unknown',
        totalCost: finalTotal,
        itemCount: purchase.items.length,
      );

      // 7. Return created purchase
      final createdPurchase = await _localDataSource.getPurchaseByUuid(
        purchaseUuid,
      );
      if (createdPurchase != null) {
        return Right(createdPurchase);
      }

      return Right(purchaseWithTotals.copyWith(purchaseUuid: purchaseUuid));
    } catch (e) {
      return Left(PurchaseDatabaseFailure('خطا در ثبت خرید: $e'));
    }
  }

  @override
  Future<Either<PurchaseFailure, PurchaseEntity>> updatePurchase(
    PurchaseEntity purchase,
  ) async {
    try {
      // For now, update is a simple delete and recreate
      // A more sophisticated implementation would handle partial updates

      // 1. Get existing purchase to rollback stock
      final existingResult = await getPurchaseByUuid(purchase.purchaseUuid);
      if (existingResult.isLeft()) {
        return existingResult;
      }

      // 2. Rollback stock from old purchase
      final existingPurchase = existingResult.getOrElse(
        () => throw Exception('Purchase not found'),
      );
      for (final item in existingPurchase.items) {
        await _productStockRepository.rollbackPurchaseStock(
          uuid: item.productUuid,
          quantity: item.quantity,
        );
      }

      // 3. Delete old purchase
      await _localDataSource.deletePurchase(purchase.purchaseUuid);

      // 4. Create new purchase with updated data
      return createPurchase(purchase);
    } catch (e) {
      return Left(PurchaseDatabaseFailure('خطا در بروزرسانی خرید: $e'));
    }
  }

  @override
  Future<Either<PurchaseFailure, void>> deletePurchase(String uuid) async {
    try {
      // 1. Get purchase with items for rollback
      final purchase = await _localDataSource.getPurchaseByUuid(uuid);
      if (purchase == null) {
        return const Left(PurchaseNotFoundFailure());
      }

      // 2. Rollback stock for each item
      for (final item in purchase.items) {
        final rollbackResult = await _productStockRepository
            .rollbackPurchaseStock(
              uuid: item.productUuid,
              quantity: item.quantity,
            );

        // Log rollback result but don't fail the whole operation
        rollbackResult.fold(
          (error) => _eventService.logError(
            message:
                'Failed to rollback stock for product ${item.productUuid}: $error',
          ),
          (_) => null,
        );
      }

      // 3. Delete purchase
      await _localDataSource.deletePurchase(uuid);

      // 4. Log purchase deleted event
      await _eventService.logPurchaseDeleted(
        purchaseId: uuid,
        supplierName: purchase.supplierName ?? 'Unknown',
        totalCost: purchase.finalTotal,
        itemCount: purchase.items.length,
      );

      return const Right(null);
    } catch (e) {
      return Left(StockRollbackFailure('خطا در حذف خرید: $e'));
    }
  }

  @override
  Stream<List<PurchaseEntity>> watchAllPurchases() {
    return _localDataSource.watchAllPurchases();
  }
}
