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
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    context.read<GetProductBloc>().add(LoadProducts());

    // Listen to barcode reader
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
    final screenWidth = MediaQuery.of(context).size.width;
    const itemWidth = 200.0;
    final crossAxisCount = (screenWidth / itemWidth).floor().clamp(1, 6);

    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, l10n),
                const SizedBox(height: 24),
                _buildStatsCards(context),
                const SizedBox(height: 24),
                _buildSearchAndFilters(context, l10n),
              ],
            ),
          ),

          // Products List with BlocListener for cart functionality
          Expanded(
            child: BlocListener<GetProductBloc, GetProductState>(
              listener: (context, state) {
                // Auto-add to cart when product found and cart is active
                if (state is ProductFound && _isCartActive) {
                  context.read<CartBloc>().add(
                    AddToCartEvent(state.product.toEntity()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.product.name} به سبد اضافه شد'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: _buildProductsContent(context, l10n, crossAxisCount),
            ),
          ),

          // Cart Section (when active)
          if (_isCartActive) _buildCartSection(context, crossAxisCount),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
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
                  'مدیریت محصولات',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'مدیریت انبار و موجودی محصولات',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            // Barcode Reader Button
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/barcode-reader'),
              icon: const Icon(Icons.qr_code_scanner),
              tooltip: 'بارکدخوان',
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withValues(alpha: 0.1),
                foregroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(width: 8),
            // Cart Button with animation
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => IconButton(
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
                icon: Icon(
                  _isCartActive
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                  size: 24 + (_animation.value * 4),
                ),
                tooltip: 'سبد خرید',
                style: IconButton.styleFrom(
                  backgroundColor: _isCartActive
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  foregroundColor: _isCartActive
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Add Product Button
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductPage(),
                  ),
                ).then((result) {
                  if (result == true)
                    context.read<GetProductBloc>().add(LoadProducts());
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('محصول جدید'),
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

  Widget _buildStatsCards(BuildContext context) {
    return BlocBuilder<GetProductBloc, GetProductState>(
      builder: (context, state) {
        int totalProducts = 0;
        int availableProducts = 0;
        int lowStockProducts = 0;
        int outOfStockProducts = 0;

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
            Expanded(
              child: _buildStatCard(
                context,
                Icons.inventory_2,
                Colors.blue,
                totalProducts.toString(),
                'کل محصولات',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                Icons.check_circle,
                Colors.green,
                availableProducts.toString(),
                'موجود',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                Icons.warning_amber,
                Colors.orange,
                lowStockProducts.toString(),
                'موجودی کم',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                Icons.error_outline,
                Colors.red,
                outOfStockProducts.toString(),
                'تمام شده',
              ),
            ),
          ],
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
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context, AppLocalizations l10n) {
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
                  hintText: 'جستجو با شماره سریال...',
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: _onSearchSubmitted,
              ),
            ),
            const SizedBox(width: 16),
            _buildFilterChip(context, 'all', 'همه'),
            const SizedBox(width: 8),
            _buildFilterChip(context, 'available', 'موجود'),
            const SizedBox(width: 8),
            _buildFilterChip(context, 'low', 'موجودی کم'),
            const SizedBox(width: 8),
            _buildFilterChip(context, 'out', 'تمام شده'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String value, String label) {
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
  ) {
    return BlocBuilder<GetProductBloc, GetProductState>(
      builder: (context, state) {
        if (state is ProductLoading || state is ProductLoadingPage) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          final products = _filterProducts(state.products);
          if (products.isEmpty) return _buildEmptyState(context);
          return _buildProductsGrid(context, products, crossAxisCount, state);
        } else if (state is ProductFound) {
          // Show single found product
          return _buildProductsGrid(
            context,
            [state.product],
            crossAxisCount,
            null,
          );
        } else if (state is ProductNotFound) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'محصولی با این شماره سریال یافت نشد',
                  style: TextStyle(fontSize: 18, color: Colors.red[400]),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () =>
                      context.read<GetProductBloc>().add(LoadProducts()),
                  child: const Text('بازگشت به لیست'),
                ),
              ],
            ),
          );
        } else if (state is ProductError) {
          return Center(
            child: Text(
              'خطا: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return _buildEmptyState(context);
      },
    );
  }

  Widget _buildProductsGrid(
    BuildContext context,
    List<ProductModel> products,
    int crossAxisCount,
    ProductLoaded? state,
  ) {
    final authState = context.read<AuthBloc>().state;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  _buildProductCard(context, products[index], authState),
            ),
          ),
          if (state != null && state.totalPages > 1)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: state.currentPage > 1
                        ? () => context.read<GetProductBloc>().add(
                            LoadProductPageEvent(state.currentPage - 1),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Text('صفحه ${state.currentPage} از ${state.totalPages}'),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: state.hasNextPage
                        ? () => context.read<GetProductBloc>().add(
                            LoadProductPageEvent(state.currentPage + 1),
                          )
                        : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ProductModel product,
    AuthState authState,
  ) {
    final stockStatus = _getStockStatus(product);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: _isCartActive
            ? () {
                context.read<CartBloc>().add(
                  AddToCartEvent(product.toEntity()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} به سبد اضافه شد'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusBadge(stockStatus),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'شماره سریال: ${product.serialNumber}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'مدل: ${product.model}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'رنگ: ${product.color}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'موجودی: ${product.currentStock}',
                style: const TextStyle(fontSize: 12),
              ),
              const Spacer(),
              Text(
                '${currencyFormat.format(product.originalPrice.toInt())} تومان',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              if (authState is AuthSuccess && authState.user.role == 'admin')
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProductPage(product: product),
                        ),
                      ).then((result) {
                        if (result == true)
                          context.read<GetProductBloc>().add(LoadProducts());
                      });
                    },
                    tooltip: 'ویرایش',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartSection(BuildContext context, int crossAxisCount) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        List<ProductEntity> cartItems = [];
        double totalPrice = 0.0;
        if (cartState is CartUpdated) {
          cartItems = cartState.cartItems;
          totalPrice = cartItems.fold(
            0.0,
            (sum, item) => sum + item.originalPrice,
          );
        }

        return Container(
          height: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Cart Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'سبد خرید (${cartItems.length} کالا)',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      '${currencyFormat.format(totalPrice.toInt())} تومان',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    FilledButton(
                      onPressed: cartItems.isEmpty
                          ? null
                          : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentPage(),
                              ),
                            ),
                      child: const Text('پرداخت'),
                    ),
                  ],
                ),
              ),
              // Cart Items
              Expanded(
                child: cartItems.isEmpty
                    ? Center(
                        child: Text(
                          'سبد خرید خالی است',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) =>
                            _buildCartItem(context, cartItems[index]),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartItem(BuildContext context, ProductEntity product) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 180,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: Colors.red),
                    onPressed: () => context.read<CartBloc>().add(
                      RemoveFromCartEvent(product),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                product.serialNumber,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
              const Spacer(),
              Text(
                '${currencyFormat.format(product.originalPrice.toInt())} تومان',
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
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
        (product.reorderPoint > 0 ? product.reorderPoint : 5))
      return 'low';
    return 'available';
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case 'available':
        bgColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
        label = 'موجود';
        break;
      case 'low':
        bgColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange;
        label = 'کم';
        break;
      case 'out':
        bgColor = Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red;
        label = 'تمام';
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'هیچ محصولی یافت نشد',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'برای افزودن محصول جدید دکمه "محصول جدید" را بزنید',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
