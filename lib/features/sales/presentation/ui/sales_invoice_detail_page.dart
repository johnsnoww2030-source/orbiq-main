import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';

/// Sales Invoice Detail Page - shows full details of a sale
class SalesInvoiceDetailPage extends StatelessWidget {
  final SalesEntity sale;

  const SalesInvoiceDetailPage({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final dateFormat = DateFormat('yyyy/MM/dd - HH:mm');
    final priceFormat = NumberFormat('#,##0');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${l10n.invoiceDetails} #${sale.invoiceUuid.substring(0, 8)}',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: isDesktop
            ? _buildDesktopLayout(context, l10n, dateFormat, priceFormat)
            : _buildMobileLayout(context, l10n, dateFormat, priceFormat),
      ),
      bottomNavigationBar: _buildBottomBar(context, l10n, priceFormat),
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    AppLocalizations l10n,
    DateFormat dateFormat,
    NumberFormat priceFormat,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left - Invoice info
        Expanded(flex: 1, child: _buildInfoCard(context, l10n, dateFormat)),
        const SizedBox(width: 16),
        // Right - Items
        Expanded(flex: 2, child: _buildItemsCard(context, l10n, priceFormat)),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    AppLocalizations l10n,
    DateFormat dateFormat,
    NumberFormat priceFormat,
  ) {
    return Column(
      children: [
        _buildInfoCard(context, l10n, dateFormat),
        const SizedBox(height: 16),
        _buildItemsCard(context, l10n, priceFormat),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    AppLocalizations l10n,
    DateFormat dateFormat,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.invoiceInfo,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildInfoRow(
              Icons.person,
              l10n.customerName,
              sale.customerInfo ?? l10n.unknownCustomer,
            ),
            _buildInfoRow(
              Icons.calendar_today,
              l10n.date,
              dateFormat.format(sale.invoiceDate),
            ),
            _buildInfoRow(
              Icons.label,
              l10n.status,
              _getStatusText(sale.status, l10n),
              valueColor: _getStatusColor(sale.status),
            ),
            _buildInfoRow(
              Icons.source,
              l10n.source,
              sale.salesSource == 'LOCAL' ? l10n.local : l10n.online,
            ),
            if (sale.notes != null && sale.notes!.isNotEmpty)
              _buildInfoRow(Icons.notes, l10n.notes, sale.notes!),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsCard(
    BuildContext context,
    AppLocalizations l10n,
    NumberFormat priceFormat,
  ) {
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${sale.items.length} ${l10n.items}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            // Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Text(l10n.product, style: _headerStyle),
                  ),
                  Expanded(
                    child: Text(
                      l10n.quantity,
                      style: _headerStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      l10n.unitPrice,
                      style: _headerStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      l10n.total,
                      style: _headerStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      l10n.profit,
                      style: _headerStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
            // Items
            ...sale.items.asMap().entries.map((entry) {
              final item = entry.value;
              final profitColor = item.profit >= 0 ? Colors.green : Colors.red;

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName ?? l10n.unknownProduct,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${l10n.costAtSale}: ${priceFormat.format(item.costAtSale)}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${item.quantity}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        priceFormat.format(item.unitSellPrice),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        priceFormat.format(item.totalPrice),
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        priceFormat.format(item.profit),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: profitColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  TextStyle get _headerStyle => TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.grey[700],
  );

  Widget _buildBottomBar(
    BuildContext context,
    AppLocalizations l10n,
    NumberFormat priceFormat,
  ) {
    final totalCost = sale.items.fold<double>(
      0.0,
      (sum, item) => sum + (item.costAtSale * item.quantity),
    );
    final profitColor = sale.totalProfit >= 0 ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Summary row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryItem(
                  l10n.totalCost,
                  priceFormat.format(totalCost),
                  Colors.grey[700]!,
                ),
                _buildSummaryItem(
                  l10n.totalSales,
                  priceFormat.format(sale.totalAmount),
                  Colors.blue,
                ),
                _buildSummaryItem(
                  l10n.totalProfit,
                  priceFormat.format(sale.totalProfit),
                  profitColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }

  String _getStatusText(String status, AppLocalizations l10n) {
    switch (status) {
      case 'COMPLETED':
        return l10n.completed;
      case 'PENDING':
        return l10n.pending;
      case 'CANCELLED':
        return l10n.cancelled;
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'COMPLETED':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
