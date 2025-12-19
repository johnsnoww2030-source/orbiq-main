import 'package:equatable/equatable.dart';
import '../../domain/entities/profit_summary.dart';
import '../../domain/entities/daily_profit.dart';
import 'profit_report_event.dart';

/// Base class for Profit Report states
sealed class ProfitReportState extends Equatable {
  const ProfitReportState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ProfitReportInitial extends ProfitReportState {
  const ProfitReportInitial();
}

/// Loading state
class ProfitReportLoading extends ProfitReportState {
  const ProfitReportLoading();
}

/// Profit summary loaded
class ProfitSummaryLoaded extends ProfitReportState {
  final ProfitSummary summary;
  final ProfitPeriod period;
  final ChartViewType chartViewType;

  const ProfitSummaryLoaded({
    required this.summary,
    required this.period,
    this.chartViewType = ChartViewType.profitIRR,
  });

  @override
  List<Object?> get props => [summary, period, chartViewType];

  /// Get formatted value loss or gain
  String get valueLossGainText {
    if (summary.valueDifferenceUSD >= 0) {
      return '+\$${summary.valueDifferenceUSD.toStringAsFixed(2)}';
    } else {
      return '-\$${summary.valueDifferenceUSD.abs().toStringAsFixed(2)}';
    }
  }

  /// Get value change color (for UI)
  String get valueChangeColor {
    if (summary.valueDifferenceUSD > 0) return 'green';
    if (summary.valueDifferenceUSD < 0) return 'red';
    return 'neutral';
  }
}

/// Daily profits loaded (for chart)
class DailyProfitsLoaded extends ProfitReportState {
  final List<DailyProfit> dailyProfits;
  final ProfitPeriod period;
  final ChartViewType chartViewType;
  final double totalProfitIRR;
  final double totalProfitUSD;
  final double currentValueUSD;

  const DailyProfitsLoaded({
    required this.dailyProfits,
    required this.period,
    required this.chartViewType,
    required this.totalProfitIRR,
    required this.totalProfitUSD,
    required this.currentValueUSD,
  });

  @override
  List<Object?> get props => [
    dailyProfits,
    period,
    chartViewType,
    totalProfitIRR,
    totalProfitUSD,
    currentValueUSD,
  ];

  /// Get chart data points based on view type
  List<double> get chartData {
    switch (chartViewType) {
      case ChartViewType.profitIRR:
        return dailyProfits.map((d) => d.profitIRR).toList();
      case ChartViewType.profitUSD:
        return dailyProfits.map((d) => d.profitUSD).toList();
      case ChartViewType.salesCount:
        return dailyProfits.map((d) => d.invoiceCount.toDouble()).toList();
      case ChartViewType.valueLoss:
        // Show cumulative value loss/gain
        double cumulative = 0;
        return dailyProfits.map((d) {
          cumulative += d.profitUSD;
          return cumulative;
        }).toList();
    }
  }

  /// Get chart labels (dates)
  List<String> get chartLabels {
    return dailyProfits.map((d) => '${d.date.day}/${d.date.month}').toList();
  }
}

/// Combined state with both summary and chart data
class ProfitReportLoaded extends ProfitReportState {
  final ProfitSummary summary;
  final List<DailyProfit> dailyProfits;
  final ProfitPeriod period;
  final ChartViewType chartViewType;
  final double currentExchangeRate;

  const ProfitReportLoaded({
    required this.summary,
    required this.dailyProfits,
    required this.period,
    this.chartViewType = ChartViewType.profitIRR,
    required this.currentExchangeRate,
  });

  @override
  List<Object?> get props => [
    summary,
    dailyProfits,
    period,
    chartViewType,
    currentExchangeRate,
  ];

  /// Value change indicator
  bool get hasValueLoss => summary.valueDifferenceUSD < 0;
  bool get hasValueGain => summary.valueDifferenceUSD > 0;

  /// Copy with different chart view
  ProfitReportLoaded copyWithChartView(ChartViewType newViewType) {
    return ProfitReportLoaded(
      summary: summary,
      dailyProfits: dailyProfits,
      period: period,
      chartViewType: newViewType,
      currentExchangeRate: currentExchangeRate,
    );
  }
}

/// Error state
class ProfitReportError extends ProfitReportState {
  final String message;

  const ProfitReportError(this.message);

  @override
  List<Object?> get props => [message];
}
