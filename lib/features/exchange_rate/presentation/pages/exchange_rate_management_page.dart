import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/exchange_rate_bloc.dart';
import '../bloc/exchange_rate_event.dart';
import '../bloc/exchange_rate_state.dart';
import '../widgets/add_rate_dialog.dart';
import '../widgets/rate_history_chart.dart';
import '../../domain/entities/exchange_rate.dart';

/// Exchange Rate Management Page
/// Allows viewing and adding exchange rates
class ExchangeRateManagementPage extends StatefulWidget {
  const ExchangeRateManagementPage({super.key});

  @override
  State<ExchangeRateManagementPage> createState() =>
      _ExchangeRateManagementPageState();
}

class _ExchangeRateManagementPageState
    extends State<ExchangeRateManagementPage> {
  String _selectedCurrency = 'USD';
  final List<String> _trackedCurrencies = ['USD', 'EUR', 'AED'];

  @override
  void initState() {
    super.initState();
    // Load current rates on page load
    context.read<ExchangeRateBloc>().add(
      LoadCurrentRatesEvent(_trackedCurrencies),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت نرخ ارز'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ExchangeRateBloc>().add(const RefreshRatesEvent());
            },
          ),
        ],
      ),
      body: BlocConsumer<ExchangeRateBloc, ExchangeRateState>(
        listener: (context, state) {
          if (state is ExchangeRateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ExchangeRateAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'نرخ ${state.rate.currencyCode} ثبت شد: ${_formatRate(state.rate.rate)}',
                ),
                backgroundColor: Colors.green,
              ),
            );
            // Reload rates
            context.read<ExchangeRateBloc>().add(
              LoadCurrentRatesEvent(_trackedCurrencies),
            );
          } else if (state is ExchangeRateWarning) {
            _showConfirmDialog(context, state);
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ExchangeRateBloc>().add(const RefreshRatesEvent());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Current Rates Cards
                  _buildCurrentRatesSection(state),

                  const SizedBox(height: 24),

                  // Currency Selector
                  _buildCurrencySelector(),

                  const SizedBox(height: 16),

                  // Rate History Chart
                  _buildHistorySection(state),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddRateDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('ثبت نرخ'),
      ),
    );
  }

  Widget _buildCurrentRatesSection(ExchangeRateState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'نرخ‌های فعلی',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (state is ExchangeRatesLoaded)
              Text(
                'آخرین بروزرسانی: ${_formatTime(state.loadedAt)}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (state is ExchangeRateLoading)
          const Center(child: CircularProgressIndicator())
        else if (state is ExchangeRatesLoaded)
          _buildRateCards(state.currentRates)
        else
          _buildEmptyRates(),
      ],
    );
  }

  Widget _buildRateCards(Map<String, ExchangeRate> rates) {
    return Row(
      children: _trackedCurrencies.map((code) {
        final rate = rates[code];
        return Expanded(child: _buildRateCard(code, rate));
      }).toList(),
    );
  }

  Widget _buildRateCard(String code, ExchangeRate? rate) {
    final color = _getCurrencyColor(code);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          setState(() => _selectedCurrency = code);
          context.read<ExchangeRateBloc>().add(
            LoadRateHistoryEvent(currencyCode: code),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: _selectedCurrency == code
                ? Border.all(color: color, width: 2)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      code,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.trending_up, size: 16, color: Colors.grey[400]),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                rate != null ? _formatRate(rate.rate) : '--',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (rate != null)
                Text(
                  _getSourceLabel(rate.source),
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return SegmentedButton<String>(
      segments: _trackedCurrencies.map((code) {
        return ButtonSegment(
          value: code,
          label: Text(code),
          icon: Icon(_getCurrencyIcon(code)),
        );
      }).toList(),
      selected: {_selectedCurrency},
      onSelectionChanged: (selected) {
        setState(() => _selectedCurrency = selected.first);
        context.read<ExchangeRateBloc>().add(
          LoadRateHistoryEvent(currencyCode: selected.first),
        );
      },
    );
  }

  Widget _buildHistorySection(ExchangeRateState state) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.timeline),
                const SizedBox(width: 8),
                Text(
                  'تاریخچه $_selectedCurrency',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (state is RateHistoryLoaded &&
              state.currencyCode == _selectedCurrency)
            RateHistoryChart(
              history: state.history,
              currencyCode: state.currencyCode,
            )
          else
            Container(
              height: 200,
              alignment: Alignment.center,
              child: state is ExchangeRateLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      'برای مشاهده تاریخچه، یک ارز انتخاب کنید',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyRates() {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.currency_exchange, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text('هنوز نرخی ثبت نشده', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  void _showAddRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<ExchangeRateBloc>(),
        child: AddRateDialog(
          initialCurrency: _selectedCurrency,
          trackedCurrencies: _trackedCurrencies,
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, ExchangeRateWarning state) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange[700]),
            const SizedBox(width: 8),
            const Text('تغییر نرخ قابل توجه'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.message),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('نرخ قبلی:'),
                Text(_formatRate(state.previousRate)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('نرخ جدید:'),
                Text(
                  _formatRate(state.newRate),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('تغییر:'),
                Text(
                  '${state.changePercent.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: state.changePercent > 0 ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('انصراف'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Re-add with confirmation flag
            },
            child: const Text('تایید و ثبت'),
          ),
        ],
      ),
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
        return Colors.grey;
    }
  }

  IconData _getCurrencyIcon(String code) {
    switch (code) {
      case 'USD':
        return Icons.attach_money;
      case 'EUR':
        return Icons.euro;
      case 'AED':
        return Icons.currency_exchange;
      default:
        return Icons.money;
    }
  }

  String _formatRate(double rate) {
    if (rate >= 1000000) {
      return '${(rate / 1000000).toStringAsFixed(2)}M';
    } else if (rate >= 1000) {
      return '${(rate / 1000).toStringAsFixed(1)}K';
    }
    return rate.toStringAsFixed(0);
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String _getSourceLabel(String source) {
    switch (source) {
      case 'manual':
        return 'ورود دستی';
      case 'api_bonbast':
        return 'بنبست';
      case 'api_tgju':
        return 'TGJU';
      case 'market_avg':
        return 'میانگین بازار';
      default:
        return source;
    }
  }
}
