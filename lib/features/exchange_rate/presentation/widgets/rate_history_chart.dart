import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/exchange_rate.dart';

/// Chart widget for displaying rate history
class RateHistoryChart extends StatelessWidget {
  final List<ExchangeRate> history;
  final String currencyCode;

  const RateHistoryChart({
    super.key,
    required this.history,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: Text(
          'داده‌ای برای نمایش وجود ندارد',
          style: TextStyle(color: Colors.grey[600]),
        ),
      );
    }

    final sortedHistory = List<ExchangeRate>.from(history)
      ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));

    final minRate = sortedHistory
        .map((e) => e.rate)
        .reduce((a, b) => a < b ? a : b);
    final maxRate = sortedHistory
        .map((e) => e.rate)
        .reduce((a, b) => a > b ? a : b);

    final spots = sortedHistory.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.rate);
    }).toList();

    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('کمترین', _formatRate(minRate), Colors.green),
              _buildStatItem('بیشترین', _formatRate(maxRate), Colors.red),
              _buildStatItem('تعداد', '${history.length}', Colors.blue),
            ],
          ),
          const SizedBox(height: 16),
          // Chart
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  // Fix: prevent division by zero when minRate == maxRate
                  horizontalInterval: maxRate > minRate
                      ? (maxRate - minRate) / 4
                      : maxRate / 10,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withAlpha(51),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          _formatRate(value),
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: history.length > 7
                          ? (history.length / 4).ceil().toDouble()
                          : 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < sortedHistory.length) {
                          final date = sortedHistory[index].recordedAt;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              '${date.day}/${date.month}',
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: (history.length - 1).toDouble(),
                minY: minRate * 0.98,
                maxY: maxRate * 1.02,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: _getCurrencyColor(currencyCode),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: history.length <= 15,
                      getDotPainter: (spot, percent, bar, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: bar.color ?? Colors.blue,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: _getCurrencyColor(currencyCode).withAlpha(26),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final index = spot.x.toInt();
                        final rate = sortedHistory[index];
                        return LineTooltipItem(
                          '${_formatRate(spot.y)}\n${rate.recordedAt.day}/${rate.recordedAt.month}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Color _getCurrencyColor(String code) {
    switch (code) {
      case 'USD':
        return Colors.green;
      case 'EUR':
        return Colors.blue;
      case 'AED':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  String _formatRate(double rate) {
    if (rate >= 1000) {
      return '${(rate / 1000).toStringAsFixed(1)}K';
    }
    return rate.toStringAsFixed(0);
  }
}
