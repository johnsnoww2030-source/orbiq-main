import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/add_product/presentation/ui/add_product_page.dart';
import 'package:orbiq/features/add_product/presentation/ui/edit_product_page.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_bloc.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_event.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_state.dart';
// TODO: Replace with Sales Module (PRD)
// Removed: CartBloc, CartEvent, CartState, PaymentPage
import 'package:orbiq/features/barcode_reader/presentation/controller/chat_bloc.dart';
import 'package:orbiq/features/barcode_reader/presentation/controller/chat_state.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_bloc.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_state.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';

class ProductsManagementPage extends StatefulWidget {
  const ProductsManagementPage({super.key});

  @override
  State<ProductsManagementPage> createState() => _ProductsManagementPageState();
}

class _ProductsManagementPageState extends State<ProductsManagementPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final NumberFormat currencyFormat = NumberFormat('#,##0');
  String _selectedFilter = 'all';
  late AnimationController _animationController;

  bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

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

  @override
  void initState() {
    super.initState();
    context.read<GetProductBloc>().add(LoadProducts());

    context.read<ChatBloc>().stream.listen((state) {
      if (state is ChatConnected && state.messages.isNotEmpty) {
        final message = state.messages.last;
        if (message.text.isNotEmpty) {
          _searchController.text = message.text;
          _onSearchSubmitted(_searchController.text);
        }
      }
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String value) {
    if (value.isNotEmpty) {
      context.read<GetProductBloc>().add(SearchProductBySerial(value));
      _searchController.clear();
      _searchFocusNode.requestFocus();
    } else {
      context.read<GetProductBloc>().add(LoadProducts());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isMobile = _isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    const itemWidth = 200.0;
    final crossAxisCount = (screenWidth / itemWidth).floor().clamp(1, 6);

    return Scaffold(
      body: Column(
        children: [
          // Header section
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: isMobile ? 12.0 : 12.0,
            ),
            child: isMobile
                ? Column(
                    children: [
                      _buildCompactMobileHeader(context, l10n),
                      const SizedBox(height: 10),
                      _buildCompactMobileStats(context, l10n),
                      const SizedBox(height: 10),
                      _buildCompactMobileSearch(context, l10n),
                    ],
                  )
                : Column(
                    children: [
                      _buildCompactDesktopHeader(context, l10n),
                      const SizedBox(height: 12),
                      _buildCompactSearchRow(context, l10n),
                    ],
                  ),
          ),
          Expanded(
            child: _buildProductsContent(
              context,
              l10n,
              crossAxisCount,
              isMobile,
            ),
          ),
        ],
      ),
      floatingActionButton: isMobile ? _buildMobileFAB(context) : null,
    );
  }

  Widget _buildMobileFAB(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'add',
      onPressed: () {
        final bloc = context.read<GetProductBloc>();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddProductPage()),
        ).then((result) {
          if (result == true && mounted) {
            bloc.add(LoadProducts());
          }
        });
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _buildCompactMobileHeader(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.inventory_2_outlined,
            color: Theme.of(context).primaryColor,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          l10n.productManagement,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, '/barcode-reader'),
          icon: const Icon(Icons.qr_code_scanner, size: 20),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(
              context,
            ).primaryColor.withValues(alpha: 0.1),
            foregroundColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(8),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactMobileStats(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<GetProductBloc, GetProductState>(
      builder: (context, state) {
        int totalProducts = 0,
            availableProducts = 0,
            lowStockProducts = 0,
            outOfStockProducts = 0;

        if (state is ProductLoaded) {
          totalProducts = state.products.length;
          for (var product in state.products) {
            if (product.currentStock <= 0) {
              outOfStockProducts++;
            } else if (product.currentStock <=
                (product.reorderPoint > 0 ? product.reorderPoint : 5)) {
              lowStockProducts++;
            } else {
              availableProducts++;
            }
          }
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildStatBadge(
                context,
                totalProducts,
                l10n.totalProducts,
                Colors.blue,
                Icons.inventory_2,
              ),
              const SizedBox(width: 6),
              _buildStatBadge(
                context,
                availableProducts,
                l10n.available,
                Colors.green,
                Icons.check_circle,
              ),
              const SizedBox(width: 6),
              _buildStatBadge(
                context,
                lowStockProducts,
                l10n.lowStock,
                Colors.orange,
                Icons.warning_amber,
              ),
              const SizedBox(width: 6),
              _buildStatBadge(
                context,
                outOfStockProducts,
                l10n.outOfStock,
                Colors.red,
                Icons.error_outline,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompactMobileSearch(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: l10n.searchBySerial,
              hintStyle: const TextStyle(fontSize: 14),
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _searchController.clear();
                  context.read<GetProductBloc>().add(LoadProducts());
                },
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
            ),
            onSubmitted: _onSearchSubmitted,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCompactFilterChip(context, l10n, 'all', l10n.allProducts),
              const SizedBox(width: 6),
              _buildCompactFilterChip(
                context,
                l10n,
                'available',
                l10n.available,
              ),
              const SizedBox(width: 6),
              _buildCompactFilterChip(context, l10n, 'low', l10n.lowStock),
              const SizedBox(width: 6),
              _buildCompactFilterChip(context, l10n, 'out', l10n.outOfStock),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactDesktopHeader(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<GetProductBloc, GetProductState>(
      builder: (context, state) {
        int totalProducts = 0,
            availableProducts = 0,
            lowStockProducts = 0,
            outOfStockProducts = 0;

        if (state is ProductLoaded) {
          totalProducts = state.products.length;
          for (var product in state.products) {
            if (product.currentStock <= 0) {
              outOfStockProducts++;
            } else if (product.currentStock <=
                (product.reorderPoint > 0 ? product.reorderPoint : 5)) {
              lowStockProducts++;
            } else {
              availableProducts++;
            }
          }
        }

        return Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.productManagement,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 24),
            _buildStatBadge(
              context,
              totalProducts,
              l10n.totalProducts,
              Colors.blue,
              Icons.inventory_2,
            ),
            const SizedBox(width: 8),
            _buildStatBadge(
              context,
              availableProducts,
              l10n.available,
              Colors.green,
              Icons.check_circle,
            ),
            const SizedBox(width: 8),
            _buildStatBadge(
              context,
              lowStockProducts,
              l10n.lowStock,
              Colors.orange,
              Icons.warning_amber,
            ),
            const SizedBox(width: 8),
            _buildStatBadge(
              context,
              outOfStockProducts,
              l10n.outOfStock,
              Colors.red,
              Icons.error_outline,
            ),
            const Spacer(),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/barcode-reader'),
              icon: const Icon(Icons.qr_code_scanner),
              tooltip: l10n.barcodeReader,
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withValues(alpha: 0.1),
                foregroundColor: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: () {
                final bloc = context.read<GetProductBloc>();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductPage(),
                  ),
                ).then((result) {
                  if (result == true && mounted) {
                    bloc.add(LoadProducts());
                  }
                });
              },
              icon: const Icon(Icons.add, size: 18),
              label: Text(l10n.newProduct),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatBadge(
    BuildContext context,
    int value,
    String tooltip,
    Color color,
    IconData icon,
  ) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(width: 4),
            Text(
              '$value',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactSearchRow(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: l10n.searchBySerial,
                hintStyle: const TextStyle(fontSize: 14),
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () {
                    _searchController.clear();
                    context.read<GetProductBloc>().add(LoadProducts());
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
              onSubmitted: _onSearchSubmitted,
            ),
          ),
        ),
        const SizedBox(width: 12),
        _buildCompactFilterChip(context, l10n, 'all', l10n.allProducts),
        const SizedBox(width: 6),
        _buildCompactFilterChip(context, l10n, 'available', l10n.available),
        const SizedBox(width: 6),
        _buildCompactFilterChip(context, l10n, 'low', l10n.lowStock),
        const SizedBox(width: 6),
        _buildCompactFilterChip(context, l10n, 'out', l10n.outOfStock),
      ],
    );
  }

  Widget _buildCompactFilterChip(
    BuildContext context,
    AppLocalizations l10n,
    String filter,
    String label,
  ) {
    final isSelected = _selectedFilter == filter;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : null),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = filter;
        });
      },
      selectedColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      visualDensity: VisualDensity.compact,
      showCheckmark: false,
    );
  }

  Widget _buildProductsContent(
    BuildContext context,
    AppLocalizations l10n,
    int crossAxisCount,
    bool isMobile,
  ) {
    return BlocBuilder<GetProductBloc, GetProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          final products = _filterProducts(state.products);
          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noProductsFound,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }
          return _buildProductGrid(
            context,
            l10n,
            products,
            crossAxisCount,
            isMobile,
          );
        } else if (state is ProductFound) {
          return _buildProductGrid(
            context,
            l10n,
            [state.product],
            crossAxisCount,
            isMobile,
          );
        } else if (state is ProductNotFound) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off, size: 64, color: Colors.orange),
                const SizedBox(height: 16),
                Text(
                  l10n.noProductsFound,
                  style: const TextStyle(fontSize: 18, color: Colors.orange),
                ),
              ],
            ),
          );
        } else if (state is ProductError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  '${l10n.error}: ${state.message}',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  List<ProductEntity> _filterProducts(List<ProductEntity> products) {
    switch (_selectedFilter) {
      case 'available':
        return products
            .where(
              (p) => p.currentStock > (p.reorderPoint > 0 ? p.reorderPoint : 5),
            )
            .toList();
      case 'low':
        return products
            .where(
              (p) =>
                  p.currentStock > 0 &&
                  p.currentStock <= (p.reorderPoint > 0 ? p.reorderPoint : 5),
            )
            .toList();
      case 'out':
        return products.where((p) => p.currentStock <= 0).toList();
      default:
        return products;
    }
  }

  Widget _buildProductGrid(
    BuildContext context,
    AppLocalizations l10n,
    List<ProductEntity> products,
    int crossAxisCount,
    bool isMobile,
  ) {
    final authState = context.read<AuthBloc>().state;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: isMobile ? 0.75 : 0.85,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductCard(context, l10n, product, authState);
        },
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    AppLocalizations l10n,
    ProductEntity product,
    AuthState authState,
  ) {
    final stockColor = product.currentStock <= 0
        ? Colors.red
        : product.currentStock <=
              (product.reorderPoint > 0 ? product.reorderPoint : 5)
        ? Colors.orange
        : Colors.green;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // TODO: Show product details
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: stockColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${product.currentStock}',
                      style: TextStyle(
                        color: stockColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.serialNumber,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const Spacer(),
              Text(
                _formatPrice(context, product.originalPrice),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (authState is AuthSuccess && authState.user.role == 'admin')
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.edit, size: 18),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProductPage(product: product),
                        ),
                      ).then((result) {
                        if (result == true && mounted) {
                          context.read<GetProductBloc>().add(LoadProducts());
                        }
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
