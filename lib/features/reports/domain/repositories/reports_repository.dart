import 'package:dartz/dartz.dart';
import 'package:orbiq/features/reports/domain/entities/report_data.dart';
import 'package:orbiq/features/reports/domain/failures/reports_failure.dart';

/// Abstract repository for reports operations
/// Used by ReportsBloc to get sales statistics
abstract class ReportsRepository {
  /// Get revenue in date range
  Future<Either<ReportsFailure, double>> getRevenueInDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get profit in date range
  Future<Either<ReportsFailure, double>> getProfitInDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get sales count in date range
  Future<Either<ReportsFailure, int>> getSalesCountInDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get daily sales for chart
  Future<Either<ReportsFailure, List<DailySalesEntity>>> getDailySales(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get top selling products
  Future<Either<ReportsFailure, List<TopProductEntity>>> getTopSellingProducts(
    int limit,
  );
}
