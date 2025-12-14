import 'package:dartz/dartz.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';
import 'package:orbiq/features/sales/domain/failures/sales_failure.dart';

/// Abstract repository interface for Sales operations
abstract class SalesRepository {
  /// Get all sales invoices
  Future<Either<SalesFailure, List<SalesEntity>>> getAllSales();

  /// Get sales by UUID
  Future<Either<SalesFailure, SalesEntity>> getSalesByUuid(String uuid);

  /// Create a new sale (decreases stock, records costAtSale)
  Future<Either<SalesFailure, SalesEntity>> createSale(SalesEntity sale);

  /// Update sale status
  Future<Either<SalesFailure, void>> updateSaleStatus(
    String uuid,
    String status,
  );

  /// Delete a sale
  Future<Either<SalesFailure, void>> deleteSale(String uuid);

  /// Get today's sales
  Future<Either<SalesFailure, List<SalesEntity>>> getTodaySales();

  /// Get total revenue
  Future<Either<SalesFailure, double>> getTotalRevenue();

  /// Get total profit
  Future<Either<SalesFailure, double>> getTotalProfit();

  /// Watch all sales (reactive stream)
  Stream<List<SalesEntity>> watchAllSales();
}
