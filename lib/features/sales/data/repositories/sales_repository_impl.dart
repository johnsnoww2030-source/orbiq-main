import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/services/event_service.dart';
import 'package:orbiq/core/shared/product/domain/repositories/product_stock_repository.dart';
import 'package:orbiq/features/sales/data/data_sources/sales_local_data_source.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';
import 'package:orbiq/features/sales/domain/failures/sales_failure.dart';
import 'package:orbiq/features/sales/domain/repositories/sales_repository.dart';

/// Repository implementation for Sales operations
/// Handles stock decrease and profit calculation
@Injectable(as: SalesRepository)
class SalesRepositoryImpl implements SalesRepository {
  final SalesLocalDataSource _localDataSource;
  final ProductStockRepository _productStockRepository;
  final EventService _eventService;

  SalesRepositoryImpl(
    this._localDataSource,
    this._productStockRepository,
    this._eventService,
  );

  @override
  Future<Either<SalesFailure, List<SalesEntity>>> getAllSales() async {
    try {
      final sales = await _localDataSource.getAllSales();
      return Right(sales);
    } catch (e) {
      return const Left(SalesDatabaseFailure());
    }
  }

  @override
  Future<Either<SalesFailure, SalesEntity>> getSalesByUuid(String uuid) async {
    try {
      final sale = await _localDataSource.getSaleByUuid(uuid);
      if (sale == null) {
        return const Left(SalesNotFoundFailure());
      }
      return Right(sale);
    } catch (e) {
      return const Left(SalesDatabaseFailure());
    }
  }

  @override
  Future<Either<SalesFailure, SalesEntity>> createSale(SalesEntity sale) async {
    try {
      // 1. Validate stock and get costAtSale for each item
      final List<SalesItemEntity> itemsWithCost = [];
      double totalAmount = 0;
      double totalProfit = 0;

      for (final item in sale.items) {
        // Get current product for stock and avgBuyPrice
        final productResult = await _productStockRepository.getProductByUuid(
          item.productUuid,
        );
        final product = productResult.fold((error) => null, (p) => p);
        if (product == null) {
          return Left(
            ProductNotFoundForSaleFailure(productId: item.productUuid),
          );
        }

        // Check stock availability
        if (product.currentStock < item.quantity) {
          return Left(
            InsufficientStockFailure(
              productName: product.name,
              available: product.currentStock,
              requested: item.quantity,
            ),
          );
        }

        // Calculate profit with costAtSale = avgBuyPrice
        final costAtSale = product.avgBuyPrice;
        final totalPrice = item.quantity * item.unitSellPrice;
        final profit = (item.unitSellPrice - costAtSale) * item.quantity;

        itemsWithCost.add(
          item.copyWith(
            costAtSale: costAtSale,
            totalPrice: totalPrice,
            profit: profit,
          ),
        );

        totalAmount += totalPrice;
        totalProfit += profit;
      }

      // 2. Create sale with calculated totals
      final saleWithTotals = sale.copyWith(
        totalAmount: totalAmount,
        items: itemsWithCost,
      );

      // 3. Insert sale and items
      final invoiceUuid = await _localDataSource.insertSaleWithItems(
        saleWithTotals,
      );

      // 4. Decrease stock for each product + log events
      for (final item in itemsWithCost) {
        final productResult = await _productStockRepository.getProductByUuid(
          item.productUuid,
        );
        await productResult.fold((error) async {}, (product) async {
          final newStock = product.currentStock - item.quantity;
          await _productStockRepository.updateStock(item.productUuid, newStock);

          // Log stock removed event
          await _eventService.logStockRemoved(
            productId: item.productUuid,
            productName: product.name,
            quantity: item.quantity,
            unitPrice: item.unitSellPrice,
            saleId: invoiceUuid,
          );
        });
      }

      // 5. Log sale created event
      await _eventService.logSaleCreated(
        saleId: invoiceUuid,
        totalSales: totalAmount,
        profit: totalProfit,
        itemCount: itemsWithCost.length,
      );

      // 6. Return created sale
      final createdSale = await _localDataSource.getSaleByUuid(invoiceUuid);
      if (createdSale != null) {
        return Right(createdSale);
      }

      return Right(saleWithTotals.copyWith(invoiceUuid: invoiceUuid));
    } catch (e) {
      return const Left(SalesDatabaseFailure());
    }
  }

  @override
  Future<Either<SalesFailure, void>> updateSaleStatus(
    String uuid,
    String status,
  ) async {
    try {
      await _localDataSource.updateStatus(uuid, status);
      return const Right(null);
    } catch (e) {
      return const Left(SalesStatusUpdateFailure());
    }
  }

  @override
  Future<Either<SalesFailure, void>> deleteSale(String uuid) async {
    try {
      // Note: In production, you might want to restore stock
      await _localDataSource.deleteSale(uuid);
      return const Right(null);
    } catch (e) {
      return const Left(SalesDatabaseFailure());
    }
  }

  @override
  Future<Either<SalesFailure, List<SalesEntity>>> getTodaySales() async {
    try {
      final sales = await _localDataSource.getTodaySales();
      return Right(sales);
    } catch (e) {
      return const Left(SalesDatabaseFailure());
    }
  }

  @override
  Future<Either<SalesFailure, double>> getTotalRevenue() async {
    try {
      final revenue = await _localDataSource.getTotalRevenue();
      return Right(revenue);
    } catch (e) {
      return const Left(SalesDatabaseFailure());
    }
  }

  @override
  Future<Either<SalesFailure, double>> getTotalProfit() async {
    try {
      final profit = await _localDataSource.getTotalProfit();
      return Right(profit);
    } catch (e) {
      return const Left(SalesDatabaseFailure());
    }
  }

  @override
  Stream<List<SalesEntity>> watchAllSales() {
    return _localDataSource.watchAllSales();
  }
}
