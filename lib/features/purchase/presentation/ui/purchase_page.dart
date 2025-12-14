import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_bloc.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_state.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';
import 'package:orbiq/features/purchase/presentation/controller/purchase_bloc.dart';
import 'package:orbiq/features/purchase/presentation/controller/purchase_event.dart';
import 'package:orbiq/features/purchase/presentation/controller/purchase_state.dart';
import 'package:orbiq/features/purchase/domain/entities/purchase_entity.dart';
import 'package:orbiq/features/purchase/presentation/ui/purchase_invoice_detail_page.dart';
import 'add_purchase_page.dart';
import 'package:orbiq/features/exports/presentation/ui/export_widget.dart';

/// Purchase list page - shows all purchase invoices
class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  @override
  void initState() {
    super.initState();
    context.read<PurchaseBloc>().add(const LoadPurchasesEvent());
  }

  String _formatPrice(BuildContext context, double price) {
    final state = context.watch<CurrencyBloc>().state;
    if (state is CurrencyLoaded) {
      final rate = state.rates[state.selectedCurrency] ?? 1.0;
      final converted = price / rate;
      final isInt =
          state.selectedCurrency == CurrencyCode.toman ||
          state.selectedCurrency == CurrencyCode.rial ||
          state.selectedCurrency == CurrencyCode.dinar;
      final formatter = NumberFormat(isInt ? '#,##0' : '#,##0.##');
      return '${formatter.format(converted)} ${state.selectedCurrency.symbol}';
    }
    return '${NumberFormat('#,##0').format(price)} تومان';
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd - HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                    Icons.shopping_basket_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.purchases,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (!isMobile)
                  FilledButton.icon(
                    onPressed: _navigateToAddPurchase,
                    icon: const Icon(Icons.add),
                    label: Text(l10n.newPurchase),
                  ),
                // Export button
                BlocBuilder<PurchaseBloc, PurchaseState>(
                  builder: (context, state) {
                    if (state is PurchasesLoaded &&
                        state.purchases.isNotEmpty) {
                      return ExportWidget(
                        data: _buildPurchaseExportData(state.purchases, l10n),
                        fileNamePrefix: 'purchase_invoices',
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: BlocBuilder<PurchaseBloc, PurchaseState>(
              builder: (context, state) {
                if (state is PurchaseLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PurchasesLoaded) {
                  if (state.purchases.isEmpty) {
                    return _buildEmptyState(l10n);
                  }
                  return _buildPurchaseList(state.purchases, l10n);
                } else if (state is PurchaseError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: () => context.read<PurchaseBloc>().add(
                            const LoadPurchasesEvent(),
                          ),
                          child: Text(l10n.retry),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: isMobile
          ? FloatingActionButton(
              onPressed: _navigateToAddPurchase,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noPurchases,
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _navigateToAddPurchase,
            icon: const Icon(Icons.add),
            label: Text(l10n.newPurchase),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseList(
    List<PurchaseEntity> purchases,
    AppLocalizations l10n,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: purchases.length,
      itemBuilder: (context, index) {
        final purchase = purchases[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(
                context,
              ).primaryColor.withValues(alpha: 0.1),
              child: Icon(
                Icons.receipt_long,
                color: Theme.of(context).primaryColor,
              ),
            ),
            title: Text(
              purchase.supplierName ?? l10n.unknownSupplier,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_formatDate(purchase.purchaseDate)),
                Text(
                  '${purchase.items.length} ${l10n.items}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatPrice(context, purchase.finalTotal),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            onTap: () => _navigateToPurchaseDetail(purchase),
          ),
        );
      },
    );
  }

  void _navigateToAddPurchase() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddPurchasePage()),
    ).then((result) {
      if (result == true && mounted) {
        context.read<PurchaseBloc>().add(const LoadPurchasesEvent());
      }
    });
  }

  void _navigateToPurchaseDetail(PurchaseEntity purchase) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PurchaseInvoiceDetailPage(purchase: purchase),
      ),
    );
  }

  /// Build export data for purchase invoices
  List<List<dynamic>> _buildPurchaseExportData(
    List<PurchaseEntity> purchases,
    AppLocalizations l10n,
  ) {
    final data = <List<dynamic>>[];
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm');
    final priceFormat = NumberFormat('#,##0');

    // Header row
    data.add([l10n.suppliers, l10n.date, l10n.items, l10n.total]);

    // Data rows
    for (final purchase in purchases) {
      data.add([
        purchase.supplierName ?? l10n.unknownSupplier,
        dateFormat.format(purchase.purchaseDate),
        '${purchase.items.length}',
        priceFormat.format(purchase.finalTotal),
      ]);
    }

    return data;
  }
}
