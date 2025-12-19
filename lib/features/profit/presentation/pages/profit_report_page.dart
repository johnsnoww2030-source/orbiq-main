import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import '../bloc/profit_report_bloc.dart';
import '../bloc/profit_report_event.dart';
import '../bloc/profit_report_state.dart';
import '../../domain/entities/profit_summary.dart';
import '../../domain/entities/daily_profit.dart';

/// Profit Report Page
/// Shows profit summary with historical vs current value comparison
class ProfitReportPage extends StatefulWidget {
  const ProfitReportPage({super.key});

  @override
  State<ProfitReportPage> createState() => _ProfitReportPageState();
}

class _ProfitReportPageState extends State<ProfitReportPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfitReportBloc>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('گزارش سود'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<ProfitReportBloc>().init(),
          ),
        ],
      ),
      body: BlocBuilder<ProfitReportBloc, ProfitReportState>(
        builder: (context, state) {
          if (state is ProfitReportLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfitReportError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.read<ProfitReportBloc>().init(),
                    child: const Text('تلاش مجدد'),
                  ),
                ],
              ),
            );
          }

          if (state is ProfitReportLoaded) {
            return _buildReportContent(context, state);
          }

          return const Center(child: Text('در حال بارگذاری...'));
        },
      ),
    );
  }

  Widget _buildReportContent(BuildContext context, ProfitReportLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProfitReportBloc>().init();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            _buildPeriodSelector(state.period),

            const SizedBox(height: 16),

            // Summary Cards
            _buildSummaryCards(state.summary),

            const SizedBox(height: 24),

            // Value Change Alert
            _buildValueChangeAlert(state.summary),

            const SizedBox(height: 24),

            // Chart
            _buildProfitChart(state),

            const SizedBox(height: 24),

            // Detailed Stats
            _buildDetailedStats(state.summary),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector(ProfitPeriod period) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ProfitPeriod.values
            .where((p) => p != ProfitPeriod.custom)
            .map((p) {
              final isSelected = p == period;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(_getPeriodLabel(p)),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      context.read<ProfitReportBloc>().add(
                        ChangePeriodEvent(p),
                      );
                    }
                  },
                ),
              );
            })
            .toList(),
      ),
    );
  }

  Widget _buildSummaryCards(ProfitSummary summary) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCardWithTooltip(
            l10n.profitIRR,
            _formatCurrency(summary.totalProfitIRR),
            'تومان',
            Icons.trending_up,
            Colors.blue,
            l10n.profitIRRDesc,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCardWithTooltip(
            l10n.historicalProfitUSD,
            _formatUSD(summary.totalProfitUSD),
            'دلار',
            Icons.attach_money,
            Colors.green,
            l10n.historicalProfitUSDDesc,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCardWithTooltip(
    String title,
    String value,
    String unit,
    IconData icon,
    Color color,
    String tooltipText,
  ) {
    return GestureDetector(
      onLongPress: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tooltipText),
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tooltip(
                    message: tooltipText,
                    child: Icon(
                      Icons.info_outline,
                      size: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                unit,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueChangeAlert(ProfitSummary summary) {
    final l10n = AppLocalizations.of(context);
    final hasLoss = summary.valueDifferenceUSD < 0;
    final color = hasLoss ? Colors.red : Colors.green;
    final icon = hasLoss ? Icons.trending_down : Icons.trending_up;
    final label = hasLoss ? l10n.valueDecrease : l10n.valueIncrease;

    return Card(
      color: color.withAlpha(25),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.currency_exchange, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.valueComparison,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Tooltip(
                  message: l10n.valueComparisonDesc,
                  child: Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildValueColumn(
                  l10n.atSaleRate,
                  _formatUSD(summary.totalProfitUSD),
                  Colors.grey[700]!,
                ),
                Icon(Icons.arrow_forward, color: Colors.grey[400]),
                _buildValueColumn(
                  l10n.atCurrentRate,
                  _formatUSD(summary.currentValueUSD),
                  Colors.grey[700]!,
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.valueChangeNotOperational),
                        duration: const Duration(seconds: 4),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: color.withAlpha(50),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Icon(icon, color: color),
                        Text(
                          label,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          '${summary.valueDifferencePercent.toStringAsFixed(1)}%',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Explanatory note
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.valueChangeByFXDesc,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Tooltip(
                  message: l10n.effectiveRateDesc,
                  child: Row(
                    children: [
                      Text('${l10n.effectiveRate}: '),
                      Text(
                        '${summary.effectiveRate.toStringAsFixed(0)} تومان',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.info_outline,
                        size: 14,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildProfitChart(ProfitReportLoaded state) {
    if (state.dailyProfits.isEmpty) {
      return Card(
        child: Container(
          height: 200,
          alignment: Alignment.center,
          child: Text(
            'داده‌ای برای نمایش وجود ندارد',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      );
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.bar_chart),
                    SizedBox(width: 8),
                    Text(
                      'نمودار سود',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                _buildChartViewToggle(state.chartViewType),
              ],
            ),
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            child: BarChart(
              BarChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < state.dailyProfits.length) {
                          final date = state.dailyProfits[index].date;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              '${date.day}',
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: state.dailyProfits.asMap().entries.map((entry) {
                  final profit = _getChartValue(
                    entry.value,
                    state.chartViewType,
                  );
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: profit,
                        color: profit >= 0 ? Colors.green : Colors.red,
                        width: 16,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartViewToggle(ChartViewType viewType) {
    return SegmentedButton<ChartViewType>(
      segments: const [
        ButtonSegment(value: ChartViewType.profitIRR, label: Text('ریال')),
        ButtonSegment(value: ChartViewType.profitUSD, label: Text('دلار')),
      ],
      selected: {viewType},
      onSelectionChanged: (selected) {
        context.read<ProfitReportBloc>().add(
          ToggleChartViewEvent(selected.first),
        );
      },
    );
  }

  Widget _buildDetailedStats(ProfitSummary summary) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.analytics),
                SizedBox(width: 8),
                Text(
                  'آمار تفصیلی',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            _buildStatRow('مجموع فروش', _formatCurrency(summary.totalSalesIRR)),
            _buildStatRow('مجموع هزینه', _formatCurrency(summary.totalCostIRR)),
            _buildStatRow('سود خالص', _formatCurrency(summary.totalProfitIRR)),
            const Divider(),
            _buildStatRow(
              'درصد سود',
              '${summary.profitMarginPercent.toStringAsFixed(1)}%',
            ),
            _buildStatRow('تعداد فاکتور', '${summary.invoiceCount}'),
            _buildStatRow('تعداد آیتم', '${summary.itemCount}'),
            _buildStatRow(
              'میانگین سود هر فاکتور',
              _formatCurrency(summary.averageProfitPerInvoice),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  double _getChartValue(DailyProfit profit, ChartViewType viewType) {
    switch (viewType) {
      case ChartViewType.profitIRR:
        return profit.profitIRR;
      case ChartViewType.profitUSD:
        return profit.profitUSD;
      case ChartViewType.salesCount:
        return profit.invoiceCount.toDouble();
      case ChartViewType.valueLoss:
        return profit.profitUSD;
    }
  }

  String _getPeriodLabel(ProfitPeriod period) {
    switch (period) {
      case ProfitPeriod.today:
        return 'امروز';
      case ProfitPeriod.thisWeek:
        return 'این هفته';
      case ProfitPeriod.thisMonth:
        return 'این ماه';
      case ProfitPeriod.lastMonth:
        return 'ماه گذشته';
      case ProfitPeriod.last3Months:
        return '۳ ماه اخیر';
      case ProfitPeriod.thisYear:
        return 'امسال';
      case ProfitPeriod.custom:
        return 'سفارشی';
    }
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000000) {
      return '${(amount / 1000000000).toStringAsFixed(1)} میلیارد';
    } else if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)} میلیون';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    }
    return amount.toStringAsFixed(0);
  }

  String _formatUSD(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }
}
