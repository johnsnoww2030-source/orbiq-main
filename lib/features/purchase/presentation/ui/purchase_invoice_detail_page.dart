import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/purchase/domain/entities/purchase_entity.dart';

/// Purchase Invoice Detail Page - shows full details of a purchase
class PurchaseInvoiceDetailPage extends StatelessWidget {
  final PurchaseEntity purchase;

  const PurchaseInvoiceDetailPage({super.key, required this.purchase});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final dateFormat = DateFormat('yyyy/MM/dd - HH:mm');
    final priceFormat = NumberFormat('#,##0');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${l10n.invoiceDetails} #${purchase.purchaseUuid.substring(0, 8)}',
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
        Expanded(
          flex: 1,
          child: _buildInfoCard(context, l10n, dateFormat, priceFormat),
        ),
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
        _buildInfoCard(context, l10n, dateFormat, priceFormat),
        const SizedBox(height: 16),
        _buildItemsCard(context, l10n, priceFormat),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    AppLocalizations l10n,
    DateFormat dateFormat,
    NumberFormat priceFormat,
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
              Icons.business,
              l10n.supplier,
              purchase.supplierName ?? l10n.unknownSupplier,
            ),
            _buildInfoRow(
              Icons.calendar_today,
              l10n.date,
              dateFormat.format(purchase.purchaseDate),
            ),
            _buildInfoRow(
              Icons.local_shipping,
              l10n.additionalCosts,
              priceFormat.format(purchase.additionalCosts),
            ),
            if (purchase.notes != null && purchase.notes!.isNotEmpty)
              _buildInfoRow(Icons.notes, l10n.notes, purchase.notes!),
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
                    '${purchase.items.length} ${l10n.items}',
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
                  const SizedBox(width: 12),
                ],
              ),
            ),
            // Items
            ...purchase.items.asMap().entries.map((entry) {
              final item = entry.value;

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
                      child: Text(
                        item.productName ?? l10n.unknownProduct,
                        style: const TextStyle(fontWeight: FontWeight.w500),
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
                        priceFormat.format(item.unitBuyPrice),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryItem(
                  l10n.purchases,
                  priceFormat.format(purchase.totalCost),
                  Colors.grey[700]!,
                ),
                _buildSummaryItem(
                  l10n.additionalCosts,
                  priceFormat.format(purchase.additionalCosts),
                  Colors.orange,
                ),
                _buildSummaryItem(
                  l10n.total,
                  priceFormat.format(purchase.finalTotal),
                  Colors.blue,
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
}
