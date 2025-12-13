import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/sales_dao.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/features/reports/domain/entities/report_data.dart';
import 'package:orbiq/features/reports/domain/repositories/reports_repository.dart';

/// Implementation of ReportsRepository using SalesDao and ProductDao
@Injectable(as: ReportsRepository)
class ReportsRepositoryImpl implements ReportsRepository {
  final SalesDao _salesDao;
  final ProductDao _productDao;

  ReportsRepositoryImpl(this._salesDao, this._productDao);

  @override
  Future<Either<String, double>> getRevenueInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final revenue = await _salesDao.getRevenueInDateRange(startDate, endDate);
      return Right(revenue);
    } catch (e) {
      return Left('خطا در دریافت درآمد: $e');
    }
  }

  @override
  Future<Either<String, double>> getProfitInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final profit = await _salesDao.getProfitInDateRange(startDate, endDate);
      return Right(profit);
    } catch (e) {
      return Left('خطا در دریافت سود: $e');
    }
  }

  @override
  Future<Either<String, int>> getSalesCountInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final count = await _salesDao.getSalesCountInDateRange(
        startDate,
        endDate,
      );
      return Right(count);
    } catch (e) {
      return Left('خطا در دریافت تعداد فروش: $e');
    }
  }

  @override
  Future<Either<String, List<DailySalesData>>> getDailySales(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final dailySales = await _salesDao.getDailySales(startDate, endDate);
      final result = dailySales
          .map(
            (map) => DailySalesData(
              date: map['date'] as DateTime,
              revenue: (map['revenue'] as double?) ?? 0.0,
            ),
          )
          .toList();
      return Right(result);
    } catch (e) {
      return Left('خطا در دریافت فروش روزانه: $e');
    }
  }

  @override
  Future<Either<String, List<TopProductData>>> getTopSellingProducts(
    int limit,
  ) async {
    try {
      final topProducts = await _salesDao.getTopSellingProducts(limit);
      final result = <TopProductData>[];

      for (final product in topProducts) {
        final productUuid = product['productUuid'] as String;
        final p = await _productDao.getProductByUuid(productUuid);

        result.add(
          TopProductData(
            productUuid: productUuid,
            productName: p?.name ?? 'Unknown',
            quantity: product['quantity'] as int,
            revenue: (product['revenue'] as double?) ?? 0.0,
          ),
        );
      }

      return Right(result);
    } catch (e) {
      return Left('خطا در دریافت پرفروش‌ترین محصولات: $e');
    }
  }
}
