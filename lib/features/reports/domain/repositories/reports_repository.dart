import 'package:dartz/dartz.dart';
import '../entities/report_data.dart';

/// Abstract repository for reports operations
/// Used by ReportsPage to get sales statistics
abstract class ReportsRepository {
  /// Get revenue in date range
  Future<Either<String, double>> getRevenueInDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get profit in date range
  Future<Either<String, double>> getProfitInDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get sales count in date range
  Future<Either<String, int>> getSalesCountInDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get daily sales for chart
  Future<Either<String, List<DailySalesData>>> getDailySales(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get top selling products
  Future<Either<String, List<TopProductData>>> getTopSellingProducts(int limit);
}
