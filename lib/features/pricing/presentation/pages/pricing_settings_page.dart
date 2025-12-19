import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pricing_settings_bloc.dart';
import '../bloc/pricing_settings_event.dart';
import '../bloc/pricing_settings_state.dart';
import '../../domain/entities/pricing_settings.dart';

/// Pricing Settings Page
/// Configure profit margins, rounding, and tracked currencies
class PricingSettingsPage extends StatefulWidget {
  const PricingSettingsPage({super.key});

  @override
  State<PricingSettingsPage> createState() => _PricingSettingsPageState();
}

class _PricingSettingsPageState extends State<PricingSettingsPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _minMarginController;
  late TextEditingController _defaultMarginController;
  late TextEditingController _maxMarginController;
  late TextEditingController _roundingStepController;

  List<String> _trackedCurrencies = ['USD', 'EUR', 'AED'];
  final List<String> _availableCurrencies = [
    'USD',
    'EUR',
    'AED',
    'GBP',
    'TRY',
    'CNY',
  ];

  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _minMarginController = TextEditingController();
    _defaultMarginController = TextEditingController();
    _maxMarginController = TextEditingController();
    _roundingStepController = TextEditingController();

    // Load current settings
    context.read<PricingSettingsBloc>().add(const LoadPricingSettingsEvent());
  }

  @override
  void dispose() {
    _minMarginController.dispose();
    _defaultMarginController.dispose();
    _maxMarginController.dispose();
    _roundingStepController.dispose();
    super.dispose();
  }

  void _populateFields(PricingSettings settings) {
    _minMarginController.text = settings.minProfitMargin.toString();
    _defaultMarginController.text = settings.defaultProfitMargin.toString();
    _maxMarginController.text = settings.maxProfitMargin.toString();
    _roundingStepController.text = settings.roundingStep.toString();
    _trackedCurrencies = List.from(settings.trackCurrencies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تنظیمات قیمت‌گذاری'),
        actions: [
          if (_hasChanges)
            TextButton.icon(
              onPressed: _saveSettings,
              icon: const Icon(Icons.save),
              label: const Text('ذخیره'),
            ),
        ],
      ),
      body: BlocConsumer<PricingSettingsBloc, PricingSettingsState>(
        listener: (context, state) {
          if (state is PricingSettingsLoaded) {
            _populateFields(state.settings);
          } else if (state is PricingSettingsUpdated) {
            setState(() => _hasChanges = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تنظیمات ذخیره شد'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is PricingSettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PricingSettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              onChanged: () => setState(() => _hasChanges = true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profit Margins Section
                  _buildSectionHeader('حاشیه سود', Icons.percent),
                  const SizedBox(height: 16),
                  _buildMarginInputs(),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Rounding Section
                  _buildSectionHeader('گرد کردن قیمت', Icons.rounded_corner),
                  const SizedBox(height: 16),
                  _buildRoundingInput(),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Currencies Section
                  _buildSectionHeader(
                    'ارزهای قابل پیگیری',
                    Icons.currency_exchange,
                  ),
                  const SizedBox(height: 16),
                  _buildCurrencySelector(),

                  const SizedBox(height: 32),

                  // Preview Section
                  _buildPreviewSection(),

                  const SizedBox(height: 24),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _hasChanges ? _saveSettings : null,
                      icon: const Icon(Icons.save),
                      label: const Text('ذخیره تنظیمات'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMarginInputs() {
    return Column(
      children: [
        // Visual Margin Slider
        _buildMarginVisualizer(),
        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: _buildMarginField(
                'حداقل',
                _minMarginController,
                Colors.orange,
                'کف سود',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMarginField(
                'پیش‌فرض',
                _defaultMarginController,
                Colors.green,
                'سود معمول',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMarginField(
                'حداکثر',
                _maxMarginController,
                Colors.blue,
                'سقف سود',
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),
        Text(
          'توجه: حداقل ۵٪ اختلاف بین هر مرحله الزامی است',
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildMarginVisualizer() {
    final min = double.tryParse(_minMarginController.text) ?? 20;
    final def = double.tryParse(_defaultMarginController.text) ?? 30;
    final max = double.tryParse(_maxMarginController.text) ?? 50;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Scale bar
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.green, Colors.blue],
                    stops: [min / 100, def / 100, max / 100],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${min.toInt()}%',
                style: TextStyle(color: Colors.orange[700]),
              ),
              Text(
                '${def.toInt()}%',
                style: TextStyle(color: Colors.green[700]),
              ),
              Text(
                '${max.toInt()}%',
                style: TextStyle(color: Colors.blue[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarginField(
    String label,
    TextEditingController controller,
    Color color,
    String hint,
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        helperText: hint,
        suffixText: '%',
        prefixIcon: Icon(Icons.percent, color: color),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الزامی';
        }
        final num = double.tryParse(value);
        if (num == null) return 'عدد نامعتبر';
        if (num < 0 || num > 200) return '0-200';
        return null;
      },
    );
  }

  Widget _buildRoundingInput() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: _roundingStepController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'گام گرد کردن',
              helperText: 'مثال: 10000 = گرد به 10 هزار تومان',
              prefixIcon: Icon(Icons.tune),
              border: OutlineInputBorder(),
              suffixText: 'تومان',
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(child: _buildRoundingPreview()),
      ],
    );
  }

  Widget _buildRoundingPreview() {
    final step = int.tryParse(_roundingStepController.text) ?? 10000;
    const examplePrice = 1234567.0;
    final rounded = (examplePrice / step).round() * step;

    return Card(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text('نمونه:', style: TextStyle(fontSize: 12)),
            Text(
              '${examplePrice.toInt()} → ${rounded.toInt()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _availableCurrencies.map((code) {
        final isSelected = _trackedCurrencies.contains(code);
        return FilterChip(
          label: Text(code),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _trackedCurrencies.add(code);
              } else {
                _trackedCurrencies.remove(code);
              }
              _hasChanges = true;
            });
          },
          avatar: CircleAvatar(
            backgroundColor: isSelected ? Colors.green : Colors.grey,
            child: Text(
              code[0],
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPreviewSection() {
    final min = double.tryParse(_minMarginController.text) ?? 20;
    final def = double.tryParse(_defaultMarginController.text) ?? 30;
    final max = double.tryParse(_maxMarginController.text) ?? 50;
    final step = int.tryParse(_roundingStepController.text) ?? 10000;

    // Example calculation with 100$ at 60000 rate
    const costUSD = 100.0;
    const rate = 60000.0;
    final costIRR = costUSD * rate;

    double round(double price) => (price / step).round() * step.toDouble();

    final minPrice = round(costIRR * (1 + min / 100));
    final defPrice = round(costIRR * (1 + def / 100));
    final maxPrice = round(costIRR * (1 + max / 100));

    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.preview, color: Colors.blue[700]),
                const SizedBox(width: 8),
                Text(
                  'پیش‌نمایش',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'محصول \$${costUSD.toInt()} با نرخ ${rate.toInt()} تومان:',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPricePreview('کف', minPrice, Colors.orange),
                _buildPricePreview('فروش', defPrice, Colors.green),
                _buildPricePreview('سقف', maxPrice, Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricePreview(String label, double price, Color color) {
    String formatted;
    if (price >= 1000000) {
      formatted = '${(price / 1000000).toStringAsFixed(1)}M';
    } else {
      formatted = '${(price / 1000).toStringAsFixed(0)}K';
    }

    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            formatted,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  void _saveSettings() {
    if (!_formKey.currentState!.validate()) return;

    final min = double.parse(_minMarginController.text);
    final def = double.parse(_defaultMarginController.text);
    final max = double.parse(_maxMarginController.text);

    // Validate constraints
    if (!(min < def && def < max)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ترتیب باید باشد: حداقل < پیش‌فرض < حداکثر'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if ((def - min) < 5 || (max - def) < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حداقل ۵٪ اختلاف بین مراحل الزامی است'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<PricingSettingsBloc>().add(
      UpdatePricingSettingsEvent(
        minProfitMargin: min,
        defaultProfitMargin: def,
        maxProfitMargin: max,
        roundingStep: int.parse(_roundingStepController.text),
        trackCurrencies: _trackedCurrencies,
      ),
    );
  }
}
