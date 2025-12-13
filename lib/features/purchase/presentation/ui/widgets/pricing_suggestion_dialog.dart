import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/core/shared/product/domain/repositories/product_stock_repository.dart';

/// Dialog to suggest pricing for products after a purchase is recorded
/// Shows WAC, suggested price with margin, and current price comparison
class PricingSuggestionDialog extends StatefulWidget {
  final List<ProductEntity> products;
  final double defaultMarginPercent;

  const PricingSuggestionDialog({
    super.key,
    required this.products,
    this.defaultMarginPercent = 20.0,
  });

  /// Show the dialog and return updated products (if any)
  static Future<List<ProductEntity>?> show(
    BuildContext context, {
    required List<ProductEntity> products,
    double marginPercent = 20.0,
  }) {
    return showDialog<List<ProductEntity>>(
      context: context,
      builder: (context) => PricingSuggestionDialog(
        products: products,
        defaultMarginPercent: marginPercent,
      ),
    );
  }

  @override
  State<PricingSuggestionDialog> createState() =>
      _PricingSuggestionDialogState();
}

class _PricingSuggestionDialogState extends State<PricingSuggestionDialog> {
  late ProductStockRepository _productRepository;
  late List<_ProductPricing> _pricingList;
  bool _isApplying = false;

  @override
  void initState() {
    super.initState();
    _productRepository = getIt<ProductStockRepository>();
    _initializePricing();
  }

  void _initializePricing() {
    _pricingList = widget.products.map((product) {
      final suggestedPrice = _calculateSuggestedPrice(
        product.avgBuyPrice,
        widget.defaultMarginPercent,
      );

      // Calculate current margin only if originalPrice is set (> 0)
      // If originalPrice is 0, the product was quickly created without a selling price
      double? currentMargin;
      if (product.originalPrice > 0 && product.avgBuyPrice > 0) {
        final currentProfit = product.originalPrice - product.avgBuyPrice;
        currentMargin = (currentProfit / product.avgBuyPrice) * 100;
      }

      return _ProductPricing(
        product: product,
        suggestedPrice: suggestedPrice,
        customPrice: suggestedPrice,
        currentMargin: currentMargin,
        isSelected: product.originalPrice < suggestedPrice,
      );
    }).toList();
  }

  double _calculateSuggestedPrice(double avgBuyPrice, double marginPercent) {
    return avgBuyPrice * (1 + marginPercent / 100);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final priceFormat = NumberFormat('#,##0');
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 16,
        vertical: 24,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isDesktop ? 700 : double.infinity,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(l10n),
            const Divider(height: 1),
            // Product list
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _pricingList.length,
                itemBuilder: (context, index) =>
                    _buildProductTile(_pricingList[index], l10n, priceFormat),
              ),
            ),
            const Divider(height: 1),
            // Actions
            _buildActions(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lightbulb, color: Colors.amber, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.pricingSuggestion,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.pricingSuggestionHint,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTile(
    _ProductPricing pricing,
    AppLocalizations l10n,
    NumberFormat format,
  ) {
    final product = pricing.product;
    final isPriceBelow = product.originalPrice < pricing.suggestedPrice;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: pricing.isSelected
              ? Theme.of(context).primaryColor
              : Colors.grey[300]!,
          width: pricing.isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: pricing.isSelected
            ? Theme.of(context).primaryColor.withValues(alpha: 0.05)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Product name + checkbox
          Row(
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Checkbox(
                value: pricing.isSelected,
                onChanged: (val) {
                  setState(() {
                    pricing.isSelected = val ?? false;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Row 2: Prices grid
          Row(
            children: [
              Expanded(
                child: _buildPriceColumn(
                  l10n.costPrice,
                  format.format(product.avgBuyPrice),
                  Colors.grey[700]!,
                ),
              ),
              Expanded(
                child: _buildPriceColumn(
                  l10n.suggestedPrice,
                  format.format(pricing.suggestedPrice),
                  Colors.green,
                ),
              ),
              Expanded(
                child: _buildPriceColumn(
                  l10n.currentPrice,
                  format.format(product.originalPrice),
                  isPriceBelow ? Colors.orange : Colors.blue,
                  warning: isPriceBelow,
                ),
              ),
            ],
          ),
          // Row 3: Margin indicator
          if (isPriceBelow) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_amber,
                    color: Colors.orange,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    pricing.currentMargin != null
                        ? '${l10n.currentMargin}: ${pricing.currentMargin!.toStringAsFixed(1)}%'
                        : l10n.priceNotSet,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceColumn(
    String label,
    String value,
    Color color, {
    bool warning = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            if (warning) ...[
              const SizedBox(width: 4),
              const Icon(Icons.warning_amber, color: Colors.orange, size: 14),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildActions(AppLocalizations l10n) {
    final selectedCount = _pricingList.where((p) => p.isSelected).length;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.later),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: selectedCount > 0 && !_isApplying
                ? _applySelectedPrices
                : null,
            icon: _isApplying
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.check),
            label: Text(
              selectedCount > 0
                  ? '${l10n.applyPricing} ($selectedCount)'
                  : l10n.applyPricing,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _applySelectedPrices() async {
    setState(() => _isApplying = true);

    try {
      final updatedProducts = <ProductEntity>[];

      for (final pricing in _pricingList) {
        if (pricing.isSelected) {
          // Update product price using Repository (Clean Architecture)
          final result = await _productRepository.updateOriginalPrice(
            pricing.product.uuid!,
            pricing.suggestedPrice,
          );

          result.fold(
            (error) => debugPrint('Error updating price: $error'),
            (_) => updatedProducts.add(
              pricing.product.copyWith(originalPrice: pricing.suggestedPrice),
            ),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context, updatedProducts);
      }
    } catch (e) {
      debugPrint('Error applying prices: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isApplying = false);
      }
    }
  }
}

/// Internal class to track pricing state for each product
class _ProductPricing {
  final ProductEntity product;
  final double suggestedPrice;
  double customPrice;
  final double? currentMargin;
  bool isSelected;

  _ProductPricing({
    required this.product,
    required this.suggestedPrice,
    required this.customPrice,
    required this.currentMargin,
    required this.isSelected,
  });
}
