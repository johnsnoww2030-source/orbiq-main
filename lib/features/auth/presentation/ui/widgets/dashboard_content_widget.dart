import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/auth/domain/repositories/dashboard_repository.dart';
// Phase 2
import 'package:orbiq/features/exchange_rate/presentation/bloc/exchange_rate_bloc.dart';
import 'package:orbiq/features/exchange_rate/presentation/bloc/exchange_rate_event.dart';
import 'package:orbiq/features/exchange_rate/presentation/bloc/exchange_rate_state.dart';
import 'package:orbiq/core/adaptor/routes_constants.dart';

/// Dashboard with inventory overview, low stock alerts, and today's sales summary
class DashboardContentWidget extends StatefulWidget {
  const DashboardContentWidget({super.key});

  @override
  State<DashboardContentWidget> createState() => _DashboardContentWidgetState();
}

class _DashboardContentWidgetState extends State<DashboardContentWidget> {
  bool _isLoading = true;

  // Dashboard data
  int _productCount = 0;
  int _lowStockCount = 0;
  int _outOfStockCount = 0;
  double _inventoryValue = 0;

  List<ProductEntity> _lowStockProducts = [];

  // Today's sales
  double _todaySales = 0;
  double _todayProfit = 0;
  int _todayInvoiceCount = 0;

  late DashboardRepository _dashboardRepository;

  @override
  void initState() {
    super.initState();
    _dashboardRepository = getIt<DashboardRepository>();
    _loadDashboardData();
    // Phase 2: Load exchange rates
    context.read<ExchangeRateBloc>().add(
      const LoadCurrentRatesEvent(['USD', 'EUR', 'AED']),
    );
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);

    try {
      // Product summary using Repository (Clean Architecture)
      final productCountResult = await _dashboardRepository.getProductCount();
      productCountResult.fold((e) => null, (v) => _productCount = v);

      final lowStockCountResult = await _dashboardRepository.getLowStockCount();
      lowStockCountResult.fold((e) => null, (v) => _lowStockCount = v);

      final outOfStockResult = await _dashboardRepository.getOutOfStockCount();
      outOfStockResult.fold((e) => null, (v) => _outOfStockCount = v);

      final inventoryResult = await _dashboardRepository
          .getTotalInventoryValue();
      inventoryResult.fold((e) => null, (v) => _inventoryValue = v);

      // Low stock products
      final lowStockProductsResult = await _dashboardRepository
          .getLowStockProductsList();
      lowStockProductsResult.fold((e) => null, (v) => _lowStockProducts = v);

      // Today's sales
      final todayRevenueResult = await _dashboardRepository.getTodayRevenue();
      todayRevenueResult.fold((e) => null, (v) => _todaySales = v);

      final todayProfitResult = await _dashboardRepository.getTodayProfit();
      todayProfitResult.fold((e) => null, (v) => _todayProfit = v);

      final todayInvoiceResult = await _dashboardRepository
          .getTodayInvoiceCount();
      todayInvoiceResult.fold((e) => null, (v) => _todayInvoiceCount = v);
    } catch (e) {
      debugPrint('Error loading dashboard: $e');
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: _loadDashboardData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(isDesktop ? 32 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome
                  Text(
                    l10n.welcomeManager,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Summary cards
                  _buildSummaryCards(l10n, isDesktop),
                  const SizedBox(height: 24),

                  // Today's sales card
                  _buildTodaySalesCard(l10n),
                  const SizedBox(height: 24),

                  // Phase 2: Exchange Rate Card
                  _buildExchangeRateCard(l10n),
                  const SizedBox(height: 24),

                  // Low stock alerts
                  if (_lowStockProducts.isNotEmpty) ...[
                    _buildLowStockAlerts(l10n),
                  ],
                ],
              ),
            ),
          );
  }

  Widget _buildSummaryCards(AppLocalizations l10n, bool isDesktop) {
    final priceFormat = NumberFormat('#,##0');

    final cards = [
      _SummaryCardData(
        icon: Icons.inventory_2,
        label: l10n.products,
        value: '$_productCount',
        color: Colors.blue,
      ),
      _SummaryCardData(
        icon: Icons.warning_amber,
        label: l10n.lowStock,
        value: '$_lowStockCount',
        color: Colors.orange,
      ),
      _SummaryCardData(
        icon: Icons.error_outline,
        label: l10n.outOfStock,
        value: '$_outOfStockCount',
        color: Colors.red,
      ),
      _SummaryCardData(
        icon: Icons.account_balance_wallet,
        label: l10n.inventoryValue,
        value: priceFormat.format(_inventoryValue),
        color: Colors.green,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: cards
            .map((c) => Expanded(child: _buildSummaryCard(c)))
            .toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) => _buildSummaryCard(cards[index]),
    );
  }

  Widget _buildSummaryCard(_SummaryCardData data) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: data.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(data.icon, color: data.color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              data.value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: data.color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.label,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaySalesCard(AppLocalizations l10n) {
    final priceFormat = NumberFormat('#,##0');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.today, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  l10n.todaySales,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: _buildSalesStat(
                    l10n.totalSales,
                    priceFormat.format(_todaySales),
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildSalesStat(
                    l10n.totalProfit,
                    priceFormat.format(_todayProfit),
                    Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildSalesStat(
                    l10n.invoices,
                    '$_todayInvoiceCount',
                    Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildLowStockAlerts(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  l10n.lowStockAlert,
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
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_lowStockProducts.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            ...List.generate(
              _lowStockProducts.length.clamp(0, 5), // Show max 5
              (index) {
                final product = _lowStockProducts[index];
                final isOutOfStock = product.currentStock == 0;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: isOutOfStock
                        ? Colors.red.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                    child: Icon(
                      isOutOfStock ? Icons.error : Icons.warning_amber,
                      color: isOutOfStock ? Colors.red : Colors.orange,
                      size: 20,
                    ),
                  ),
                  title: Text(product.name),
                  subtitle: Text(
                    '${l10n.stock}: ${product.currentStock} / ${l10n.reorderPoint}: ${product.reorderPoint}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isOutOfStock ? Colors.red : Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isOutOfStock ? l10n.outOfStock : l10n.lowStock,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                );
              },
            ),
            if (_lowStockProducts.length > 5) ...[
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to inventory
                  },
                  child: Text('${l10n.viewAll} (${_lowStockProducts.length})'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Phase 2: Exchange Rate Card
  Widget _buildExchangeRateCard(AppLocalizations l10n) {
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      builder: (context, state) {
        final priceFormat = NumberFormat('#,##0');

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.currency_exchange,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.exchangeRates,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Routes.exchangeRateManagement,
                      ),
                      child: const Text('مدیریت'),
                    ),
                  ],
                ),
                const Divider(),
                if (state is ExchangeRateLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state is ExchangeRatesLoaded)
                  Row(
                    children: [
                      if (state.currentRates['USD'] != null)
                        Expanded(
                          child: _buildRateStat(
                            'دلار (USD)',
                            priceFormat.format(state.currentRates['USD']!.rate),
                            Colors.green,
                          ),
                        ),
                      if (state.currentRates['EUR'] != null)
                        Expanded(
                          child: _buildRateStat(
                            'یورو (EUR)',
                            priceFormat.format(state.currentRates['EUR']!.rate),
                            Colors.blue,
                          ),
                        ),
                      if (state.currentRates['AED'] != null)
                        Expanded(
                          child: _buildRateStat(
                            'درهم (AED)',
                            priceFormat.format(state.currentRates['AED']!.rate),
                            Colors.orange,
                          ),
                        ),
                    ],
                  )
                else
                  Center(
                    child: Text(
                      'نرخی ثبت نشده است',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRateStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
      ],
    );
  }
}

class _SummaryCardData {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  _SummaryCardData({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
}
