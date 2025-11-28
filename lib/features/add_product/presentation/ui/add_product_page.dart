import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';

import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_bloc.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_event.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_state.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  AddProductPageState createState() => AddProductPageState();
}

class AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showAdditionalInfo = false;

  // کنترلرهای فیلدهای فرم
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'serialNumber': TextEditingController(),
    'originalPrice': TextEditingController(),
    'description': TextEditingController(),
    'model': TextEditingController(),
    'color': TextEditingController(),
    'material': TextEditingController(),
    'currentStock': TextEditingController(),
    'brand': TextEditingController(),
    'discountedPrice': TextEditingController(),
    'reorderPoint': TextEditingController(),
  };

  // تاریخ‌ها
  DateTime _purchaseDate = DateTime.now();
  DateTime? _discountStartDate;
  DateTime? _discountEndDate;
  final DateTime _lastStockUpdate = DateTime.now();

  @override
  void dispose() {
    // آزادسازی تمامی کنترلرها
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return PopScope<bool>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, bool? result) async {
        if (didPop) return;

        final shouldPop = await _onWillPop();

        // اصلاح شده: بررسی mounted بودن قبل از استفاده از context
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.addNewProduct),
          centerTitle: true,
        ),
        body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) async {
            if (!mounted) return;

            final currentContext = context;
            if (state is ProductAdded) {
              if (!mounted) return;
              ScaffoldMessenger.of(currentContext).showSnackBar(
                SnackBar(
                  content: Text(l10n.productAdded),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(currentContext);
            } else if (state is ProductError) {
              if (!mounted) return;
              ScaffoldMessenger.of(currentContext).showSnackBar(
                SnackBar(
                  content: Text('خطا: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMainInformationCard(l10n),
                const SizedBox(height: 16),
                _buildAdditionalInformationCard(l10n),
                const SizedBox(height: 24),
                _buildSubmitButton(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (!mounted) return false;

    if (_formHasChanges()) {
      final l10n = AppLocalizations.of(context);
      return await showDialog<bool>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: Text(l10n.discardChanges),
              content: Text(l10n.confirmDiscard),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(l10n.no),
                ),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: Text(l10n.yes),
                ),
              ],
            ),
          ) ??
          false;
    }
    return true;
  }

  Widget _buildMainInformationCard(AppLocalizations l10n) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.basicInformation,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _controllers['name']!,
              label: l10n.productName,
              isRequired: true,
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _controllers['serialNumber']!,
              label: l10n.serialNumber,
              isRequired: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _controllers['description']!,
              label: l10n.description,
              maxLines: 3,
              isRequired: false,
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _controllers['originalPrice']!,
              label: l10n.originalPrice,
              isRequired: true,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              validator: (value) {
                if (value?.isEmpty ?? true) return l10n.fieldRequired;
                final price = double.tryParse(value!);
                if (price == null || price <= 0) {
                  return l10n.invalidPrice;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInformationCard(AppLocalizations l10n) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            title: Text(l10n.additionalDetails),
            trailing: IconButton(
              icon: Icon(
                  _showAdditionalInfo ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _showAdditionalInfo = !_showAdditionalInfo;
                });
              },
            ),
          ),
          if (_showAdditionalInfo)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(l10n.stockInformation),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _controllers['currentStock']!,
                    label: l10n.currentStock,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value?.isEmpty ?? true) return l10n.fieldRequired;
                      if (int.tryParse(value!) == null) {
                        return l10n.numberFieldError;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSectionHeader(l10n.pricingInformation),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _controllers['discountedPrice']!,
                    label: l10n.discountedPrice,
                    isRequired: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        if (double.tryParse(value!) == null) {
                          return l10n.numberFieldError;
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSectionHeader(l10n.datesInformation),
                  const SizedBox(height: 8),
                  _buildDatePicker(
                    label: l10n.purchaseDate,
                    selectedDate: _purchaseDate,
                    onDateSelected: (date) {
                      setState(() {
                        _purchaseDate = date;
                      });
                    },
                  ),
                  if (_controllers['discountedPrice']!.text.isNotEmpty) ...[
                    _buildDatePicker(
                      label: l10n.discountStartDate,
                      selectedDate: _discountStartDate,
                      onDateSelected: (date) {
                        setState(() {
                          _discountStartDate = date;
                        });
                      },
                    ),
                    _buildDatePicker(
                      label: l10n.discountEndDate,
                      selectedDate: _discountEndDate,
                      onDateSelected: (date) {
                        setState(() {
                          _discountEndDate = date;
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isRequired,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator ?? _defaultValidator(isRequired),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines ?? 1,
    );
  }

  String? Function(String?) _defaultValidator(bool isRequired) {
    if (!isRequired) return (value) => null;

    return (value) {
      if (value?.isEmpty ?? true) {
        return AppLocalizations.of(context).fieldRequired;
      }
      return null;
    };
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return ListTile(
      title: Text(label),
      subtitle: Text(
        selectedDate != null
            ? Jalali.fromDateTime(selectedDate).formatFullDate()
            : '-',
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final picked = await showPersianDatePicker(
          context: context,
          initialDate: Jalali.fromDateTime(selectedDate ?? DateTime.now()),
          firstDate: Jalali(1380, 1),
          lastDate: Jalali(1410, 12),
        );
        if (picked != null && mounted) {
          // اصلاح شده: بررسی mounted بودن پس از عملیات async
          onDateSelected(picked.toDateTime());
        }
      },
    );
  }

  Widget _buildSubmitButton(AppLocalizations l10n) {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        l10n.save,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          // color: Colors.white,
        ),
      ),
    );
  }

  void _submitForm() {
    final l10n = AppLocalizations.of(context);

    if (_formKey.currentState!.validate()) {
      try {
        // استخراج و تبدیل مقادیر عددی
        final originalPrice = double.parse(_controllers['originalPrice']!.text);
        final currentStock = int.parse(_controllers['currentStock']!.text);

        // فیلدهای اختیاری
        double? discountedPrice;
        if (_controllers['discountedPrice']!.text.isNotEmpty) {
          discountedPrice =
              double.tryParse(_controllers['discountedPrice']!.text);
        }

        int? reorderPoint;
        if (_controllers['reorderPoint']!.text.isNotEmpty) {
          reorderPoint = int.tryParse(_controllers['reorderPoint']!.text);
        }

        final product = ProductEntity(
          name: _controllers['name']!.text,
          serialNumber: _controllers['serialNumber']!.text,
          description: _controllers['description']!.text,
          model: _controllers['model']!.text,
          color: _controllers['color']!.text,
          material: _controllers['material']!.text,
          originalPrice: originalPrice,
          currentStock: currentStock,
          brand: _controllers['brand']!.text,
          discountedPrice: discountedPrice ?? 0,
          reorderPoint: reorderPoint ?? 0,
          purchaseDate: _purchaseDate,
          discountStartDate: _discountStartDate,
          discountEndDate: _discountEndDate,
          lastStockUpdate: _lastStockUpdate,
        );

        context.read<ProductBloc>().add(AddProductEvent(product));
      } catch (e) {
        _showMessage(context, l10n.error, Colors.red);
      }
    }
  }

  bool _formHasChanges() {
    return _controllers.values.any((controller) => controller.text.isNotEmpty);
  }

  void _showMessage(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
