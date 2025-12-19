import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_bloc.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_event.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_state.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/exchange_rate/presentation/bloc/exchange_rate_bloc.dart';
import 'package:orbiq/features/exchange_rate/presentation/bloc/exchange_rate_event.dart';
import 'package:orbiq/features/exchange_rate/presentation/bloc/exchange_rate_state.dart';
import 'package:orbiq/features/exchange_rate/presentation/widgets/add_rate_dialog.dart';
import 'package:orbiq/features/exchange_rate/presentation/widgets/rate_history_chart.dart';
import 'package:orbiq/features/exchange_rate/domain/entities/exchange_rate.dart';

/// Unified Currency Settings Page
/// Combines currency display settings with exchange rate management
/// Tab 1: Display Unit (from currency feature)
/// Tab 2: Exchange Rates (from exchange_rate feature)
/// Tab 3: Rate History (from exchange_rate feature)
class UnifiedCurrencySettingsPage extends StatefulWidget {
  const UnifiedCurrencySettingsPage({super.key});

  @override
  State<UnifiedCurrencySettingsPage> createState() =>
      _UnifiedCurrencySettingsPageState();
}

class _UnifiedCurrencySettingsPageState
    extends State<UnifiedCurrencySettingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Currency display settings
  final Map<CurrencyCode, TextEditingController> _controllers = {};
  CurrencyCode _rateEditingCurrency = CurrencyCode.dollar;

  // Exchange rate settings
  String _selectedCurrency = 'USD';
  final List<String> _trackedCurrencies = ['USD', 'EUR', 'AED'];

  // Local cache for rates and history to persist across state changes
  Map<String, ExchangeRate> _cachedRates = {};
  List<ExchangeRate> _cachedHistory = [];
  String _cachedHistoryCurrency = '';
  DateTime? _lastRatesLoadTime;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Load exchange rates on page load
    context.read<ExchangeRateBloc>().add(
      LoadCurrentRatesEvent(_trackedCurrencies),
    );
    // Also load history for default currency
    context.read<ExchangeRateBloc>().add(
      LoadRateHistoryEvent(currencyCode: _selectedCurrency),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<ExchangeRateBloc, ExchangeRateState>(
      listener: (context, state) {
        if (state is ExchangeRateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is ExchangeRatesLoaded) {
          // Cache the rates when they are loaded
          setState(() {
            _cachedRates = state.currentRates;
            _lastRatesLoadTime = state.loadedAt;
          });
        } else if (state is RateHistoryLoaded) {
          // Cache the history when it's loaded
          setState(() {
            _cachedHistory = state.history;
            _cachedHistoryCurrency = state.currencyCode;
          });
        } else if (state is ExchangeRateAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${l10n.rateAdded}: ${_formatRate(state.rate.rate)}',
              ),
              backgroundColor: Colors.green,
            ),
          );
          // Refresh both current rates AND history after adding a rate
          final exchangeRateBloc = context.read<ExchangeRateBloc>();
          exchangeRateBloc.add(LoadCurrentRatesEvent(_trackedCurrencies));
          // Delay to ensure rates are loaded first, then load history
          Future.delayed(const Duration(milliseconds: 200), () {
            if (mounted) {
              exchangeRateBloc.add(
                LoadRateHistoryEvent(currencyCode: _selectedCurrency),
              );
            }
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.currencySettings),
          bottom: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                icon: const Icon(Icons.monetization_on_outlined),
                text: l10n.displayUnit,
              ),
              Tab(
                icon: const Icon(Icons.currency_exchange),
                text: l10n.exchangeRates,
              ),
              Tab(icon: const Icon(Icons.timeline), text: l10n.rateHistory),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: Display Unit
            _buildDisplayUnitTab(l10n),
            // Tab 2: Exchange Rates
            _buildExchangeRatesTab(l10n),
            // Tab 3: Rate History
            _buildHistoryTab(l10n),
          ],
        ),
        floatingActionButton: _tabController.index != 0
            ? FloatingActionButton.extended(
                onPressed: () => _showAddRateDialog(context),
                icon: const Icon(Icons.add),
                label: Text(l10n.addRate),
              )
            : null,
      ),
    );
  }

  // ============================================
  // TAB 1: Display Unit (from currency feature)
  // ============================================
  Widget _buildDisplayUnitTab(AppLocalizations l10n) {
    return BlocConsumer<CurrencyBloc, CurrencyState>(
      listener: (context, state) {
        if (state is CurrencyLoaded) {
          state.rates.forEach((code, rate) {
            if (!_controllers.containsKey(code)) {
              _controllers[code] = TextEditingController();
            }
            final textVal = rate % 1 == 0
                ? rate.toInt().toString()
                : rate.toString();
            if (_controllers[code]!.text != textVal) {
              _controllers[code]!.text = textVal;
            }
          });
        }
      },
      builder: (context, state) {
        if (state is CurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CurrencyLoaded) {
          if (!_controllers.containsKey(_rateEditingCurrency)) {
            _controllers[_rateEditingCurrency] = TextEditingController(
              text: state.rates[_rateEditingCurrency]?.toString() ?? '1.0',
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDisplayCurrencySection(context, state, l10n),
                const SizedBox(height: 32),
                _buildConversionRateSection(context, state, l10n),
                const SizedBox(height: 32),
                _buildSaveButton(context, state, l10n),
              ],
            ),
          );
        }
        return Center(child: Text(l10n.error));
      },
    );
  }

  Widget _buildDisplayCurrencySection(
    BuildContext context,
    CurrencyLoaded state,
    AppLocalizations l10n,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.visibility_outlined),
                const SizedBox(width: 8),
                Text(
                  l10n.displayUnit,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.currencyPriceAutoUpdate,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<CurrencyCode>(
                  value: state.selectedCurrency,
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
                  onChanged: (CurrencyCode? newValue) {
                    if (newValue != null) {
                      context.read<CurrencyBloc>().add(
                        ChangeCurrency(newValue),
                      );
                    }
                  },
                  items: CurrencyCode.values
                      .map<DropdownMenuItem<CurrencyCode>>((
                        CurrencyCode currency,
                      ) {
                        return DropdownMenuItem<CurrencyCode>(
                          value: currency,
                          child: Text('${currency.name} (${currency.symbol})'),
                        );
                      })
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionRateSection(
    BuildContext context,
    CurrencyLoaded state,
    AppLocalizations l10n,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.swap_horiz),
                const SizedBox(width: 8),
                Text(
                  l10n.conversionRateToToman,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.selectCurrencyRate,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<CurrencyCode>(
                      value: _rateEditingCurrency,
                      icon: const Icon(Icons.arrow_drop_down),
                      dropdownColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainer,
                      onChanged: (CurrencyCode? newValue) {
                        if (newValue != null &&
                            newValue != CurrencyCode.toman) {
                          setState(() => _rateEditingCurrency = newValue);
                        }
                      },
                      items: CurrencyCode.values
                          .where((c) => c != CurrencyCode.toman)
                          .map<DropdownMenuItem<CurrencyCode>>((
                            CurrencyCode value,
                          ) {
                            return DropdownMenuItem<CurrencyCode>(
                              value: value,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _rateEditingCurrency == value
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.primaryContainer
                                      : Theme.of(
                                          context,
                                        ).colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  value.symbol,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: _rateEditingCurrency == value
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            );
                          })
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 1,
                    height: 24,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      key: ValueKey(_rateEditingCurrency),
                      controller: _controllers[_rateEditingCurrency],
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: l10n.amountInToman,
                        hintStyle: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurfaceVariant.withAlpha(128),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 18,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          onPressed: () =>
                              _controllers[_rateEditingCurrency]?.clear(),
                        ),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    CurrencyLoaded state,
    AppLocalizations l10n,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton.icon(
        onPressed: () {
          final Map<CurrencyCode, double> newRates = {};
          newRates[CurrencyCode.toman] = 1.0;

          for (var code in CurrencyCode.values) {
            if (code == CurrencyCode.toman) continue;

            if (_controllers.containsKey(code) &&
                _controllers[code]!.text.isNotEmpty) {
              final val =
                  double.tryParse(_controllers[code]!.text) ??
                  state.rates[code] ??
                  1.0;
              newRates[code] = val;
            } else {
              newRates[code] = state.rates[code] ?? 1.0;
            }
          }

          context.read<CurrencyBloc>().add(UpdateCurrencyRates(newRates));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.ratesSaved),
              backgroundColor: Colors.green,
            ),
          );
        },
        icon: const Icon(Icons.save),
        label: Text(l10n.saveRates),
      ),
    );
  }

  // ============================================
  // TAB 2: Exchange Rates (from exchange_rate feature)
  // ============================================
  Widget _buildExchangeRatesTab(AppLocalizations l10n) {
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
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
              children: [_buildCurrentRatesSection(state, l10n)],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentRatesSection(
    ExchangeRateState state,
    AppLocalizations l10n,
  ) {
    // Use cached rates if available
    final ratesToShow = state is ExchangeRatesLoaded
        ? state.currentRates
        : _cachedRates;
    final loadTime = state is ExchangeRatesLoaded
        ? state.loadedAt
        : _lastRatesLoadTime;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.currentRates,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (loadTime != null)
              Text(
                '${l10n.lastUpdate}: ${_formatTime(loadTime)}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (state is ExchangeRateLoading && ratesToShow.isEmpty)
          const Center(child: CircularProgressIndicator())
        else if (ratesToShow.isNotEmpty)
          _buildRateCards(ratesToShow)
        else
          _buildEmptyRates(l10n),
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
          _tabController.animateTo(2); // Go to history tab
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
                      color: color.withAlpha(51),
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

  Widget _buildEmptyRates(AppLocalizations l10n) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.currency_exchange, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(l10n.noRatesYet, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  // ============================================
  // TAB 3: Rate History (from exchange_rate feature)
  // ============================================
  Widget _buildHistoryTab(AppLocalizations l10n) {
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCurrencySelector(),
              const SizedBox(height: 16),
              _buildHistoryChart(state, l10n),
            ],
          ),
        );
      },
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

  Widget _buildHistoryChart(ExchangeRateState state, AppLocalizations l10n) {
    // Use cached history if available and currency matches
    final historyToShow =
        (state is RateHistoryLoaded && state.currencyCode == _selectedCurrency)
        ? state.history
        : (_cachedHistoryCurrency == _selectedCurrency
              ? _cachedHistory
              : <ExchangeRate>[]);
    final hasCachedData = historyToShow.isNotEmpty;

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
                  '${l10n.historyOf} $_selectedCurrency',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (state is ExchangeRateLoading && hasCachedData)
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
              ],
            ),
          ),
          if (hasCachedData)
            RateHistoryChart(
              history: historyToShow,
              currencyCode: _selectedCurrency,
            )
          else
            Container(
              height: 200,
              alignment: Alignment.center,
              child: state is ExchangeRateLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      l10n.selectCurrencyToViewHistory,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
            ),
        ],
      ),
    );
  }

  // ============================================
  // Helper Methods
  // ============================================
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
