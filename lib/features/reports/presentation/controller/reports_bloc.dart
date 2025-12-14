import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/reports/domain/entities/report_data.dart';
import 'package:orbiq/features/reports/domain/repositories/reports_repository.dart';
import 'package:orbiq/features/reports/presentation/controller/reports_event.dart';
import 'package:orbiq/features/reports/presentation/controller/reports_state.dart';

/// BLoC for managing reports state
/// Uses ReportsRepository following Clean Architecture
@injectable
class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ReportsRepository _repository;
  int _currentPeriod = 0;

  ReportsBloc(this._repository) : super(const ReportsInitial()) {
    on<ReportsLoadRequested>(_onLoadReports);
    on<PeriodChanged>(_onPeriodChanged);
    on<ReportsRefreshRequested>(_onRefresh);
  }

  /// Handles initial load request
  Future<void> _onLoadReports(
    ReportsLoadRequested event,
    Emitter<ReportsState> emit,
  ) async {
    emit(const ReportsLoading());
    await _loadData(emit, _currentPeriod);
  }

  /// Handles period change (today/week/month)
  Future<void> _onPeriodChanged(
    PeriodChanged event,
    Emitter<ReportsState> emit,
  ) async {
    _currentPeriod = event.period;
    emit(const ReportsLoading());
    await _loadData(emit, event.period);
  }

  /// Handles refresh request
  Future<void> _onRefresh(
    ReportsRefreshRequested event,
    Emitter<ReportsState> emit,
  ) async {
    await _loadData(emit, _currentPeriod);
  }

  /// Loads all report data for the given period
  Future<void> _loadData(Emitter<ReportsState> emit, int period) async {
    final now = DateTime.now();
    DateTime startDate;
    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    // Calculate start date based on selected period
    switch (period) {
      case 0: // Today
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case 1: // This week
        startDate = now.subtract(Duration(days: now.weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        break;
      case 2: // This month
        startDate = DateTime(now.year, now.month, 1);
        break;
      default:
        startDate = DateTime(now.year, now.month, now.day);
    }

    // Load all data concurrently
    double totalRevenue = 0;
    double totalProfit = 0;
    int salesCount = 0;
    List<DailySalesEntity> dailySales = [];
    List<TopProductEntity> topProducts = [];

    // Get revenue
    final revenueResult = await _repository.getRevenueInDateRange(
      startDate,
      endDate,
    );
    revenueResult.fold(
      (failure) => emit(ReportsError(failure.message)),
      (value) => totalRevenue = value,
    );

    // If error occurred, return early
    if (state is ReportsError) return;

    // Get profit
    final profitResult = await _repository.getProfitInDateRange(
      startDate,
      endDate,
    );
    profitResult.fold(
      (failure) => emit(ReportsError(failure.message)),
      (value) => totalProfit = value,
    );

    if (state is ReportsError) return;

    // Get sales count
    final countResult = await _repository.getSalesCountInDateRange(
      startDate,
      endDate,
    );
    countResult.fold(
      (failure) => emit(ReportsError(failure.message)),
      (value) => salesCount = value,
    );

    if (state is ReportsError) return;

    // Get daily sales for chart
    final dailySalesResult = await _repository.getDailySales(
      startDate,
      endDate,
    );
    dailySalesResult.fold(
      (failure) => emit(ReportsError(failure.message)),
      (value) => dailySales = value,
    );

    if (state is ReportsError) return;

    // Get top products
    final topProductsResult = await _repository.getTopSellingProducts(5);
    topProductsResult.fold(
      (failure) => emit(ReportsError(failure.message)),
      (value) => topProducts = value,
    );

    if (state is ReportsError) return;

    // Emit loaded state with all data
    emit(
      ReportsLoaded(
        totalRevenue: totalRevenue,
        totalProfit: totalProfit,
        salesCount: salesCount,
        dailySales: dailySales,
        topProducts: topProducts,
        selectedPeriod: period,
      ),
    );
  }
}
