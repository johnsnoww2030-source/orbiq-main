import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/events/event_bus.dart';
import '../../domain/repositories/profit_repository.dart';
import '../../domain/services/profit_calculator.dart';
import '../../domain/usecases/get_profit_summary_usecase.dart';
import '../../domain/usecases/get_daily_profits_usecase.dart';
import 'profit_report_event.dart';
import 'profit_report_state.dart';

/// BLoC for managing profit reports
class ProfitReportBloc extends Bloc<ProfitReportEvent, ProfitReportState> {
  final ProfitRepository repository;
  final ProfitCalculator calculator;
  final GetProfitSummaryUseCase getProfitSummaryUseCase;
  final GetDailyProfitsUseCase getDailyProfitsUseCase;
  final EventBus eventBus;

  // Current filter state
  ProfitPeriod _currentPeriod = ProfitPeriod.thisMonth;
  ChartViewType _currentChartView = ChartViewType.profitIRR;
  double _currentExchangeRate = 60000.0; // Default

  ProfitReportBloc({
    required this.repository,
    required this.calculator,
    required this.getProfitSummaryUseCase,
    required this.getDailyProfitsUseCase,
    required this.eventBus,
  }) : super(const ProfitReportInitial()) {
    on<LoadProfitSummaryEvent>(_onLoadProfitSummary);
    on<LoadDailyProfitsEvent>(_onLoadDailyProfits);
    on<ChangePeriodEvent>(_onChangePeriod);
    on<RefreshWithCurrentRateEvent>(_onRefreshWithCurrentRate);
    on<ToggleChartViewEvent>(_onToggleChartView);
  }

  /// Get date range for a period
  (DateTime, DateTime) _getDateRangeForPeriod(ProfitPeriod period) {
    final now = DateTime.now();

    switch (period) {
      case ProfitPeriod.today:
        final start = DateTime(now.year, now.month, now.day);
        return (start, now);

      case ProfitPeriod.thisWeek:
        final start = now.subtract(Duration(days: now.weekday - 1));
        return (DateTime(start.year, start.month, start.day), now);

      case ProfitPeriod.thisMonth:
        final start = DateTime(now.year, now.month, 1);
        return (start, now);

      case ProfitPeriod.lastMonth:
        final start = DateTime(now.year, now.month - 1, 1);
        final end = DateTime(now.year, now.month, 0);
        return (start, end);

      case ProfitPeriod.last3Months:
        final start = DateTime(now.year, now.month - 3, now.day);
        return (start, now);

      case ProfitPeriod.thisYear:
        final start = DateTime(now.year, 1, 1);
        return (start, now);

      case ProfitPeriod.custom:
        // Default to this month for custom
        final start = DateTime(now.year, now.month, 1);
        return (start, now);
    }
  }

  /// Load profit summary
  Future<void> _onLoadProfitSummary(
    LoadProfitSummaryEvent event,
    Emitter<ProfitReportState> emit,
  ) async {
    emit(const ProfitReportLoading());

    final summaryResult = await getProfitSummaryUseCase(
      GetProfitSummaryParams(
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );

    final dailyResult = await getDailyProfitsUseCase(
      GetDailyProfitsParams(startDate: event.startDate, endDate: event.endDate),
    );

    summaryResult.fold((failure) => emit(ProfitReportError(failure.message)), (
      summary,
    ) {
      dailyResult.fold(
        (failure) => emit(ProfitReportError(failure.message)),
        (dailyProfits) => emit(
          ProfitReportLoaded(
            summary: summary,
            dailyProfits: dailyProfits,
            period: _currentPeriod,
            chartViewType: _currentChartView,
            currentExchangeRate: _currentExchangeRate,
          ),
        ),
      );
    });
  }

  /// Load daily profits only (for chart focus)
  Future<void> _onLoadDailyProfits(
    LoadDailyProfitsEvent event,
    Emitter<ProfitReportState> emit,
  ) async {
    emit(const ProfitReportLoading());

    final result = await getDailyProfitsUseCase(
      GetDailyProfitsParams(startDate: event.startDate, endDate: event.endDate),
    );

    result.fold((failure) => emit(ProfitReportError(failure.message)), (
      dailyProfits,
    ) {
      // Calculate totals
      final totalIRR = dailyProfits.fold<double>(
        0.0,
        (sum, d) => sum + d.profitIRR,
      );
      final totalUSD = dailyProfits.fold<double>(
        0.0,
        (sum, d) => sum + d.profitUSD,
      );
      final currentUSD = totalIRR / _currentExchangeRate;

      emit(
        DailyProfitsLoaded(
          dailyProfits: dailyProfits,
          period: _currentPeriod,
          chartViewType: _currentChartView,
          totalProfitIRR: totalIRR,
          totalProfitUSD: totalUSD,
          currentValueUSD: currentUSD,
        ),
      );
    });
  }

  /// Change period and reload
  Future<void> _onChangePeriod(
    ChangePeriodEvent event,
    Emitter<ProfitReportState> emit,
  ) async {
    _currentPeriod = event.period;
    final (start, end) = _getDateRangeForPeriod(event.period);

    add(LoadProfitSummaryEvent(startDate: start, endDate: end));
  }

  /// Refresh with new exchange rate
  Future<void> _onRefreshWithCurrentRate(
    RefreshWithCurrentRateEvent event,
    Emitter<ProfitReportState> emit,
  ) async {
    _currentExchangeRate = event.currentRate;

    final (start, end) = _getDateRangeForPeriod(_currentPeriod);
    add(LoadProfitSummaryEvent(startDate: start, endDate: end));
  }

  /// Toggle chart view type
  void _onToggleChartView(
    ToggleChartViewEvent event,
    Emitter<ProfitReportState> emit,
  ) {
    _currentChartView = event.viewType;

    final currentState = state;
    if (currentState is ProfitReportLoaded) {
      emit(currentState.copyWithChartView(event.viewType));
    }
  }

  /// Initialize with default period
  void init() {
    add(const ChangePeriodEvent(ProfitPeriod.thisMonth));
  }
}
