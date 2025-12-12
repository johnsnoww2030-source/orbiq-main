import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_bloc.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_event.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_state.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_bloc.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_event.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_state.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';

/// Add Sale Page - form to create a new sales invoice
class AddSalePage extends StatefulWidget {
  const AddSalePage({super.key});

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  // Form controllers
  final _customerController = TextEditingController();
  final _notesController = TextEditingController();

  // Selected items
  final List<_SaleItemFormData> _items = [];

  @override
  void initState() {
    super.initState();
    // Load products for selection
    context.read<GetProductBloc>().add(LoadProducts());
  }

  @override
  void dispose() {
    _customerController.dispose();
    _notesController.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  double get _totalAmount {
    double total = 0;
    for (final item in _items) {
      total += item.totalPrice;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return BlocListener<SalesBloc, SalesState>(
      listener: (context, state) {
        if (state is SaleCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.saleCreated),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        } else if (state is SalesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.newSale), centerTitle: true),
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
                _buildCustomerCard(l10n),
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
          _buildCustomerCard(l10n),
          const SizedBox(height: 16),
          _buildItemsSection(l10n),
          const SizedBox(height: 16),
          _buildSummaryCard(l10n),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.customerInfo,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _customerController,
              decoration: InputDecoration(
                labelText: l10n.customerName,
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
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
    _SaleItemFormData item,
    int index,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<GetProductBloc, GetProductState>(
      builder: (context, state) {
        List<ProductEntity> products = [];
        if (state is ProductLoaded) {
          // Filter products with stock > 0
          products = state.products.where((p) => p.currentStock > 0).toList();
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
                          child: Text(
                            '${p.name} (${p.currentStock})',
                            overflow: TextOverflow.ellipsis,
                          ),
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
                        item.priceController.text = product.originalPrice
                            .toStringAsFixed(0);
                        item.maxStock = product.currentStock;
                        item.costAtSale = product.avgBuyPrice;
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
        _buildSummaryRow(l10n.itemsTotal, _totalAmount),
        const Divider(height: 24),
        _buildSummaryRow(l10n.finalTotal, _totalAmount, isTotal: true),
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
                onPressed: _items.isEmpty ? null : _submitSale,
                child: Text(l10n.saveSale),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addItem() {
    setState(() {
      _items.add(_SaleItemFormData());
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
  }

  void _submitSale() {
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
      // Check stock
      if (item.quantity > item.maxStock) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${item.productName}: ${AppLocalizations.of(context).insufficientStock}',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    final now = DateTime.now();
    final invoiceUuid = _uuid.v4();

    // Get current user UUID
    final authState = context.read<AuthBloc>().state;
    String userUuid = 'system';
    if (authState is AuthSuccess) {
      userUuid = authState.user.uuid ?? 'system';
    }

    final saleItems = _items
        .map(
          (item) => SalesItemEntity(
            itemUuid: _uuid.v4(),
            invoiceUuid: invoiceUuid,
            productUuid: item.productUuid,
            productName: item.productName,
            quantity: item.quantity,
            unitSellPrice: item.unitPrice,
            costAtSale: item.costAtSale,
            totalPrice: item.totalPrice,
            profit: item.profit,
          ),
        )
        .toList();

    final sale = SalesEntity(
      invoiceUuid: invoiceUuid,
      customerInfo: _customerController.text.isEmpty
          ? null
          : _customerController.text,
      invoiceDate: now,
      totalAmount: _totalAmount,
      userUuid: userUuid,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      createdAt: now,
      updatedAt: now,
      items: saleItems,
    );

    context.read<SalesBloc>().add(CreateSaleEvent(sale));
  }
}

/// Helper class to hold form data for each sale item
class _SaleItemFormData {
  String productUuid = '';
  String productName = '';
  int maxStock = 0;
  double costAtSale = 0.0;
  final TextEditingController quantityController = TextEditingController(
    text: '1',
  );
  final TextEditingController priceController = TextEditingController(
    text: '0',
  );

  int get quantity => int.tryParse(quantityController.text) ?? 0;
  double get unitPrice => double.tryParse(priceController.text) ?? 0;
  double get totalPrice => quantity * unitPrice;
  double get profit => (unitPrice - costAtSale) * quantity;

  void dispose() {
    quantityController.dispose();
    priceController.dispose();
  }
}
