import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_bloc.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_event.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_state.dart';

class EditProductPage extends StatefulWidget {
  final ProductEntity product;

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showAdditionalInfo = false;

  late TextEditingController _nameController;
  late TextEditingController _serialNumberController;
  late TextEditingController _originalPriceController;
  late TextEditingController _modelController;
  late TextEditingController _colorController;
  late TextEditingController _materialController;
  late TextEditingController _currentStockController;
  late TextEditingController _descriptionController;
  late TextEditingController _brandController;
  late TextEditingController _reorderPointController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _serialNumberController = TextEditingController(
      text: widget.product.serialNumber,
    );
    _originalPriceController = TextEditingController(
      text: widget.product.originalPrice.toString(),
    );
    _modelController = TextEditingController(text: widget.product.model);
    _colorController = TextEditingController(text: widget.product.color);
    _materialController = TextEditingController(text: widget.product.material);
    _currentStockController = TextEditingController(
      text: widget.product.currentStock.toString(),
    );
    _descriptionController = TextEditingController(
      text: widget.product.description,
    );
    _brandController = TextEditingController(text: widget.product.brand);
    _reorderPointController = TextEditingController(
      text: widget.product.reorderPoint.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _serialNumberController.dispose();
    _originalPriceController.dispose();
    _modelController.dispose();
    _colorController.dispose();
    _materialController.dispose();
    _currentStockController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    _reorderPointController.dispose();
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
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductUpdatedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.productUpdated),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop(true);
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${l10n.error}: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          body: LayoutBuilder(
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
          l10n.editProduct,
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
                Icons.edit_note_rounded,
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
                    l10n.editProduct,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.product.name,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.product.serialNumber,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              controller: _nameController,
              label: l10n.productName,
              icon: Icons.inventory_2_outlined,
              isRequired: true,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _serialNumberController,
              label: l10n.serialNumber,
              icon: Icons.qr_code,
              isRequired: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _originalPriceController,
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
            _buildTextField(
              controller: _currentStockController,
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
              controller: _descriptionController,
              label: l10n.description,
              icon: Icons.description_outlined,
              isRequired: false,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

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
                  if (isDesktop)
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _modelController,
                            label: l10n.model,
                            icon: Icons.category_outlined,
                            isRequired: false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _colorController,
                            label: l10n.color,
                            icon: Icons.palette_outlined,
                            isRequired: false,
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _buildTextField(
                      controller: _modelController,
                      label: l10n.model,
                      icon: Icons.category_outlined,
                      isRequired: false,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _colorController,
                      label: l10n.color,
                      icon: Icons.palette_outlined,
                      isRequired: false,
                    ),
                  ],
                  const SizedBox(height: 16),
                  if (isDesktop)
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _materialController,
                            label: l10n.material,
                            icon: Icons.texture,
                            isRequired: false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _brandController,
                            label: l10n.brand,
                            icon: Icons.business,
                            isRequired: false,
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _buildTextField(
                      controller: _materialController,
                      label: l10n.material,
                      icon: Icons.texture,
                      isRequired: false,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _brandController,
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
                    controller: _reorderPointController,
                    label: l10n.reorderPoint,
                    icon: Icons.low_priority,
                    isRequired: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        if (int.tryParse(value!) == null) {
                          return l10n.numberFieldError;
                        }
                      }
                      return null;
                    },
                  ),
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
                  l10n.saveChanges,
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

  bool _formHasChanges() {
    return _nameController.text != widget.product.name ||
        _serialNumberController.text != widget.product.serialNumber ||
        _originalPriceController.text !=
            widget.product.originalPrice.toString() ||
        _modelController.text != widget.product.model ||
        _colorController.text != widget.product.color ||
        _materialController.text != widget.product.material ||
        _currentStockController.text !=
            widget.product.currentStock.toString() ||
        _descriptionController.text != widget.product.description ||
        _brandController.text != widget.product.brand ||
        _reorderPointController.text != widget.product.reorderPoint.toString();
  }

  void _submitForm() {
    final l10n = AppLocalizations.of(context);

    if (_formKey.currentState!.validate()) {
      try {
        final updatedProduct = widget.product.copyWith(
          name: _nameController.text,
          serialNumber: _serialNumberController.text,
          originalPrice: double.parse(_originalPriceController.text),
          model: _modelController.text,
          color: _colorController.text,
          material: _materialController.text,
          currentStock: int.parse(_currentStockController.text),
          description: _descriptionController.text,
          brand: _brandController.text,
          reorderPoint: int.parse(_reorderPointController.text),
        );

        context.read<ProductBloc>().add(ProductUpdateRequested(updatedProduct));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.error), backgroundColor: Colors.red),
        );
      }
    }
  }
}
