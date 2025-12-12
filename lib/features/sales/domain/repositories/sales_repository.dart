import 'package:dartz/dartz.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';

/// Abstract repository interface for Sales operations
abstract class SalesRepository {
  /// Get all sales invoices
  Future<Either<String, List<SalesEntity>>> getAllSales();

  /// Get sales by UUID
  Future<Either<String, SalesEntity>> getSalesByUuid(String uuid);

  /// Create a new sale (decreases stock, records costAtSale)
  Future<Either<String, SalesEntity>> createSale(SalesEntity sale);

  /// Update sale status
  Future<Either<String, void>> updateSaleStatus(String uuid, String status);

  /// Delete a sale
  Future<Either<String, void>> deleteSale(String uuid);

  /// Get today's sales
  Future<Either<String, List<SalesEntity>>> getTodaySales();

  /// Get total revenue
  Future<Either<String, double>> getTotalRevenue();

  /// Get total profit
  Future<Either<String, double>> getTotalProfit();

  /// Watch all sales (reactive stream)
  Stream<List<SalesEntity>> watchAllSales();
}
