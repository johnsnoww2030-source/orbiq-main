import 'package:equatable/equatable.dart';

/// Base failure class for Reports feature
/// Follows the pattern from SalesFailure
abstract class ReportsFailure extends Equatable {
  final String message;

  const ReportsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when a database operation fails
class ReportsDatabaseFailure extends ReportsFailure {
  const ReportsDatabaseFailure([super.message = 'Database operation error']);
}

/// Failure when loading revenue data
class RevenueLoadFailure extends ReportsFailure {
  const RevenueLoadFailure([super.message = 'Failed to load revenue data']);
}

/// Failure when loading profit data
class ProfitLoadFailure extends ReportsFailure {
  const ProfitLoadFailure([super.message = 'Failed to load profit data']);
}

/// Failure when loading sales count
class SalesCountLoadFailure extends ReportsFailure {
  const SalesCountLoadFailure([super.message = 'Failed to load sales count']);
}

/// Failure when loading daily sales for chart
class DailySalesLoadFailure extends ReportsFailure {
  const DailySalesLoadFailure([super.message = 'Failed to load daily sales']);
}

/// Failure when loading top selling products
class TopProductsLoadFailure extends ReportsFailure {
  const TopProductsLoadFailure([super.message = 'Failed to load top products']);
}
