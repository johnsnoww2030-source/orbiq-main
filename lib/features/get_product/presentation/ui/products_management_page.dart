import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:orbiq/core/shared/product/data/models/product_model.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/add_product/presentation/ui/add_product_page.dart';
import 'package:orbiq/features/add_product/presentation/ui/edit_product_page.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_bloc.dart';
import 'package:orbiq/features/payment/presentation/controller/cart_bloc.dart';
import 'package:orbiq/features/payment/presentation/controller/cart_event.dart';
import 'package:orbiq/features/payment/presentation/controller/cart_state.dart';
import 'package:orbiq/features/payment/presentation/ui/payment_page.dart';
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
  bool _isCartActive = false;
  bool _isCartPanelOpen = false; // Separate state for panel visibility
  late AnimationController _animationController;
  late Animation<double> _animation;
  final PageController _statsPageController = PageController(
    viewportFraction: 0.85,
  );

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
          state.selectedCurrency ==
              CurrencyCode.dinar; // Dinar usually no decimal?
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
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    _statsPageController.dispose();
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
    final isRtl = Directionality.of(context).name == 'rtl';

    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              // Compact header section for both mobile and desktop
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: isMobile ? 12.0 : 12.0,
                ),
                child: isMobile
                    ? Column(
                        children: [
                          // Mobile: Compact header
                          _buildCompactMobileHeader(context, l10n),
                          const SizedBox(height: 10),
                          // Mobile: Inline stats (horizontal scroll)
                          _buildCompactMobileStats(context, l10n),
                          const SizedBox(height: 10),
                          // Mobile: Compact search
                          _buildCompactMobileSearch(context, l10n),
                        ],
                      )
                    : Column(
                        children: [
                          // Desktop: Compact header with inline stats
                          _buildCompactDesktopHeader(context, l10n),
                          const SizedBox(height: 12),
                          // Desktop: Compact search row
                          _buildCompactSearchRow(context, l10n),
                        ],
                      ),
              ),
              Expanded(
                child: BlocListener<GetProductBloc, GetProductState>(
                  listener: (context, state) {
                    if (state is ProductFound && _isCartActive) {
                      context.read<CartBloc>().add(
                        AddToCartEvent(state.product.toEntity()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${state.product.name} ${l10n.addedToCart}',
                          ),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child: _buildProductsContent(
                    context,
                    l10n,
                    crossAxisCount,
                    isMobile,
                  ),
                ),
              ),
              // Mobile: Bottom cart bar when cart mode is active
              if (isMobile && _isCartActive) _buildMobileCartBar(context, l10n),
            ],
          ),
          // Desktop: Side Panel Overlay (only when cart panel is open, not just active)
          if (!isMobile && _isCartPanelOpen) ...[
            // Backdrop
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isCartPanelOpen = false;
                  });
                },
                child: Container(color: Colors.black.withValues(alpha: 0.4)),
              ),
            ),
            // Side Panel
            Positioned(
              top: 0,
              bottom: 0,
              left: isRtl ? 0 : null,
              right: isRtl ? null : 0,
              child: _buildCartSidePanel(context, l10n, isMobile),
            ),
          ],
        ],
      ),
      floatingActionButton: isMobile ? _buildMobileFAB(context) : null,
    );
  }

  Widget _buildMobileFAB(BuildContext context) {
    return Padding(
      // Add bottom padding when cart bar is shown
      padding: EdgeInsets.only(bottom: _isCartActive ? 80 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'cart',
            onPressed: () {
              setState(() {
                _isCartActive = !_isCartActive;
                if (_isCartActive) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              });
            },
            backgroundColor: _isCartActive
                ? Theme.of(context).primaryColor
                : null,
            child: Icon(
              _isCartActive
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined,
            ),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
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
          ),
        ],
      ),
    );
  }

  /// Compact mobile header with title and action buttons
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

  /// Compact mobile stats - horizontal scrollable badges
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

  /// Compact mobile search with filters below
  Widget _buildCompactMobileSearch(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        // Compact search field
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
        // Filter chips - horizontal scroll
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

  /// Compact desktop header with inline stats badges
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
            // Title with icon
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
            // Inline stat badges
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
            // Action buttons
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
            const SizedBox(width: 8),
            // Cart button with badge
            BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                int cartItemCount = 0;
                if (cartState is CartUpdated) {
                  cartItemCount = cartState.items.length;
                }
                return Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_isCartActive) {
                            _isCartPanelOpen = !_isCartPanelOpen;
                          } else {
                            _isCartActive = true;
                            _isCartPanelOpen = true;
                            _animationController.forward();
                          }
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          _isCartActive = false;
                          _isCartPanelOpen = false;
                          _animationController.reverse();
                        });
                      },
                      icon: Icon(
                        _isCartActive
                            ? Icons.shopping_cart
                            : Icons.shopping_cart_outlined,
                      ),
                      tooltip: l10n.cart,
                      style: IconButton.styleFrom(
                        backgroundColor: _isCartActive
                            ? Theme.of(context).primaryColor
                            : Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.1),
                        foregroundColor: _isCartActive
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    if (cartItemCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '$cartItemCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
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

  /// Compact search row for desktop
  Widget _buildCompactSearchRow(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        // Search field (flexible width)
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
        // Filter chips
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

  Widget _buildMobileCartBar(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        List<ProductEntity> cartItems = [];
        double totalPrice = 0.0;
        if (cartState is CartUpdated) {
          cartItems = cartState.items;
          totalPrice = cartItems.fold(
            0.0,
            (sum, item) => sum + item.originalPrice,
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            top: false,
            child: Row(
              children: [
                // Cart icon with badge
                Stack(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                    if (cartItems.isNotEmpty)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '${cartItems.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                // Total price
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.total,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      Text(
                        _formatPrice(context, totalPrice),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // View Cart button
                TextButton.icon(
                  onPressed: () => _showMobileCartBottomSheet(context, l10n),
                  icon: const Icon(Icons.visibility, size: 18),
                  label: Text(l10n.cart),
                ),
                const SizedBox(width: 8),
                // Pay button
                FilledButton(
                  onPressed: cartItems.isEmpty
                      ? null
                      : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentPage(),
                          ),
                        ),
                  child: Text(l10n.pay),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMobileCartBottomSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) =>
            BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                List<ProductEntity> cartItems = [];
                double totalPrice = 0.0;
                if (cartState is CartUpdated) {
                  cartItems = cartState.items;
                  totalPrice = cartItems.fold(
                    0.0,
                    (sum, item) => sum + item.originalPrice,
                  );
                }

                return Column(
                  children: [
                    // Handle
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Header
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.cart,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${cartItems.length} ${l10n.items}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Items
                    Expanded(
                      child: cartItems.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 48,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    l10n.cartEmpty,
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              controller: scrollController,
                              padding: const EdgeInsets.all(16),
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                final product = cartItems[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).primaryColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.inventory_2_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    title: Text(
                                      product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      product.serialNumber,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          _formatPrice(
                                            context,
                                            product.originalPrice,
                                          ),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton(
                                          onPressed: () =>
                                              context.read<CartBloc>().add(
                                                RemoveFromCartEvent(product),
                                              ),
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    // Footer
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.total,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  _formatPrice(context, totalPrice),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: cartItems.isEmpty
                                    ? null
                                    : () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PaymentPage(),
                                          ),
                                        );
                                      },
                                icon: const Icon(Icons.payment),
                                label: Text(l10n.pay),
                              ),
                            ),
                            if (cartItems.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => context.read<CartBloc>().add(
                                  ClearCartEvent(),
                                ),
                                child: Text(
                                  l10n.clearCart,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AppLocalizations l10n,
    bool isMobile,
  ) {
    if (isMobile) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              const SizedBox(width: 10),
              Text(
                l10n.productManagement,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/barcode-reader'),
            icon: const Icon(Icons.qr_code_scanner),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(
                context,
              ).primaryColor.withValues(alpha: 0.1),
              foregroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    Icons.inventory_2_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.productManagement,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.inventoryManagement,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/barcode-reader'),
              icon: const Icon(Icons.qr_code_scanner),
              tooltip: l10n.barcodeReader,
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withValues(alpha: 0.1),
                foregroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(width: 8),
            // Desktop Cart Button with Badge
            BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                int cartItemCount = 0;
                if (cartState is CartUpdated) {
                  cartItemCount = cartState.items.length;
                }
                return AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) => Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (_isCartActive) {
                              // If cart mode is active, toggle panel only
                              _isCartPanelOpen = !_isCartPanelOpen;
                            } else {
                              // Activate cart mode and open panel
                              _isCartActive = true;
                              _isCartPanelOpen = true;
                              _animationController.forward();
                            }
                          });
                        },
                        onLongPress: () {
                          // Long press to deactivate cart mode
                          setState(() {
                            _isCartActive = false;
                            _isCartPanelOpen = false;
                            _animationController.reverse();
                          });
                        },
                        icon: Icon(
                          _isCartActive
                              ? Icons.shopping_cart
                              : Icons.shopping_cart_outlined,
                          size: 24 + (_animation.value * 4),
                        ),
                        tooltip: _isCartActive
                            ? '${l10n.cart} (${l10n.pay}: Long press)'
                            : l10n.cart,
                        style: IconButton.styleFrom(
                          backgroundColor: _isCartActive
                              ? Theme.of(context).primaryColor
                              : Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: 0.1),
                          foregroundColor: _isCartActive
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                      // Badge for item count
                      if (cartItemCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 18,
                              minHeight: 18,
                            ),
                            child: Text(
                              '$cartItemCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
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
              icon: const Icon(Icons.add),
              label: Text(l10n.newProduct),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCards(
    BuildContext context,
    AppLocalizations l10n,
    bool isMobile,
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

        final stats = [
          {
            'icon': Icons.inventory_2,
            'color': Colors.blue,
            'value': totalProducts.toString(),
            'label': l10n.totalProducts,
          },
          {
            'icon': Icons.check_circle,
            'color': Colors.green,
            'value': availableProducts.toString(),
            'label': l10n.available,
          },
          {
            'icon': Icons.warning_amber,
            'color': Colors.orange,
            'value': lowStockProducts.toString(),
            'label': l10n.lowStock,
          },
          {
            'icon': Icons.error_outline,
            'color': Colors.red,
            'value': outOfStockProducts.toString(),
            'label': l10n.outOfStock,
          },
        ];

        if (isMobile) {
          return SizedBox(
            height: 100,
            child: PageView.builder(
              controller: _statsPageController,
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final stat = stats[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildStatCard(
                    context,
                    stat['icon'] as IconData,
                    stat['color'] as Color,
                    stat['value'] as String,
                    stat['label'] as String,
                  ),
                );
              },
            ),
          );
        }

        return Row(
          children: stats
              .map(
                (stat) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildStatCard(
                      context,
                      stat['icon'] as IconData,
                      stat['color'] as Color,
                      stat['value'] as String,
                      stat['label'] as String,
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    IconData icon,
    Color color,
    String value,
    String label,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    label,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters(
    BuildContext context,
    AppLocalizations l10n,
    bool isMobile,
  ) {
    if (isMobile) {
      return Column(
        children: [
          TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            decoration: InputDecoration(
              hintText: l10n.searchBySerial,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  context.read<GetProductBloc>().add(LoadProducts());
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
            ),
            onSubmitted: _onSearchSubmitted,
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(context, l10n, 'all', l10n.allProducts),
                const SizedBox(width: 8),
                _buildFilterChip(context, l10n, 'available', l10n.available),
                const SizedBox(width: 8),
                _buildFilterChip(context, l10n, 'low', l10n.lowStock),
                const SizedBox(width: 8),
                _buildFilterChip(context, l10n, 'out', l10n.outOfStock),
              ],
            ),
          ),
        ],
      );
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: l10n.searchBySerial,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      context.read<GetProductBloc>().add(LoadProducts());
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                onSubmitted: _onSearchSubmitted,
              ),
            ),
            const SizedBox(width: 16),
            _buildFilterChip(context, l10n, 'all', l10n.allProducts),
            const SizedBox(width: 8),
            _buildFilterChip(context, l10n, 'available', l10n.available),
            const SizedBox(width: 8),
            _buildFilterChip(context, l10n, 'low', l10n.lowStock),
            const SizedBox(width: 8),
            _buildFilterChip(context, l10n, 'out', l10n.outOfStock),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    AppLocalizations l10n,
    String value,
    String label,
  ) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      onSelected: (selected) => setState(() => _selectedFilter = value),
      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      checkmarkColor: Theme.of(context).primaryColor,
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
        if (state is ProductLoading || state is ProductLoadingPage) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          final products = _filterProducts(state.products);
          if (products.isEmpty) return _buildEmptyState(context, l10n);
          return isMobile
              ? _buildMobileProductsList(context, l10n, products, state)
              : _buildDesktopProductsTable(context, l10n, products, state);
        } else if (state is ProductFound) {
          return isMobile
              ? _buildMobileProductsList(context, l10n, [state.product], null)
              : _buildDesktopProductsTable(context, l10n, [
                  state.product,
                ], null);
        } else if (state is ProductNotFound) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  l10n.productNotFoundBySerial,
                  style: TextStyle(fontSize: 18, color: Colors.red[400]),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () =>
                      context.read<GetProductBloc>().add(LoadProducts()),
                  child: Text(l10n.backToList),
                ),
              ],
            ),
          );
        } else if (state is ProductError) {
          return Center(
            child: Text(
              '${l10n.error}: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return _buildEmptyState(context, l10n);
      },
    );
  }

  Widget _buildMobileProductsList(
    BuildContext context,
    AppLocalizations l10n,
    List<ProductModel> products,
    ProductLoaded? state,
  ) {
    final authState = context.read<AuthBloc>().state;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) => _buildMobileProductCard(
              context,
              l10n,
              products[index],
              authState,
            ),
          ),
        ),
        if (state != null) _buildMobilePagination(context, l10n, state),
      ],
    );
  }

  Widget _buildMobileProductCard(
    BuildContext context,
    AppLocalizations l10n,
    ProductModel product,
    AuthState authState,
  ) {
    final stockStatus = _getStockStatus(product);
    final isAdmin = authState is AuthSuccess && authState.user.role == 'admin';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _isCartActive
            ? () {
                context.read<CartBloc>().add(
                  AddToCartEvent(product.toEntity()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} ${l10n.addedToCart}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + Status Badge row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildCompactStatusBadge(l10n, stockStatus),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Product code
                    Text(
                      product.serialNumber,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Details row
                    Row(
                      children: [
                        if (product.model.isNotEmpty) ...[
                          _buildInfoChip(
                            Icons.category_outlined,
                            product.model,
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (product.color.isNotEmpty)
                          _buildInfoChip(Icons.palette_outlined, product.color),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Price + Stock row
                    Row(
                      children: [
                        // Price
                        Text(
                          _formatPrice(context, product.originalPrice),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Stock
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 12,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${product.currentStock}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Right side: Action buttons
              if (isAdmin)
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        final bloc = context.read<GetProductBloc>();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProductPage(product: product),
                          ),
                        ).then((result) {
                          if (result == true && mounted) {
                            bloc.add(LoadProducts());
                          }
                        });
                      },
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.1),
                        foregroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.all(8),
                        minimumSize: const Size(36, 36),
                      ),
                      tooltip: l10n.edit,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Colors.grey[500]),
        const SizedBox(width: 3),
        Text(text, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
      ],
    );
  }

  Widget _buildCompactStatusBadge(AppLocalizations l10n, String status) {
    Color color;
    String text;
    switch (status) {
      case 'available':
        color = Colors.green;
        text = l10n.available;
        break;
      case 'low':
        color = Colors.orange;
        text = l10n.lowStock;
        break;
      case 'out':
        color = Colors.red;
        text = l10n.outOfStock;
        break;
      default:
        color = Colors.grey;
        text = status;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMobilePagination(
    BuildContext context,
    AppLocalizations l10n,
    ProductLoaded state,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: state.currentPage > 1
                ? () => context.read<GetProductBloc>().add(
                    LoadProductPageEvent(state.currentPage - 1),
                  )
                : null,
            icon: const Icon(Icons.chevron_right),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).cardColor,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${state.currentPage} / ${state.totalPages}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: state.hasNextPage
                ? () => context.read<GetProductBloc>().add(
                    LoadProductPageEvent(state.currentPage + 1),
                  )
                : null,
            icon: const Icon(Icons.chevron_left),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).cardColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopProductsTable(
    BuildContext context,
    AppLocalizations l10n,
    List<ProductModel> products,
    ProductLoaded? state,
  ) {
    final authState = context.read<AuthBloc>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.productList,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (state != null)
                    Text(
                      '${products.length} ${l10n.products}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
                  bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(l10n.productCode, style: _headerStyle(context)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(l10n.productName, style: _headerStyle(context)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(l10n.price, style: _headerStyle(context)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(l10n.stock, style: _headerStyle(context)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(l10n.status, style: _headerStyle(context)),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      l10n.actions,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: products.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
                itemBuilder: (context, index) =>
                    _buildProductRow(context, l10n, products[index], authState),
              ),
            ),
            if (state != null) _buildDesktopPagination(context, l10n, state),
          ],
        ),
      ),
    );
  }

  TextStyle _headerStyle(BuildContext context) => TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.grey[600],
    fontSize: 13,
  );

  Widget _buildProductRow(
    BuildContext context,
    AppLocalizations l10n,
    ProductModel product,
    AuthState authState,
  ) {
    final stockStatus = _getStockStatus(product);
    return InkWell(
      onTap: _isCartActive
          ? () {
              context.read<CartBloc>().add(AddToCartEvent(product.toEntity()));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} ${l10n.addedToCart}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                product.serialNumber,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${l10n.model}: ${product.model} | ${l10n.color}: ${product.color}',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                _formatPrice(context, product.originalPrice),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green[700],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                product.currentStock.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: stockStatus == 'out'
                      ? Colors.red
                      : stockStatus == 'low'
                      ? Colors.orange
                      : null,
                ),
              ),
            ),
            Expanded(flex: 1, child: _buildStatusBadge(l10n, stockStatus)),
            SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.visibility_outlined, size: 20),
                    onPressed: () {},
                    tooltip: l10n.view,
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                  ),
                  if (authState is AuthSuccess &&
                      authState.user.role == 'admin')
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      onPressed: () {
                        final bloc = context.read<GetProductBloc>();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProductPage(product: product),
                          ),
                        ).then((result) {
                          if (result == true && mounted) {
                            bloc.add(LoadProducts());
                          }
                        });
                      },
                      tooltip: l10n.edit,
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopPagination(
    BuildContext context,
    AppLocalizations l10n,
    ProductLoaded state,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${l10n.showing} ${((state.currentPage - 1) * 20) + 1} ${l10n.to} ${state.currentPage * 20}',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: state.currentPage > 1
                    ? () => context.read<GetProductBloc>().add(
                        LoadProductPageEvent(state.currentPage - 1),
                      )
                    : null,
                icon: const Icon(Icons.chevron_right, size: 18),
                label: Text(l10n.previous),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${state.currentPage} / ${state.totalPages}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: state.hasNextPage
                    ? () => context.read<GetProductBloc>().add(
                        LoadProductPageEvent(state.currentPage + 1),
                      )
                    : null,
                icon: const Icon(Icons.chevron_left, size: 18),
                label: Text(l10n.next),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartSidePanel(
    BuildContext context,
    AppLocalizations l10n,
    bool isMobile,
  ) {
    final panelWidth = isMobile ? 300.0 : 380.0;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        List<ProductEntity> cartItems = [];
        double totalPrice = 0.0;
        if (cartState is CartUpdated) {
          cartItems = cartState.items;
          totalPrice = cartItems.fold(
            0.0,
            (sum, item) => sum + item.originalPrice,
          );
        }

        return Material(
          elevation: 16,
          child: Container(
            width: panelWidth,
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.cart,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${cartItems.length} ${l10n.items}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isCartActive = false;
                            _animationController.reverse();
                          });
                        },
                        icon: const Icon(Icons.close, color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                // Cart Items List
                Expanded(
                  child: cartItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                l10n.cartEmpty,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(12),
                          itemCount: cartItems.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final product = cartItems[index];
                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
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
                                        Icons.inventory_2_outlined,
                                        color: Theme.of(context).primaryColor,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            product.serialNumber,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _formatPrice(
                                              context,
                                              product.originalPrice,
                                            ),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.green[700],
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => context
                                          .read<CartBloc>()
                                          .add(RemoveFromCartEvent(product)),
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      iconSize: 20,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                // Footer with Total and Pay Button
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.total,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            _formatPrice(context, totalPrice),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: cartItems.isEmpty
                              ? null
                              : () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PaymentPage(),
                                  ),
                                ),
                          icon: const Icon(Icons.payment),
                          label: Text(l10n.pay),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      if (cartItems.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () =>
                              context.read<CartBloc>().add(ClearCartEvent()),
                          child: Text(
                            l10n.clearCart,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<ProductModel> _filterProducts(List<ProductModel> products) {
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

  String _getStockStatus(ProductModel product) {
    if (product.currentStock <= 0) return 'out';
    if (product.currentStock <=
        (product.reorderPoint > 0 ? product.reorderPoint : 5)) {
      return 'low';
    }
    return 'available';
  }

  Widget _buildStatusBadge(AppLocalizations l10n, String status) {
    Color bgColor, textColor;
    String label;

    switch (status) {
      case 'available':
        bgColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
        label = l10n.available;
        break;
      case 'low':
        bgColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange;
        label = l10n.lowStock;
        break;
      case 'out':
        bgColor = Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red;
        label = l10n.outOfStock;
        break;
      default:
        bgColor = Colors.grey.withValues(alpha: 0.1);
        textColor = Colors.grey;
        label = '?';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    final isMobile = _isMobile(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: isMobile ? 60 : 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noProductsFound,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            isMobile ? l10n.pressAddButton : l10n.pressNewProductButton,
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
