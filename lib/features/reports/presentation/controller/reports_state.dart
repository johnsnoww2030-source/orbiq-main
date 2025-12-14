import 'package:equatable/equatable.dart';
import 'package:orbiq/features/reports/domain/entities/report_data.dart';

/// Base state for ReportsBloc
abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ReportsInitial extends ReportsState {
  const ReportsInitial();
}

/// Loading state
class ReportsLoading extends ReportsState {
  const ReportsLoading();
}

/// Loaded state with all report data
class ReportsLoaded extends ReportsState {
  final double totalRevenue;
  final double totalProfit;
  final int salesCount;
  final List<DailySalesEntity> dailySales;
  final List<TopProductEntity> topProducts;
  final int selectedPeriod;

  const ReportsLoaded({
    required this.totalRevenue,
    required this.totalProfit,
    required this.salesCount,
    required this.dailySales,
    required this.topProducts,
    this.selectedPeriod = 0,
  });

  @override
  List<Object?> get props => [
    totalRevenue,
    totalProfit,
    salesCount,
    dailySales,
    topProducts,
    selectedPeriod,
  ];

  /// Creates a copy with updated values
  ReportsLoaded copyWith({
    double? totalRevenue,
    double? totalProfit,
    int? salesCount,
    List<DailySalesEntity>? dailySales,
    List<TopProductEntity>? topProducts,
    int? selectedPeriod,
  }) {
    return ReportsLoaded(
      totalRevenue: totalRevenue ?? this.totalRevenue,
      totalProfit: totalProfit ?? this.totalProfit,
      salesCount: salesCount ?? this.salesCount,
      dailySales: dailySales ?? this.dailySales,
      topProducts: topProducts ?? this.topProducts,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }
}

/// Error state
class ReportsError extends ReportsState {
  final String message;

  const ReportsError(this.message);

  @override
  List<Object?> get props => [message];
}
