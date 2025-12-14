import 'package:equatable/equatable.dart';

/// Base event for ReportsBloc
abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load reports data
class ReportsLoadRequested extends ReportsEvent {
  const ReportsLoadRequested();
}

/// Event when period filter is changed
/// [period] values: 0 = today, 1 = this week, 2 = this month
class PeriodChanged extends ReportsEvent {
  final int period;

  const PeriodChanged(this.period);

  @override
  List<Object?> get props => [period];
}

/// Event to refresh reports data
class ReportsRefreshRequested extends ReportsEvent {
  const ReportsRefreshRequested();
}
