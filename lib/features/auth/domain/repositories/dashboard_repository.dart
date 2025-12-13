import 'package:dartz/dartz.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

/// Abstract repository for dashboard operations
/// Used by DashboardContentWidget to get inventory and sales summary
abstract class DashboardRepository {
  /// Get product count
  Future<Either<String, int>> getProductCount();

  /// Get low stock count
  Future<Either<String, int>> getLowStockCount();

  /// Get out of stock count
  Future<Either<String, int>> getOutOfStockCount();

  /// Get total inventory value
  Future<Either<String, double>> getTotalInventoryValue();

  /// Get low stock products list
  Future<Either<String, List<ProductEntity>>> getLowStockProductsList();

  /// Get today's revenue
  Future<Either<String, double>> getTodayRevenue();

  /// Get today's profit
  Future<Either<String, double>> getTodayProfit();

  /// Get today's invoice count
  Future<Either<String, int>> getTodayInvoiceCount();
}
