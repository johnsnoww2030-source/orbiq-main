import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_bloc.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_event.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_state.dart';

class CurrencySettingsPage extends StatefulWidget {
  const CurrencySettingsPage({super.key});

  @override
  State<CurrencySettingsPage> createState() => _CurrencySettingsPageState();
}

class _CurrencySettingsPageState extends State<CurrencySettingsPage> {
  // To keep track of text controllers for rates
  final Map<CurrencyCode, TextEditingController> _controllers = {};

  // The currency currently being edited in the rate input section
  CurrencyCode _rateEditingCurrency = CurrencyCode.dollar;

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We assume Toman is the Base currency for stored values.
    return Scaffold(
      appBar: AppBar(title: const Text('تنظیمات واحد پول')),
      body: BlocConsumer<CurrencyBloc, CurrencyState>(
        listener: (context, state) {
          if (state is CurrencyLoaded) {
            // Update controllers if rates change from outside or initial load
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
            // Ensure controller exists for current selection
            if (!_controllers.containsKey(_rateEditingCurrency)) {
              _controllers[_rateEditingCurrency] = TextEditingController(
                text: state.rates[_rateEditingCurrency]?.toString() ?? '1.0',
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1000) {
                  return _buildDesktopLayout(context, state);
                } else if (constraints.maxWidth > 700) {
                  return _buildTabletLayout(context, state);
                } else {
                  return _buildMobileLayout(context, state);
                }
              },
            );
          }
          return const Center(child: Text('Error loading settings'));
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, CurrencyLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildConversionRateSection(context, state),
          const SizedBox(height: 48),
          _buildDisplayCurrencySection(context, state),
          const SizedBox(height: 48),
          _buildSaveButton(context, state, isFullWidth: true),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, CurrencyLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildDisplayCurrencySection(context, state)),
              const SizedBox(width: 24),
              Expanded(child: _buildConversionRateSection(context, state)),
            ],
          ),
          const SizedBox(height: 32),
          // Constrained button, centered
          Center(
            child: SizedBox(
              width: 300,
              child: _buildSaveButton(context, state, isFullWidth: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, CurrencyLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildConversionRateSection(context, state)],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildDisplayCurrencySection(context, state)],
              ),
            ),

            const SizedBox(width: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: _buildSaveButton(context, state, isFullWidth: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayCurrencySection(
    BuildContext context,
    CurrencyLoaded state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('واحد پول ', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'با تغییر واحد پولی قیمت ها نیز بصورت خودکار بروز خواهد شد',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CurrencyCode>(
              value: state.selectedCurrency,
              icon: const Icon(Icons.arrow_drop_down),
              dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
              onChanged: (CurrencyCode? newValue) {
                if (newValue != null) {
                  context.read<CurrencyBloc>().add(ChangeCurrency(newValue));
                }
              },
              items: CurrencyCode.values.map<DropdownMenuItem<CurrencyCode>>((
                CurrencyCode currency,
              ) {
                return DropdownMenuItem<CurrencyCode>(
                  value: currency,
                  child: Text('${currency.name} (${currency.symbol})'),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConversionRateSection(
    BuildContext context,
    CurrencyLoaded state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نرخ تبدیل (نسبت به تومان)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'نرخ ارز مورد نظر را انتخاب و مقدار معادل تومانی آن را وارد کنید.',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton<CurrencyCode>(
                  value: _rateEditingCurrency,
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
                  onChanged: (CurrencyCode? newValue) {
                    if (newValue != null && newValue != CurrencyCode.toman) {
                      setState(() {
                        _rateEditingCurrency = newValue;
                      });
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'مقدار به تومان',
                    hintStyle: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      onPressed: () {
                        _controllers[_rateEditingCurrency]?.clear();
                      },
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
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    CurrencyLoaded state, {
    bool isFullWidth = false,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 48, // Consistent height
      child: FilledButton(
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('نرخ‌ها ذخیره شدند')));
        },
        child: const Text('ذخیره نرخ‌ها'),
      ),
    );
  }
}
