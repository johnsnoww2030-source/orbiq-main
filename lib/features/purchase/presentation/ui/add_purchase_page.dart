import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/core/shared/product/domain/repositories/product_stock_repository.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_bloc.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_event.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_state.dart';
import 'package:orbiq/features/purchase/presentation/controller/purchase_bloc.dart';
import 'package:orbiq/features/purchase/presentation/controller/purchase_event.dart';
import 'package:orbiq/features/purchase/presentation/controller/purchase_state.dart';
import 'package:orbiq/features/purchase/domain/entities/purchase_entity.dart';
import 'package:orbiq/features/purchase/presentation/ui/widgets/quick_add_product_dialog.dart';
import 'package:orbiq/features/purchase/presentation/ui/widgets/pricing_suggestion_dialog.dart';

/// Add Purchase Page - form to create a new purchase invoice
class AddPurchasePage extends StatefulWidget {
  const AddPurchasePage({super.key});

  @override
  State<AddPurchasePage> createState() => _AddPurchasePageState();
}

class _AddPurchasePageState extends State<AddPurchasePage> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  // Form controllers
  final _supplierController = TextEditingController();
  final _notesController = TextEditingController();
  final _additionalCostsController = TextEditingController(text: '0');
  DateTime _purchaseDate = DateTime.now();

  // Selected items
  final List<_PurchaseItemFormData> _items = [];

  @override
  void initState() {
    super.initState();
    // Load products for selection
    context.read<GetProductBloc>().add(ProductsLoadRequested());
  }

  @override
  void dispose() {
    _supplierController.dispose();
    _notesController.dispose();
    _additionalCostsController.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  double get _totalCost {
    double total = 0;
    for (final item in _items) {
      total += item.totalPrice;
    }
    return total;
  }

  double get _finalTotal {
    return _totalCost + (double.tryParse(_additionalCostsController.text) ?? 0);
  }

  /// Handle purchase created - separate async method to properly manage context
  Future<void> _handlePurchaseCreated(
    BuildContext listenerContext,
    AppLocalizations l10n,
  ) async {
    // Store references BEFORE any async operations
    final scaffoldMessenger = ScaffoldMessenger.of(listenerContext);
    final navigator = Navigator.of(listenerContext);

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(l10n.purchaseCreated),
        backgroundColor: Colors.green,
      ),
    );

    // Use Repository instead of DAO (Clean Architecture)
    final productRepository = getIt<ProductStockRepository>();
    final List<ProductEntity> freshProducts = [];

    for (final item in _items) {
      if (item.productUuid.isNotEmpty) {
        final result = await productRepository.getProductByUuid(
          item.productUuid,
        );
        result.fold((error) => null, (product) => freshProducts.add(product));
      }
    }

    // Check mounted after async operation
    if (!mounted) return;

    if (freshProducts.isNotEmpty) {
      // Now context is safe to use since we verified mounted
      await PricingSuggestionDialog.show(
        context,
        products: freshProducts,
        marginPercent: 20.0,
      );
    }

    // Check mounted again after second async operation
    if (!mounted) return;
    navigator.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return BlocListener<PurchaseBloc, PurchaseState>(
      listener: (listenerContext, state) {
        if (state is PurchaseCreated) {
          _handlePurchaseCreated(listenerContext, l10n);
        } else if (state is PurchaseError) {
          ScaffoldMessenger.of(listenerContext).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.newPurchase), centerTitle: true),
        body: Form(
          key: _formKey,
          child: isDesktop
              ? _buildDesktopLayout(l10n)
              : _buildMobileLayout(l10n),
        ),
        bottomNavigationBar: _buildBottomBar(l10n),
      ),
    );
  }

  Widget _buildDesktopLayout(AppLocalizations l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Invoice details
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInvoiceDetailsCard(l10n),
                const SizedBox(height: 24),
                _buildItemsSection(l10n),
              ],
            ),
          ),
        ),
        // Right side - Summary
        Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: _buildSummaryCard(l10n),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInvoiceDetailsCard(l10n),
          const SizedBox(height: 16),
          _buildItemsSection(l10n),
          const SizedBox(height: 16),
          _buildSummaryCard(l10n),
          const SizedBox(height: 80), // Space for bottom bar
        ],
      ),
    );
  }

  Widget _buildInvoiceDetailsCard(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.invoiceDetails,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _supplierController,
              decoration: InputDecoration(
                labelText: l10n.supplierName,
                prefixIcon: const Icon(Icons.business),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _selectDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: l10n.purchaseDate,
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(DateFormat('yyyy/MM/dd').format(_purchaseDate)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _additionalCostsController,
              decoration: InputDecoration(
                labelText: l10n.additionalCosts,
                prefixIcon: const Icon(Icons.local_shipping),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: l10n.notes,
                prefixIcon: const Icon(Icons.notes),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsSection(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  l10n.items,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () => _showQuickAddProductDialog(l10n),
                  icon: const Icon(Icons.add_box, size: 18),
                  label: Text(l10n.addNewProduct),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(l10n.addItem),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_items.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                child: Text(
                  l10n.noItemsAdded,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _items.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, index) =>
                    _buildItemRow(_items[index], index, l10n),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(
    _PurchaseItemFormData item,
    int index,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<GetProductBloc, GetProductState>(
      builder: (context, state) {
        List<ProductEntity> products = [];
        if (state is ProductLoaded) {
          products = state.products;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              // Product dropdown
              Expanded(
                flex: 3,
                child: DropdownButtonFormField<String>(
                  initialValue: item.productUuid.isEmpty
                      ? null
                      : item.productUuid,
                  decoration: InputDecoration(
                    labelText: l10n.product,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  items: products
                      .map(
                        (p) => DropdownMenuItem(
                          value: p.uuid,
                          child: Text(p.name, overflow: TextOverflow.ellipsis),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      final product = products.firstWhere(
                        (p) => p.uuid == value,
                      );
                      setState(() {
                        item.productUuid = value;
                        item.productName = product.name;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              // Quantity
              Expanded(
                child: TextFormField(
                  controller: item.quantityController,
                  decoration: InputDecoration(
                    labelText: l10n.quantity,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 8),
              // Unit price
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: item.priceController,
                  decoration: InputDecoration(
                    labelText: l10n.unitPrice,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 8),
              // Total (readonly)
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    NumberFormat('#,##0').format(item.totalPrice),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Delete button
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _removeItem(index),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.summary,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildSummaryRow(l10n.itemsTotal, _totalCost),
        const SizedBox(height: 8),
        _buildSummaryRow(
          l10n.additionalCosts,
          double.tryParse(_additionalCostsController.text) ?? 0,
        ),
        const Divider(height: 24),
        _buildSummaryRow(l10n.finalTotal, _finalTotal, isTotal: true),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          NumberFormat('#,##0').format(value),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTotal ? 18 : 14,
            color: isTotal ? Theme.of(context).primaryColor : null,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: _items.isEmpty ? null : _submitPurchase,
                child: Text(l10n.savePurchase),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _purchaseDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _purchaseDate = picked;
      });
    }
  }

  void _addItem() {
    setState(() {
      _items.add(_PurchaseItemFormData());
    });
  }

  Future<void> _showQuickAddProductDialog(AppLocalizations l10n) async {
    final product = await QuickAddProductDialog.show(context);
    if (product != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${l10n.productName}: ${product.name} ✓'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
  }

  void _submitPurchase() {
    if (!_formKey.currentState!.validate()) return;

    // Validate items
    for (final item in _items) {
      if (item.productUuid.isEmpty ||
          item.quantity == 0 ||
          item.unitPrice == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).pleaseCompleteAllItems),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
    }

    final now = DateTime.now();
    final purchaseUuid = _uuid.v4();

    final purchaseItems = _items
        .map(
          (item) => PurchaseItemEntity(
            itemUuid: _uuid.v4(),
            purchaseUuid: purchaseUuid,
            productUuid: item.productUuid,
            productName: item.productName,
            quantity: item.quantity,
            unitBuyPrice: item.unitPrice,
            totalPrice: item.totalPrice,
          ),
        )
        .toList();

    final purchase = PurchaseEntity(
      purchaseUuid: purchaseUuid,
      supplierName: _supplierController.text.isEmpty
          ? null
          : _supplierController.text,
      purchaseDate: _purchaseDate,
      additionalCosts: double.tryParse(_additionalCostsController.text) ?? 0,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      createdAt: now,
      updatedAt: now,
      items: purchaseItems,
    );

    context.read<PurchaseBloc>().add(CreatePurchaseEvent(purchase));
  }
}

/// Helper class to hold form data for each purchase item
class _PurchaseItemFormData {
  String productUuid = '';
  String productName = '';
  final TextEditingController quantityController = TextEditingController(
    text: '1',
  );
  final TextEditingController priceController = TextEditingController(
    text: '0',
  );

  int get quantity => int.tryParse(quantityController.text) ?? 0;
  double get unitPrice => double.tryParse(priceController.text) ?? 0;
  double get totalPrice => quantity * unitPrice;

  void dispose() {
    quantityController.dispose();
    priceController.dispose();
  }
}
