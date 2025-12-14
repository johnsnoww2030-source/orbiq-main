import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/reports/data/data_sources/reports_local_data_source.dart';
import 'package:orbiq/features/reports/domain/entities/report_data.dart';
import 'package:orbiq/features/reports/domain/failures/reports_failure.dart';
import 'package:orbiq/features/reports/domain/repositories/reports_repository.dart';

/// Implementation of ReportsRepository using ReportsLocalDataSource
/// Follows Clean Architecture patterns
@Injectable(as: ReportsRepository)
class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsLocalDataSource _dataSource;

  ReportsRepositoryImpl(this._dataSource);

  @override
  Future<Either<ReportsFailure, double>> getRevenueInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final revenue = await _dataSource.getRevenueInDateRange(
        startDate,
        endDate,
      );
      return Right(revenue);
    } catch (e) {
      return const Left(RevenueLoadFailure());
    }
  }

  @override
  Future<Either<ReportsFailure, double>> getProfitInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final profit = await _dataSource.getProfitInDateRange(startDate, endDate);
      return Right(profit);
    } catch (e) {
      return const Left(ProfitLoadFailure());
    }
  }

  @override
  Future<Either<ReportsFailure, int>> getSalesCountInDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final count = await _dataSource.getSalesCountInDateRange(
        startDate,
        endDate,
      );
      return Right(count);
    } catch (e) {
      return const Left(SalesCountLoadFailure());
    }
  }

  @override
  Future<Either<ReportsFailure, List<DailySalesEntity>>> getDailySales(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final dailySales = await _dataSource.getDailySales(startDate, endDate);
      return Right(dailySales);
    } catch (e) {
      return const Left(DailySalesLoadFailure());
    }
  }

  @override
  Future<Either<ReportsFailure, List<TopProductEntity>>> getTopSellingProducts(
    int limit,
  ) async {
    try {
      final topProducts = await _dataSource.getTopSellingProducts(limit);
      return Right(topProducts);
    } catch (e) {
      return const Left(TopProductsLoadFailure());
    }
  }
}
