import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_bloc.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_state.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_bloc.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_event.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_state.dart';
import 'package:orbiq/features/sales/presentation/ui/add_sale_page.dart';
import 'package:orbiq/features/sales/presentation/ui/sales_invoice_detail_page.dart';
import 'package:orbiq/features/exports/presentation/ui/export_widget.dart';

/// Sales list page showing all sales invoices
class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  void initState() {
    super.initState();
    context.read<SalesBloc>().add(const LoadSalesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: Column(
        children: [
          // Header
          _buildHeader(l10n, isDesktop),
          // Sales list
          Expanded(
            child: BlocConsumer<SalesBloc, SalesState>(
              listener: (context, state) {
                if (state is SalesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is SalesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SalesError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<SalesBloc>().add(
                            const LoadSalesEvent(),
                          ),
                          child: Text(l10n.retry),
                        ),
                      ],
                    ),
                  );
                }

                if (state is SalesLoaded) {
                  if (state.sales.isEmpty) {
                    return _buildEmptyState(l10n);
                  }
                  return _buildSalesList(state.sales, l10n);
                }

                return _buildEmptyState(l10n);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToAddSale(),
        icon: const Icon(Icons.add),
        label: Text(l10n.newSale),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            Icons.point_of_sale,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.salesInvoices,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Summary cards for desktop
          if (isDesktop)
            BlocBuilder<SalesBloc, SalesState>(
              builder: (context, state) {
                if (state is SalesLoaded) {
                  return Row(
                    children: [
                      _buildSummaryChip(
                        l10n.totalSales,
                        _formatCurrency(state.totalRevenue),
                        Colors.green,
                      ),
                      const SizedBox(width: 12),
                      _buildSummaryChip(
                        l10n.totalProfit,
                        _formatCurrency(state.totalProfit),
                        Colors.blue,
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          // Export button
          BlocBuilder<SalesBloc, SalesState>(
            builder: (context, state) {
              if (state is SalesLoaded && state.sales.isNotEmpty) {
                return ExportWidget(
                  data: _buildSalesExportData(state.sales, l10n),
                  fileNamePrefix: 'sales_invoices',
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 12)),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            l10n.noSales,
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _navigateToAddSale(),
            icon: const Icon(Icons.add),
            label: Text(l10n.newSale),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesList(List<SalesEntity> sales, AppLocalizations l10n) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: sales.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final sale = sales[index];
        return _buildSaleCard(sale, l10n);
      },
    );
  }

  Widget _buildSaleCard(SalesEntity sale, AppLocalizations l10n) {
    final dateFormat = DateFormat('yyyy/MM/dd - HH:mm');
    final profit = sale.totalProfit;
    final profitColor = profit >= 0 ? Colors.green : Colors.red;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(
            context,
          ).primaryColor.withValues(alpha: 0.1),
          child: Icon(Icons.receipt, color: Theme.of(context).primaryColor),
        ),
        title: Text(
          sale.customerInfo ?? l10n.unknownCustomer,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dateFormat.format(sale.invoiceDate)),
            Text('${sale.items.length} ${l10n.items}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatCurrency(sale.totalAmount),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              '${l10n.profit}: ${_formatCurrency(profit)}',
              style: TextStyle(color: profitColor, fontSize: 12),
            ),
          ],
        ),
        onTap: () => _navigateToSaleDetail(sale),
      ),
    );
  }

  String _formatCurrency(double amount) {
    final currencyState = context.watch<CurrencyBloc>().state;
    if (currencyState is CurrencyLoaded) {
      final rate = currencyState.rates[currencyState.selectedCurrency] ?? 1.0;
      final converted = amount / rate;
      final isInt =
          currencyState.selectedCurrency == CurrencyCode.toman ||
          currencyState.selectedCurrency == CurrencyCode.rial ||
          currencyState.selectedCurrency == CurrencyCode.dinar;
      final formatter = NumberFormat(isInt ? '#,##0' : '#,##0.##');
      return '${formatter.format(converted)} ${currencyState.selectedCurrency.symbol}';
    }
    return '${NumberFormat('#,##0').format(amount)} ${AppLocalizations.of(context).currency}';
  }

  void _navigateToAddSale() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddSalePage()),
    );
    if (result == true && mounted) {
      context.read<SalesBloc>().add(const LoadSalesEvent());
    }
  }

  void _navigateToSaleDetail(SalesEntity sale) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SalesInvoiceDetailPage(sale: sale),
      ),
    );
  }

  /// Build export data for sales invoices
  List<List<dynamic>> _buildSalesExportData(
    List<SalesEntity> sales,
    AppLocalizations l10n,
  ) {
    final data = <List<dynamic>>[];
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm');
    final priceFormat = NumberFormat('#,##0');

    // Header row
    data.add([l10n.customers, l10n.date, l10n.items, l10n.total, l10n.profit]);

    // Data rows
    for (final sale in sales) {
      data.add([
        sale.customerInfo ?? l10n.unknownCustomer,
        dateFormat.format(sale.invoiceDate),
        '${sale.items.length}',
        priceFormat.format(sale.totalAmount),
        priceFormat.format(sale.totalProfit),
      ]);
    }

    return data;
  }
}
