import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/repository/product_repository.dart';
import 'package:orbiq/features/get_product/domain/repository/product_repository.dart'
    as get_product;
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_bloc.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_event.dart';

/// Quick Add Product Dialog - simplified form to add a product during purchase
class QuickAddProductDialog extends StatefulWidget {
  const QuickAddProductDialog({super.key});

  /// Shows the dialog and returns the created product if successful
  static Future<ProductEntity?> show(BuildContext context) async {
    return showDialog<ProductEntity>(
      context: context,
      builder: (context) => const QuickAddProductDialog(),
    );
  }

  @override
  State<QuickAddProductDialog> createState() => _QuickAddProductDialogState();
}

class _QuickAddProductDialogState extends State<QuickAddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  final _nameController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _brandController = TextEditingController();

  bool _isLoading = false;
  bool _isCheckingBarcode = false;
  String? _errorMessage;
  ProductEntity? _existingProduct; // Product found with same barcode

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.add_box, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Text(l10n.quickAddProduct),
        ],
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Error message
                if (_errorMessage != null) _buildErrorCard(_errorMessage!),

                // Barcode (first - for real-time check)
                TextFormField(
                  controller: _barcodeController,
                  decoration: InputDecoration(
                    labelText: '${l10n.barcode} *',
                    prefixIcon: const Icon(Icons.qr_code),
                    suffixIcon: _isCheckingBarcode
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.barcodeRequired;
                    }
                    return null;
                  },
                  onChanged: _onBarcodeChanged,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

                // Existing product card (if barcode found)
                if (_existingProduct != null) _buildExistingProductCard(l10n),

                // Product name (disabled if existing product found)
                if (_existingProduct == null) ...[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: '${l10n.productName} *',
                      prefixIcon: const Icon(Icons.inventory_2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (_existingProduct != null) return null;
                      if (value == null || value.trim().isEmpty) {
                        return l10n.productNameRequired;
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  // Brand (optional)
                  TextFormField(
                    controller: _brandController,
                    decoration: InputDecoration(
                      labelText: l10n.brand,
                      prefixIcon: const Icon(Icons.branding_watermark),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 8),

                  // Info text
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue[700],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.quickAddProductHint,
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        if (_existingProduct == null)
          FilledButton.icon(
            onPressed: _isLoading || _isCheckingBarcode ? null : _submit,
            icon: _isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.check),
            label: Text(l10n.add),
          ),
      ],
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildExistingProductCard(AppLocalizations l10n) {
    final product = _existingProduct!;
    final priceFormat = NumberFormat('#,##0');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[700], size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.barcodeExistsMessage,
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.inventory_2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${l10n.stock}: ${product.currentStock}  |  ${l10n.price}: ${priceFormat.format(product.originalPrice)}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(product),
              icon: const Icon(Icons.check),
              label: Text(l10n.useThisProduct),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onBarcodeChanged(String barcode) async {
    // Reset existing product
    if (_existingProduct != null) {
      setState(() => _existingProduct = null);
    }

    // Check only if barcode is long enough
    if (barcode.trim().length < 3) return;

    setState(() => _isCheckingBarcode = true);

    try {
      final repository = getIt<get_product.ProductRepository>();
      final product = await repository.getProductBySerialNumber(barcode.trim());

      if (mounted) {
        setState(() {
          _existingProduct = product;
          _isCheckingBarcode = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isCheckingBarcode = false);
      }
    }
  }

  ProductEntity _buildProductEntity() {
    final now = DateTime.now();
    return ProductEntity(
      uuid: _uuid.v4(),
      name: _nameController.text.trim(),
      serialNumber: _barcodeController.text.trim(),
      brand: _brandController.text.trim().isEmpty
          ? ''
          : _brandController.text.trim(),
      description: '',
      model: '',
      color: '',
      material: '',
      purchaseDate: now,
      originalPrice: 0,
      discountedPrice: 0,
      currentStock: 0,
      reorderPoint: 0,
      lastStockUpdate: now,
      avgBuyPrice: 0,
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // Double-check barcode doesn't exist
    if (_existingProduct != null) {
      setState(() {
        _errorMessage = AppLocalizations.of(context).duplicateBarcodeError;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final product = _buildProductEntity();
      final repository = getIt<ProductRepository>();
      await repository.addProduct(product);

      // Refresh products list
      if (mounted) {
        context.read<GetProductBloc>().add(LoadProducts());
        Navigator.of(context).pop(product);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }
}
