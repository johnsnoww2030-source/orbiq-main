import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/core/database/daos/sales_dao.dart';
import 'package:orbiq/core/shared/product/data/mappers/product_mapper.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/auth/domain/repositories/dashboard_repository.dart';

/// Implementation of DashboardRepository using ProductDao and SalesDao
@Injectable(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final ProductDao _productDao;
  final SalesDao _salesDao;

  DashboardRepositoryImpl(this._productDao, this._salesDao);

  @override
  Future<Either<String, int>> getProductCount() async {
    try {
      final count = await _productDao.getProductCount();
      return Right(count);
    } catch (e) {
      return Left('خطا در دریافت تعداد محصولات: $e');
    }
  }

  @override
  Future<Either<String, int>> getLowStockCount() async {
    try {
      final count = await _productDao.getLowStockCount();
      return Right(count);
    } catch (e) {
      return Left('خطا در دریافت تعداد کم‌موجودی: $e');
    }
  }

  @override
  Future<Either<String, int>> getOutOfStockCount() async {
    try {
      final count = await _productDao.getOutOfStockCount();
      return Right(count);
    } catch (e) {
      return Left('خطا در دریافت تعداد ناموجود: $e');
    }
  }

  @override
  Future<Either<String, double>> getTotalInventoryValue() async {
    try {
      final value = await _productDao.getTotalInventoryValue();
      return Right(value);
    } catch (e) {
      return Left('خطا در دریافت ارزش موجودی: $e');
    }
  }

  @override
  Future<Either<String, List<ProductEntity>>> getLowStockProductsList() async {
    try {
      final products = await _productDao.getLowStockProductsList();
      final entities = products.map((p) => ProductMapper.toEntity(p)).toList();
      return Right(entities);
    } catch (e) {
      return Left('خطا در دریافت لیست کم‌موجودی: $e');
    }
  }

  @override
  Future<Either<String, double>> getTodayRevenue() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      final revenue = await _salesDao.getRevenueInDateRange(
        startOfDay,
        endOfDay,
      );
      return Right(revenue);
    } catch (e) {
      return Left('خطا در دریافت درآمد امروز: $e');
    }
  }

  @override
  Future<Either<String, double>> getTodayProfit() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      final profit = await _salesDao.getProfitInDateRange(startOfDay, endOfDay);
      return Right(profit);
    } catch (e) {
      return Left('خطا در دریافت سود امروز: $e');
    }
  }

  @override
  Future<Either<String, int>> getTodayInvoiceCount() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      final count = await _salesDao.getSalesCountInDateRange(
        startOfDay,
        endOfDay,
      );
      return Right(count);
    } catch (e) {
      return Left('خطا در دریافت تعداد فاکتورهای امروز: $e');
    }
  }
}
