import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/reports/domain/entities/report_data.dart';
import 'package:orbiq/features/reports/presentation/controller/reports_bloc.dart';
import 'package:orbiq/features/reports/presentation/controller/reports_event.dart';
import 'package:orbiq/features/reports/presentation/controller/reports_state.dart';
import 'package:orbiq/features/exports/presentation/ui/export_widget.dart';

/// Reports Page - shows sales summary, profit chart, and top products
/// Uses BLoC pattern following Clean Architecture
class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reports),
        centerTitle: true,
        actions: [
          BlocBuilder<ReportsBloc, ReportsState>(
            builder: (context, state) {
              if (state is ReportsLoaded) {
                return ExportWidget(
                  data: _buildExportData(state, l10n),
                  fileNamePrefix: 'reports',
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocConsumer<ReportsBloc, ReportsState>(
        listener: (context, state) {
          if (state is ReportsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              // Time filter tabs
              _buildPeriodTabs(context, l10n, state),

              // Content
              Expanded(child: _buildContent(context, l10n, state, isDesktop)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPeriodTabs(
    BuildContext context,
    AppLocalizations l10n,
    ReportsState state,
  ) {
    final selectedPeriod = state is ReportsLoaded ? state.selectedPeriod : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildPeriodChip(context, 0, l10n.today, selectedPeriod),
          const SizedBox(width: 8),
          _buildPeriodChip(context, 1, l10n.thisWeek, selectedPeriod),
          const SizedBox(width: 8),
          _buildPeriodChip(context, 2, l10n.thisMonth, selectedPeriod),
        ],
      ),
    );
  }

  Widget _buildPeriodChip(
    BuildContext context,
    int period,
    String label,
    int selectedPeriod,
  ) {
    final isSelected = selectedPeriod == period;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          context.read<ReportsBloc>().add(PeriodChanged(period));
        }
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    AppLocalizations l10n,
    ReportsState state,
    bool isDesktop,
  ) {
    if (state is ReportsLoading || state is ReportsInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ReportsLoaded) {
      return RefreshIndicator(
        onRefresh: () async {
          context.read<ReportsBloc>().add(const ReportsRefreshRequested());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: isDesktop
              ? _buildDesktopLayout(context, l10n, state)
              : _buildMobileLayout(context, l10n, state),
        ),
      );
    }

    // Error or unknown state
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(l10n.error, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<ReportsBloc>().add(const ReportsLoadRequested());
            },
            child: Text(l10n.error),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    AppLocalizations l10n,
    ReportsLoaded state,
  ) {
    return Column(
      children: [
        // Summary cards row
        _buildSummaryCards(context, l10n, state),
        const SizedBox(height: 24),
        // Chart and top products side by side
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildSalesChart(context, l10n, state)),
            const SizedBox(width: 16),
            Expanded(child: _buildTopProducts(context, l10n, state)),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    AppLocalizations l10n,
    ReportsLoaded state,
  ) {
    return Column(
      children: [
        _buildSummaryCards(context, l10n, state),
        const SizedBox(height: 24),
        _buildSalesChart(context, l10n, state),
        const SizedBox(height: 24),
        _buildTopProducts(context, l10n, state),
      ],
    );
  }

  Widget _buildSummaryCards(
    BuildContext context,
    AppLocalizations l10n,
    ReportsLoaded state,
  ) {
    final priceFormat = NumberFormat('#,##0');

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            context,
            Icons.attach_money,
            l10n.totalSales,
            priceFormat.format(state.totalRevenue),
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard(
            context,
            Icons.trending_up,
            l10n.totalProfit,
            priceFormat.format(state.totalProfit),
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard(
            context,
            Icons.receipt,
            l10n.salesCount,
            '${state.salesCount}',
            Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesChart(
    BuildContext context,
    AppLocalizations l10n,
    ReportsLoaded state,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.salesChart,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 220,
              child: state.dailySales.isEmpty
                  ? Center(
                      child: Text(
                        l10n.noData,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    )
                  : BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: _getMaxRevenue(state.dailySales) * 1.2,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              final value = NumberFormat(
                                '#,##0',
                              ).format(rod.toY);
                              return BarTooltipItem(
                                value,
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index >= 0 &&
                                    index < state.dailySales.length) {
                                  final date = state.dailySales[index].date;
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      '${date.month}/${date.day}',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                        barGroups: state.dailySales.asMap().entries.map((
                          entry,
                        ) {
                          final revenue = entry.value.revenue;
                          return BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(
                                toY: revenue,
                                color: Theme.of(context).primaryColor,
                                width: 20,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
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
      ),
    );
  }

  double _getMaxRevenue(List<DailySalesEntity> dailySales) {
    if (dailySales.isEmpty) return 1000000;
    double max = 0;
    for (final day in dailySales) {
      final revenue = day.revenue;
      if (revenue > max) max = revenue;
    }
    return max > 0 ? max : 1000000;
  }

  Widget _buildTopProducts(
    BuildContext context,
    AppLocalizations l10n,
    ReportsLoaded state,
  ) {
    final priceFormat = NumberFormat('#,##0');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.emoji_events, color: Colors.amber),
                const SizedBox(width: 8),
                Text(
                  l10n.topProducts,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            if (state.topProducts.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    l10n.noData,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              )
            else
              ...List.generate(state.topProducts.length, (index) {
                final product = state.topProducts[index];
                final name = product.productName;
                final quantity = product.quantity;
                final revenue = product.revenue;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getRankColor(index),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('$quantity ${l10n.items}'),
                  trailing: Text(
                    priceFormat.format(revenue),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.brown;
      default:
        return Colors.blueGrey;
    }
  }

  /// Build export data for PDF/Excel export
  List<List<dynamic>> _buildExportData(
    ReportsLoaded state,
    AppLocalizations l10n,
  ) {
    final priceFormat = NumberFormat('#,##0');
    final data = <List<dynamic>>[];

    // Header row
    data.add([l10n.reports, '', '', '']);

    // Summary section
    data.add([l10n.totalSales, priceFormat.format(state.totalRevenue), '', '']);
    data.add([l10n.totalProfit, priceFormat.format(state.totalProfit), '', '']);
    data.add([l10n.salesCount, '${state.salesCount}', '', '']);
    data.add(['', '', '', '']);

    // Daily sales section
    data.add([l10n.salesChart, '', '', '']);
    data.add([l10n.date, l10n.totalSales, '', '']);
    for (final day in state.dailySales) {
      data.add([
        '${day.date.year}/${day.date.month}/${day.date.day}',
        priceFormat.format(day.revenue),
        '',
        '',
      ]);
    }
    data.add(['', '', '', '']);

    // Top products section
    data.add([l10n.topProducts, '', '', '']);
    data.add([l10n.productName, l10n.quantity, l10n.totalSales, '']);
    for (final product in state.topProducts) {
      data.add([
        product.productName,
        '${product.quantity}',
        priceFormat.format(product.revenue),
        '',
      ]);
    }

    return data;
  }
}
