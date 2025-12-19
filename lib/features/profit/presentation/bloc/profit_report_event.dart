import 'package:equatable/equatable.dart';

/// Base class for Profit Report events
sealed class ProfitReportEvent extends Equatable {
  const ProfitReportEvent();

  @override
  List<Object?> get props => [];
}

/// Load profit summary for a period
class LoadProfitSummaryEvent extends ProfitReportEvent {
  final DateTime startDate;
  final DateTime endDate;

  const LoadProfitSummaryEvent({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}

/// Load daily profits for chart
class LoadDailyProfitsEvent extends ProfitReportEvent {
  final DateTime startDate;
  final DateTime endDate;

  const LoadDailyProfitsEvent({required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

/// Change period filter
class ChangePeriodEvent extends ProfitReportEvent {
  final ProfitPeriod period;

  const ChangePeriodEvent(this.period);

  @override
  List<Object?> get props => [period];
}

/// Refresh with current exchange rate
class RefreshWithCurrentRateEvent extends ProfitReportEvent {
  final double currentRate;

  const RefreshWithCurrentRateEvent(this.currentRate);

  @override
  List<Object?> get props => [currentRate];
}

/// Toggle chart view (profit vs value)
class ToggleChartViewEvent extends ProfitReportEvent {
  final ChartViewType viewType;

  const ToggleChartViewEvent(this.viewType);

  @override
  List<Object?> get props => [viewType];
}

/// Predefined profit periods
enum ProfitPeriod {
  today,
  thisWeek,
  thisMonth,
  lastMonth,
  last3Months,
  thisYear,
  custom,
}

/// Chart view types
enum ChartViewType { profitIRR, profitUSD, valueLoss, salesCount }
