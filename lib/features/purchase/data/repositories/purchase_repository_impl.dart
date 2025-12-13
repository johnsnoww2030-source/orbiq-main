import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/core/services/event_service.dart';
import 'package:orbiq/features/purchase/data/data_sources/purchase_local_data_source.dart';
import 'package:orbiq/features/purchase/domain/entities/purchase_entity.dart';
import 'package:orbiq/features/purchase/domain/repositories/purchase_repository.dart';

/// Repository implementation for Purchase operations with WAC logic
@Injectable(as: PurchaseRepository)
class PurchaseRepositoryImpl implements PurchaseRepository {
  final PurchaseLocalDataSource _localDataSource;
  final ProductDao _productDao;
  final EventService _eventService;

  PurchaseRepositoryImpl(
    this._localDataSource,
    this._productDao,
    this._eventService,
  );

  @override
  Future<Either<String, List<PurchaseEntity>>> getAllPurchases() async {
    try {
      final purchases = await _localDataSource.getAllPurchases();
      return Right(purchases);
    } catch (e) {
      return Left('خطا در دریافت لیست خریدها: $e');
    }
  }

  @override
  Future<Either<String, PurchaseEntity>> getPurchaseByUuid(String uuid) async {
    try {
      final purchase = await _localDataSource.getPurchaseByUuid(uuid);
      if (purchase == null) {
        return const Left('خرید مورد نظر یافت نشد');
      }
      return Right(purchase);
    } catch (e) {
      return Left('خطا در دریافت اطلاعات خرید: $e');
    }
  }

  @override
  Future<Either<String, PurchaseEntity>> createPurchase(
    PurchaseEntity purchase,
  ) async {
    try {
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

      // 4. Update stock and WAC for each product + log events
      for (final item in purchase.items) {
        await _productDao.updateStockAndWAC(
          uuid: item.productUuid,
          additionalQty: item.quantity,
          newUnitPrice: item.unitBuyPrice,
        );

        // Log stock added event
        await _eventService.logStockAdded(
          productId: item.productUuid,
          productName: item.productName ?? 'Unknown',
          quantity: item.quantity,
          unitPrice: item.unitBuyPrice,
          purchaseId: purchaseUuid,
        );
      }

      // 5. Log purchase created event
      await _eventService.logPurchaseCreated(
        purchaseId: purchaseUuid,
        supplierName: purchase.supplierName ?? 'Unknown',
        totalCost: finalTotal,
        itemCount: purchase.items.length,
      );

      // 6. Return created purchase
      final createdPurchase = await _localDataSource.getPurchaseByUuid(
        purchaseUuid,
      );
      if (createdPurchase != null) {
        return Right(createdPurchase);
      }

      return Right(purchaseWithTotals.copyWith(purchaseUuid: purchaseUuid));
    } catch (e) {
      return Left('خطا در ثبت خرید: $e');
    }
  }

  @override
  Future<Either<String, void>> deletePurchase(String uuid) async {
    try {
      // Note: In a real app, you might want to rollback stock changes
      // For now, we just delete the purchase
      await _localDataSource.deletePurchase(uuid);
      return const Right(null);
    } catch (e) {
      return Left('خطا در حذف خرید: $e');
    }
  }

  @override
  Stream<List<PurchaseEntity>> watchAllPurchases() {
    return _localDataSource.watchAllPurchases();
  }
}
