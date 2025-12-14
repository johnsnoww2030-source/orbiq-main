import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/sales_dao.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/features/reports/data/mappers/reports_mapper.dart';
import 'package:orbiq/features/reports/domain/entities/report_data.dart';

/// Local data source for Reports operations
/// Follows the pattern from SalesLocalDataSource
@injectable
class ReportsLocalDataSource {
  final SalesDao _salesDao;
  final ProductDao _productDao;

  ReportsLocalDataSource(this._salesDao, this._productDao);

  /// Get revenue in date range
  Future<double> getRevenueInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _salesDao.getRevenueInDateRange(startDate, endDate);
  }

  /// Get profit in date range
  Future<double> getProfitInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _salesDao.getProfitInDateRange(startDate, endDate);
  }

  /// Get sales count in date range
  Future<int> getSalesCountInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _salesDao.getSalesCountInDateRange(startDate, endDate);
  }

  /// Get daily sales for chart
  Future<List<DailySalesEntity>> getDailySales(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final dailySales = await _salesDao.getDailySales(startDate, endDate);
    return dailySales
        .map((map) => ReportsMapper.mapToDailySalesEntity(map))
        .toList();
  }

  /// Get top selling products
  Future<List<TopProductEntity>> getTopSellingProducts(int limit) async {
    final topProducts = await _salesDao.getTopSellingProducts(limit);
    final result = <TopProductEntity>[];

    for (final product in topProducts) {
      final productUuid = product['productUuid'] as String;
      final p = await _productDao.getProductByUuid(productUuid);
      final productName = p?.name ?? 'Unknown';

      result.add(ReportsMapper.mapToTopProductEntity(product, productName));
    }

    return result;
  }
}
