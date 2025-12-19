import 'package:dartz/dartz.dart';
import '../entities/profit_summary.dart';
import '../entities/daily_profit.dart';
import '../../data/models/sale_item_data.dart';
import '../../../auth/domain/failures/failure.dart';

/// Profit Repository Interface
/// Defines contract for profit data operations
abstract class ProfitRepository {
  /// Get sale items for a specific period
  /// Returns list of SaleItemData for profit calculations
  Future<Either<Failure, List<SaleItemData>>> getSaleItems({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get profit summary for a period
  /// Includes both historical and current value calculations
  Future<Either<Failure, ProfitSummary>> getProfitSummary({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get daily profits for a period
  /// Returns aggregated profit data per day
  Future<Either<Failure, List<DailyProfit>>> getDailyProfits({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get profit for a specific invoice
  Future<Either<Failure, ProfitSummary>> getInvoiceProfit(String invoiceUuid);
}
