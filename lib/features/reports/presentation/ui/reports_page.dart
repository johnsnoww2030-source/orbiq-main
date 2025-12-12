import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/core/database/daos/sales_dao.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';

/// Reports Page - shows sales summary, profit chart, and top products
class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  int _selectedPeriod = 0; // 0=today, 1=this week, 2=this month
  bool _isLoading = true;

  // Report data
  double _totalRevenue = 0;
  double _totalProfit = 0;
  int _salesCount = 0;
  List<Map<String, dynamic>> _dailySales = [];
  List<Map<String, dynamic>> _topProducts = [];
  final Map<String, String> _productNames = {};

  late SalesDao _salesDao;
  late ProductDao _productDao;

  @override
  void initState() {
    super.initState();
    _salesDao = getIt<SalesDao>();
    _productDao = getIt<ProductDao>();
    _loadReportData();
  }

  Future<void> _loadReportData() async {
    setState(() => _isLoading = true);

    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    switch (_selectedPeriod) {
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

    try {
      // Load summary data
      _totalRevenue = await _salesDao.getRevenueInDateRange(startDate, endDate);
      _totalProfit = await _salesDao.getProfitInDateRange(startDate, endDate);
      _salesCount = await _salesDao.getSalesCountInDateRange(
        startDate,
        endDate,
      );

      // Load daily sales for chart
      _dailySales = await _salesDao.getDailySales(startDate, endDate);

      // Load top products
      _topProducts = await _salesDao.getTopSellingProducts(5);

      // Load product names
      for (final product in _topProducts) {
        final p = await _productDao.getProductByUuid(product['productUuid']);
        if (p != null) {
          _productNames[product['productUuid']] = p.name;
        }
      }
    } catch (e) {
      debugPrint('Error loading report data: $e');
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reports), centerTitle: true),
      body: Column(
        children: [
          // Time filter tabs
          _buildPeriodTabs(l10n),

          // Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _loadReportData,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      child: isDesktop
                          ? _buildDesktopLayout(l10n)
                          : _buildMobileLayout(l10n),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodTabs(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildPeriodChip(0, l10n.today, l10n),
          const SizedBox(width: 8),
          _buildPeriodChip(1, l10n.thisWeek, l10n),
          const SizedBox(width: 8),
          _buildPeriodChip(2, l10n.thisMonth, l10n),
        ],
      ),
    );
  }

  Widget _buildPeriodChip(int period, String label, AppLocalizations l10n) {
    final isSelected = _selectedPeriod == period;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => _selectedPeriod = period);
          _loadReportData();
        }
      },
    );
  }

  Widget _buildDesktopLayout(AppLocalizations l10n) {
    return Column(
      children: [
        // Summary cards row
        _buildSummaryCards(l10n),
        const SizedBox(height: 24),
        // Chart and top products side by side
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildSalesChart(l10n)),
            const SizedBox(width: 16),
            Expanded(child: _buildTopProducts(l10n)),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(AppLocalizations l10n) {
    return Column(
      children: [
        _buildSummaryCards(l10n),
        const SizedBox(height: 24),
        _buildSalesChart(l10n),
        const SizedBox(height: 24),
        _buildTopProducts(l10n),
      ],
    );
  }

  Widget _buildSummaryCards(AppLocalizations l10n) {
    final priceFormat = NumberFormat('#,##0');

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            Icons.attach_money,
            l10n.totalSales,
            priceFormat.format(_totalRevenue),
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard(
            Icons.trending_up,
            l10n.totalProfit,
            priceFormat.format(_totalProfit),
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard(
            Icons.receipt,
            l10n.salesCount,
            '$_salesCount',
            Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
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

  Widget _buildSalesChart(AppLocalizations l10n) {
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
              child: _dailySales.isEmpty
                  ? Center(
                      child: Text(
                        l10n.noData,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    )
                  : BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: _getMaxRevenue() * 1.2,
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
                                if (index >= 0 && index < _dailySales.length) {
                                  final date =
                                      _dailySales[index]['date'] as DateTime;
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
                        barGroups: _dailySales.asMap().entries.map((entry) {
                          final revenue =
                              (entry.value['revenue'] as double?) ?? 0.0;
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

  double _getMaxRevenue() {
    if (_dailySales.isEmpty) return 1000000;
    double max = 0;
    for (final day in _dailySales) {
      final revenue = (day['revenue'] as double?) ?? 0.0;
      if (revenue > max) max = revenue;
    }
    return max > 0 ? max : 1000000;
  }

  Widget _buildTopProducts(AppLocalizations l10n) {
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
            if (_topProducts.isEmpty)
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
              ...List.generate(_topProducts.length, (index) {
                final product = _topProducts[index];
                final name =
                    _productNames[product['productUuid']] ??
                    l10n.unknownProduct;
                final quantity = product['quantity'] as int;
                final revenue = (product['revenue'] as double?) ?? 0.0;

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
}
