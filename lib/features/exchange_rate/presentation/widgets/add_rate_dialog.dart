import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/exchange_rate_bloc.dart';
import '../bloc/exchange_rate_event.dart';

/// Dialog for adding a new exchange rate
class AddRateDialog extends StatefulWidget {
  final String initialCurrency;
  final List<String> trackedCurrencies;

  const AddRateDialog({
    super.key,
    required this.initialCurrency,
    required this.trackedCurrencies,
  });

  @override
  State<AddRateDialog> createState() => _AddRateDialogState();
}

class _AddRateDialogState extends State<AddRateDialog> {
  late String _selectedCurrency;
  final _rateController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedSource = 'manual';
  double _confidence = 1.0;

  final List<Map<String, dynamic>> _sources = [
    {'value': 'manual', 'label': 'ورود دستی', 'icon': Icons.edit},
    {'value': 'api_bonbast', 'label': 'بنبست', 'icon': Icons.api},
    {'value': 'api_tgju', 'label': 'TGJU', 'icon': Icons.trending_up},
    {'value': 'market_avg', 'label': 'میانگین بازار', 'icon': Icons.store},
  ];

  @override
  void initState() {
    super.initState();
    _selectedCurrency = widget.initialCurrency;
  }

  @override
  void dispose() {
    _rateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                const Text(
                  'ثبت نرخ جدید',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Currency Selector
            DropdownButtonFormField<String>(
              initialValue: _selectedCurrency,
              decoration: const InputDecoration(
                labelText: 'ارز',
                prefixIcon: Icon(Icons.currency_exchange),
                border: OutlineInputBorder(),
              ),
              items: widget.trackedCurrencies.map((code) {
                return DropdownMenuItem(value: code, child: Text(code));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCurrency = value);
                }
              },
            ),

            const SizedBox(height: 16),

            // Rate Input
            TextFormField(
              controller: _rateController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'نرخ (تومان)',
                prefixIcon: Icon(Icons.price_change),
                border: OutlineInputBorder(),
                hintText: '60000',
              ),
              autofocus: true,
            ),

            const SizedBox(height: 16),

            // Source Selector
            const Text('منبع:', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _sources.map((source) {
                final isSelected = _selectedSource == source['value'];
                return FilterChip(
                  selected: isSelected,
                  label: Text(source['label']),
                  avatar: Icon(
                    source['icon'],
                    size: 16,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                  onSelected: (selected) {
                    setState(() => _selectedSource = source['value']);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Confidence Slider
            Row(
              children: [
                const Text(
                  'اطمینان:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: Slider(
                    value: _confidence,
                    min: 0,
                    max: 1,
                    divisions: 10,
                    label: '${(_confidence * 100).toInt()}%',
                    onChanged: (value) {
                      setState(() => _confidence = value);
                    },
                  ),
                ),
                Text(
                  '${(_confidence * 100).toInt()}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Notes (Optional)
            TextFormField(
              controller: _notesController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'یادداشت (اختیاری)',
                prefixIcon: Icon(Icons.note),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('انصراف'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _submitRate,
                  icon: const Icon(Icons.save),
                  label: const Text('ثبت'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitRate() {
    final rateText = _rateController.text.trim();
    if (rateText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('لطفا نرخ را وارد کنید')));
      return;
    }

    final rate = double.tryParse(rateText);
    if (rate == null || rate <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('نرخ باید عدد مثبت باشد')));
      return;
    }

    context.read<ExchangeRateBloc>().add(
      AddExchangeRateEvent(
        currencyCode: _selectedCurrency,
        rate: rate,
        source: _selectedSource,
        confidence: _confidence,
        notes: _notesController.text.trim().isNotEmpty
            ? _notesController.text.trim()
            : null,
      ),
    );

    Navigator.pop(context);
  }
}
