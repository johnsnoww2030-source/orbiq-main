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

  DateTime _purchaseDate = DateTime.now();
  DateTime? _discountStartDate;
  DateTime? _discountEndDate;
  final DateTime _lastStockUpdate = DateTime.now();

  @override
  void dispose() {
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
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
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
                  content: Text('${l10n.error}: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 800;
              return CustomScrollView(
                slivers: [
                  _buildAppBar(context, l10n, isDesktop),
                  SliverPadding(
                    padding: EdgeInsets.all(isDesktop ? 32 : 16),
                    sliver: SliverToBoxAdapter(
                      child: Form(
                        key: _formKey,
                        child: isDesktop
                            ? _buildDesktopLayout(l10n)
                            : _buildMobileLayout(l10n),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    AppLocalizations l10n,
    bool isDesktop,
  ) {
    return SliverAppBar(
      expandedHeight: isDesktop ? 120 : 80,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          l10n.addNewProduct,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget _buildDesktopLayout(AppLocalizations l10n) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderSection(l10n),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildMainInfoCard(l10n, isDesktop: true)),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildAdditionalInfoCard(l10n, isDesktop: true),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSubmitButton(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeaderSection(l10n),
        const SizedBox(height: 16),
        _buildMainInfoCard(l10n, isDesktop: false),
        const SizedBox(height: 16),
        _buildAdditionalInfoCard(l10n, isDesktop: false),
        const SizedBox(height: 24),
        _buildSubmitButton(l10n),
      ],
    );
  }

  Widget _buildHeaderSection(AppLocalizations l10n) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.add_box_rounded,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.addNewProduct,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.fillProductInfo,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // اطلاعات پایه: نام، سریال، قیمت، موجودی فعلی، توضیحات
  Widget _buildMainInfoCard(AppLocalizations l10n, {required bool isDesktop}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(l10n.basicInformation, Icons.info_outline),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _controllers['name']!,
              label: l10n.productName,
              icon: Icons.inventory_2_outlined,
              isRequired: true,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _controllers['serialNumber']!,
              label: l10n.serialNumber,
              icon: Icons.qr_code,
              isRequired: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _controllers['originalPrice']!,
              label: l10n.originalPrice,
              icon: Icons.attach_money,
              isRequired: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
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
            const SizedBox(height: 16),
            // موجودی فعلی - منتقل شده به بخش اطلاعات پایه
            _buildTextField(
              controller: _controllers['currentStock']!,
              label: l10n.currentStock,
              icon: Icons.numbers,
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
            _buildTextField(
              controller: _controllers['description']!,
              label: l10n.description,
              icon: Icons.description_outlined,
              maxLines: 3,
              isRequired: false,
            ),
          ],
        ),
      ),
    );
  }

  // جزئیات تکمیلی: مدل، رنگ، جنس، برند، نقطه سفارش، قیمت تخفیف، تاریخ‌ها
  Widget _buildAdditionalInfoCard(
    AppLocalizations l10n, {
    required bool isDesktop,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _showAdditionalInfo = !_showAdditionalInfo;
              });
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.tune,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.additionalDetails,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _showAdditionalInfo ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 16),
                  // مدل و رنگ
                  if (isDesktop)
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _controllers['model']!,
                            label: l10n.model,
                            icon: Icons.category_outlined,
                            isRequired: false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _controllers['color']!,
                            label: l10n.color,
                            icon: Icons.palette_outlined,
                            isRequired: false,
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _buildTextField(
                      controller: _controllers['model']!,
                      label: l10n.model,
                      icon: Icons.category_outlined,
                      isRequired: false,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _controllers['color']!,
                      label: l10n.color,
                      icon: Icons.palette_outlined,
                      isRequired: false,
                    ),
                  ],
                  const SizedBox(height: 16),
                  // جنس و برند
                  if (isDesktop)
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _controllers['material']!,
                            label: l10n.material,
                            icon: Icons.texture,
                            isRequired: false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _controllers['brand']!,
                            label: l10n.brand,
                            icon: Icons.business,
                            isRequired: false,
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _buildTextField(
                      controller: _controllers['material']!,
                      label: l10n.material,
                      icon: Icons.texture,
                      isRequired: false,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _controllers['brand']!,
                      label: l10n.brand,
                      icon: Icons.business,
                      isRequired: false,
                    ),
                  ],
                  const SizedBox(height: 24),
                  _buildSectionTitle(
                    l10n.stockInformation,
                    Icons.inventory_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _controllers['reorderPoint']!,
                    label: l10n.reorderPoint,
                    icon: Icons.low_priority,
                    isRequired: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle(
                    l10n.pricingInformation,
                    Icons.sell_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _controllers['discountedPrice']!,
                    label: l10n.discountedPrice,
                    icon: Icons.discount_outlined,
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
                  const SizedBox(height: 24),
                  _buildSectionTitle(
                    l10n.datesInformation,
                    Icons.calendar_today,
                  ),
                  const SizedBox(height: 12),
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
                    const SizedBox(height: 12),
                    _buildDatePicker(
                      label: l10n.discountStartDate,
                      selectedDate: _discountStartDate,
                      onDateSelected: (date) {
                        setState(() {
                          _discountStartDate = date;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
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
            crossFadeState: _showAdditionalInfo
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
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
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: ListTile(
        leading: Icon(Icons.event, color: Theme.of(context).primaryColor),
        title: Text(label),
        subtitle: Text(
          selectedDate != null
              ? Jalali.fromDateTime(selectedDate).formatFullDate()
              : '-',
          style: TextStyle(
            color: selectedDate != null
                ? Theme.of(context).textTheme.bodyLarge?.color
                : Colors.grey,
          ),
        ),
        trailing: const Icon(Icons.chevron_left),
        onTap: () async {
          final picked = await showPersianDatePicker(
            context: context,
            initialDate: Jalali.fromDateTime(selectedDate ?? DateTime.now()),
            firstDate: Jalali(1380, 1),
            lastDate: Jalali(1410, 12),
          );
          if (picked != null && mounted) {
            onDateSelected(picked.toDateTime());
          }
        },
      ),
    );
  }

  // دکمه ذخیره بهبود یافته
  Widget _buildSubmitButton(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withValues(alpha: 0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _submitForm,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.save_rounded, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text(
                  l10n.save,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
                FilledButton(
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

  void _submitForm() {
    final l10n = AppLocalizations.of(context);

    if (_formKey.currentState!.validate()) {
      try {
        final originalPrice = double.parse(_controllers['originalPrice']!.text);
        final currentStock = int.parse(_controllers['currentStock']!.text);

        double? discountedPrice;
        if (_controllers['discountedPrice']!.text.isNotEmpty) {
          discountedPrice = double.tryParse(
            _controllers['discountedPrice']!.text,
          );
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

        context.read<ProductBloc>().add(ProductAddRequested(product));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.error), backgroundColor: Colors.red),
        );
      }
    }
  }

  bool _formHasChanges() {
    return _controllers.values.any((controller) => controller.text.isNotEmpty);
  }
}
