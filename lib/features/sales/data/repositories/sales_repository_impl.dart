import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/features/sales/data/data_sources/sales_local_data_source.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';
import 'package:orbiq/features/sales/domain/repositories/sales_repository.dart';

/// Repository implementation for Sales operations
/// Handles stock decrease and profit calculation
@Injectable(as: SalesRepository)
class SalesRepositoryImpl implements SalesRepository {
  final SalesLocalDataSource _localDataSource;
  final ProductDao _productDao;

  SalesRepositoryImpl(this._localDataSource, this._productDao);

  @override
  Future<Either<String, List<SalesEntity>>> getAllSales() async {
    try {
      final sales = await _localDataSource.getAllSales();
      return Right(sales);
    } catch (e) {
      return Left('خطا در دریافت لیست فروش‌ها: $e');
    }
  }

  @override
  Future<Either<String, SalesEntity>> getSalesByUuid(String uuid) async {
    try {
      final sale = await _localDataSource.getSaleByUuid(uuid);
      if (sale == null) {
        return const Left('فروش مورد نظر یافت نشد');
      }
      return Right(sale);
    } catch (e) {
      return Left('خطا در دریافت اطلاعات فروش: $e');
    }
  }

  @override
  Future<Either<String, SalesEntity>> createSale(SalesEntity sale) async {
    try {
      // 1. Validate stock and get costAtSale for each item
      final List<SalesItemEntity> itemsWithCost = [];
      double totalAmount = 0;

      for (final item in sale.items) {
        // Get current product for stock and avgBuyPrice
        final product = await _productDao.getProductByUuid(item.productUuid);
        if (product == null) {
          return Left('محصول ${item.productName ?? item.productUuid} یافت نشد');
        }

        // Check stock availability
        if (product.currentStock < item.quantity) {
          return Left(
            'موجودی ${product.name} کافی نیست (موجود: ${product.currentStock})',
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

      // 4. Decrease stock for each product
      for (final item in sale.items) {
        final product = await _productDao.getProductByUuid(item.productUuid);
        if (product != null) {
          final newStock = product.currentStock - item.quantity;
          await _productDao.updateStock(item.productUuid, newStock);
        }
      }

      // 5. Return created sale
      final createdSale = await _localDataSource.getSaleByUuid(invoiceUuid);
      if (createdSale != null) {
        return Right(createdSale);
      }

      return Right(saleWithTotals.copyWith(invoiceUuid: invoiceUuid));
    } catch (e) {
      return Left('خطا در ثبت فروش: $e');
    }
  }

  @override
  Future<Either<String, void>> updateSaleStatus(
    String uuid,
    String status,
  ) async {
    try {
      await _localDataSource.updateStatus(uuid, status);
      return const Right(null);
    } catch (e) {
      return Left('خطا در بروزرسانی وضعیت: $e');
    }
  }

  @override
  Future<Either<String, void>> deleteSale(String uuid) async {
    try {
      // Note: In production, you might want to restore stock
      await _localDataSource.deleteSale(uuid);
      return const Right(null);
    } catch (e) {
      return Left('خطا در حذف فروش: $e');
    }
  }

  @override
  Future<Either<String, List<SalesEntity>>> getTodaySales() async {
    try {
      final sales = await _localDataSource.getTodaySales();
      return Right(sales);
    } catch (e) {
      return Left('خطا در دریافت فروش‌های امروز: $e');
    }
  }

  @override
  Future<Either<String, double>> getTotalRevenue() async {
    try {
      final revenue = await _localDataSource.getTotalRevenue();
      return Right(revenue);
    } catch (e) {
      return Left('خطا در محاسبه درآمد: $e');
    }
  }

  @override
  Future<Either<String, double>> getTotalProfit() async {
    try {
      final profit = await _localDataSource.getTotalProfit();
      return Right(profit);
    } catch (e) {
      return Left('خطا در محاسبه سود: $e');
    }
  }

  @override
  Stream<List<SalesEntity>> watchAllSales() {
    return _localDataSource.watchAllSales();
  }
}
