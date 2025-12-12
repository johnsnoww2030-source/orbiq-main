import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/presentation/ui/edit_product_page.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_bloc.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_event.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_state.dart';

// TODO: Replace with Sales Module (PRD)
// Removed: CartBloc, CartEvent, CartState, PaymentPage

import 'package:orbiq/core/shared/currency/presentation/controller/currency_bloc.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_state.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';

import '../../../barcode_reader/presentation/controller/chat_bloc.dart';
import '../../../barcode_reader/presentation/controller/chat_state.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  ProductListPageState createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<ProductEntity> _products = [];
  // TODO: Replace with Sales Module (PRD)
  // bool _isCartActive = false;
  late AnimationController _animationController;

  final NumberFormat currencyFormat = NumberFormat('#,##0');

  String _formatPrice(double price) {
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
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context).state;
    final double screenWidth = MediaQuery.of(context).size.width;
    const double itemWidth = 200.0;
    final int crossAxisCount = (screenWidth / itemWidth).floor();
    const double minScreenWidth = 400.0;

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: minScreenWidth),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'لیست محصولات',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          actions: [
            // TODO: Replace with Sales Module (PRD)
            // Cart button temporarily disabled
            IconButton(
              icon: const Icon(Icons.qr_code, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/barcode-reader');
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildSearchField(),
            Expanded(
              child: BlocListener<GetProductBloc, GetProductState>(
                listener: (context, state) {
                  if (state is ProductFound) {
                    // TODO: Replace with Sales Module (PRD)
                    // Cart functionality disabled
                  }
                },
                child: BlocBuilder<GetProductBloc, GetProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      );
                    } else if (state is ProductLoadingPage) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.amber),
                      );
                    } else if (state is ProductLoaded) {
                      _products = state.products;
                      return Column(
                        children: [
                          Expanded(
                            child: _buildProductGrid(
                              _products,
                              crossAxisCount,
                              authState,
                            ),
                          ),
                          _buildPaginationControls(
                            state.currentPage,
                            state.totalPages,
                            state.hasNextPage,
                          ),
                        ],
                      );
                    } else if (state is ProductFound) {
                      _products = [state.product];
                      return _buildProductGrid(
                        _products,
                        crossAxisCount,
                        authState,
                      );
                    } else if (state is ProductNotFound) {
                      return const Center(
                        child: Text(
                          'محصولی با این شماره سریال یافت نشد',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else if (state is ProductError) {
                      return Center(
                        child: Text(
                          'خطا: ${state.message}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'لطفاً محصولی را جستجو کنید',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            // TODO: Replace with Sales Module (PRD)
            // Cart section temporarily disabled
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          labelText: 'جستجو با شماره سریال',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
        style: const TextStyle(fontSize: 16),
        onSubmitted: _onSearchSubmitted,
      ),
    );
  }

  Widget _buildProductGrid(
    List<ProductEntity> products,
    int crossAxisCount,
    AuthState authState,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurple,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'شماره سریال: ${product.serialNumber}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'مدل: ${product.model}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'رنگ: ${product.color}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'جنس: ${product.material}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'سایز: ${product.description}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  Text(
                    'قیمت: ${_formatPrice(product.originalPrice)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  if (authState is AuthSuccess &&
                      authState.user.role == 'admin')
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 14),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProductPage(product: product),
                            ),
                          ).then((result) {
                            _handleProductEditResult(result);
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleProductEditResult(dynamic result) {
    if (result == true && mounted) {
      context.read<GetProductBloc>().add(LoadProducts());
    }
  }

  void _onSearchSubmitted(String value) {
    if (value.isNotEmpty) {
      context.read<GetProductBloc>().add(SearchProductBySerial(value));
      _searchController.clear();
      _searchFocusNode.requestFocus();
    }
  }

  Widget _buildPaginationControls(
    int currentPage,
    int totalPages,
    bool hasNextPage,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: currentPage > 1
                ? () {
                    context.read<GetProductBloc>().add(
                      LoadProductPageEvent(currentPage - 1),
                    );
                  }
                : null,
            child: const Text(' قبلی'),
          ),
          Text('صفحه $currentPage از $totalPages'),
          ElevatedButton(
            onPressed: hasNextPage
                ? () {
                    context.read<GetProductBloc>().add(
                      LoadProductPageEvent(currentPage + 1),
                    );
                  }
                : null,
            child: const Text('بعدی '),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
