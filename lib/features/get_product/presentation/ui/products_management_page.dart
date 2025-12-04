import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:orbiq/core/shared/product/data/models/product_model.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/add_product/presentation/ui/add_product_page.dart';
import 'package:orbiq/features/add_product/presentation/ui/edit_product_page.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_bloc.dart';

class ProductsManagementPage extends StatefulWidget {
  const ProductsManagementPage({super.key});

  @override
  State<ProductsManagementPage> createState() => _ProductsManagementPageState();
}

class _ProductsManagementPageState extends State<ProductsManagementPage> {
  final TextEditingController _searchController = TextEditingController();
  final NumberFormat currencyFormat = NumberFormat('#,##0');
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    context.read<GetProductBloc>().add(LoadProducts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, l10n),
            const SizedBox(height: 24),
            _buildStatsCards(context),
            const SizedBox(height: 24),
            _buildSearchAndFilters(context, l10n),
            const SizedBox(height: 24),
            Expanded(child: _buildProductsList(context, l10n)),
          ],
        ),
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
        FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProductPage()),
            ).then((result) {
              if (result == true) {
                context.read<GetProductBloc>().add(LoadProducts());
              }
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('محصول جدید'),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
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
                icon: Icons.inventory_2,
                iconColor: Colors.blue,
                iconBgColor: Colors.blue.withValues(alpha: 0.1),
                value: totalProducts.toString(),
                label: 'کل محصولات',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.check_circle,
                iconColor: Colors.green,
                iconBgColor: Colors.green.withValues(alpha: 0.1),
                value: availableProducts.toString(),
                label: 'موجود',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.warning_amber,
                iconColor: Colors.orange,
                iconBgColor: Colors.orange.withValues(alpha: 0.1),
                value: lowStockProducts.toString(),
                label: 'موجودی کم',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.error_outline,
                iconColor: Colors.red,
                iconBgColor: Colors.red.withValues(alpha: 0.1),
                value: outOfStockProducts.toString(),
                label: 'تمام شده',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String value,
    required String label,
  }) {
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
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
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
                decoration: InputDecoration(
                  hintText: 'جستجوی محصولات...',
                  prefixIcon: const Icon(Icons.search),
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
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    context.read<GetProductBloc>().add(
                      SearchProductBySerial(value),
                    );
                  } else {
                    context.read<GetProductBloc>().add(LoadProducts());
                  }
                },
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
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      checkmarkColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildProductsList(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<GetProductBloc, GetProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          final products = _filterProducts(state.products);

          if (products.isEmpty) {
            return _buildEmptyState(context);
          }

          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'لیست محصولات',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildTableHeader(context),
                const Divider(height: 1),
                Expanded(
                  child: ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return _buildProductRow(context, products[index]);
                    },
                  ),
                ),
                if (state.totalPages > 1)
                  _buildPagination(
                    context,
                    state.currentPage,
                    state.totalPages,
                    state.hasNextPage,
                  ),
              ],
            ),
          );
        } else if (state is ProductError) {
          return Center(child: Text('خطا: ${state.message}'));
        } else {
          return _buildEmptyState(context);
        }
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

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('کد', style: _headerStyle(context))),
          Expanded(
            flex: 2,
            child: Text('نام محصول', style: _headerStyle(context)),
          ),
          Expanded(flex: 1, child: Text('قیمت', style: _headerStyle(context))),
          Expanded(
            flex: 1,
            child: Text('موجودی', style: _headerStyle(context)),
          ),
          Expanded(flex: 1, child: Text('وضعیت', style: _headerStyle(context))),
          const SizedBox(width: 80, child: Text('عملیات')),
        ],
      ),
    );
  }

  TextStyle? _headerStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.grey[600],
    );
  }

  Widget _buildProductRow(BuildContext context, ProductModel product) {
    final authState = BlocProvider.of<AuthBloc>(context).state;
    final stockStatus = _getStockStatus(product);

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                product.serialNumber.length > 8
                    ? '${product.serialNumber.substring(0, 8)}...'
                    : product.serialNumber,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${currencyFormat.format(product.originalPrice.toInt())} تومان',
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(flex: 1, child: Text(product.currentStock.toString())),
            Expanded(flex: 1, child: _buildStatusBadge(stockStatus)),
            SizedBox(
              width: 80,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.visibility_outlined, size: 20),
                    onPressed: () {},
                    tooltip: 'مشاهده',
                  ),
                  if (authState is AuthSuccess &&
                      authState.user.role == 'admin')
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProductPage(product: product),
                          ),
                        ).then((result) {
                          if (result == true) {
                            context.read<GetProductBloc>().add(LoadProducts());
                          }
                        });
                      },
                      tooltip: 'ویرایش',
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
        label = 'موجودی کم';
        break;
      case 'out':
        bgColor = Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red;
        label = 'تمام شده';
        break;
      default:
        bgColor = Colors.grey.withValues(alpha: 0.1);
        textColor = Colors.grey;
        label = 'نامشخص';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
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

  Widget _buildPagination(
    BuildContext context,
    int currentPage,
    int totalPages,
    bool hasNextPage,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: currentPage > 1
                ? () => context.read<GetProductBloc>().add(
                    LoadProductPageEvent(currentPage - 1),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Text('صفحه $currentPage از $totalPages'),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: hasNextPage
                ? () => context.read<GetProductBloc>().add(
                    LoadProductPageEvent(currentPage + 1),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
