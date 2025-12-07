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
    // Rate meaning: 1 Unit = X Tomans.
    // e.g. Dollar Rate = 60000 => 1 Dollar = 60000 Tomans.
    // final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تنظیمات واحد پول'), // Localize if possible
      ),
      body: BlocConsumer<CurrencyBloc, CurrencyState>(
        listener: (context, state) {
          if (state is CurrencyLoaded) {
            // Update controllers if rates change from outside or initial load
            state.rates.forEach((code, rate) {
              if (!_controllers.containsKey(code)) {
                _controllers[code] = TextEditingController();
              }
              // Only update text if not focused to avoid cursor jumps?
              // Or simplified: Just set it if different to avoid loop.
              if (_controllers[code]!.text != rate.toString()) {
                // check if it's mostly integer
                if (rate % 1 == 0) {
                  _controllers[code]!.text = rate.toInt().toString();
                } else {
                  _controllers[code]!.text = rate.toString();
                }
              }
            });
          }
        },
        builder: (context, state) {
          if (state is CurrencyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrencyLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'واحد پول نمایش',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Column(
                      children: CurrencyCode.values.map((currency) {
                        return RadioListTile<CurrencyCode>(
                          title: Text('${currency.name} (${currency.symbol})'),
                          value: currency,
                          groupValue: state.selectedCurrency,
                          onChanged: (value) {
                            if (value != null) {
                              context.read<CurrencyBloc>().add(
                                ChangeCurrency(value),
                              );
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'نرخ تبدیل (نسبت به تومان)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'مشخص کنید هر واحد ارز خارجی معادل چند تومان است.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: CurrencyCode.values.map((currency) {
                          // Skip Toman as it is base (1.0)
                          if (currency == CurrencyCode.toman)
                            return const SizedBox.shrink();

                          // Ensure controller exists
                          if (!_controllers.containsKey(currency)) {
                            _controllers[currency] = TextEditingController(
                              text: state.rates[currency]?.toString() ?? '1.0',
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${currency.name} (${currency.symbol}) :',
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    controller: _controllers[currency],
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*'),
                                      ),
                                    ],
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                      suffixText: 'تومان',
                                    ),
                                    onChanged: (value) {
                                      // We can save on submit or use a debounce or separate save button.
                                      // For better UX, let's use a "Save Rates" button at bottom.
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        final Map<CurrencyCode, double> newRates = {};
                        // Always keep Toman as 1
                        newRates[CurrencyCode.toman] = 1.0;

                        _controllers.forEach((code, controller) {
                          if (code != CurrencyCode.toman) {
                            final val = double.tryParse(controller.text) ?? 1.0;
                            newRates[code] = val;
                          }
                        });

                        context.read<CurrencyBloc>().add(
                          UpdateCurrencyRates(newRates),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('نرخ‌ها ذخیره شدند')),
                        );
                      },
                      child: const Text('ذخیره نرخ‌ها'),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Error loading settings'));
        },
      ),
    );
  }
}
