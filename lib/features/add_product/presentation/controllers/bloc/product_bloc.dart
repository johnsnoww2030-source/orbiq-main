import 'package:orbiq/features/add_product/domain/usecases/add_product_usecase.dart';
import 'package:orbiq/features/add_product/domain/usecases/update_product_usecase.dart'; // اضافه شده
import 'package:orbiq/features/get_product/domain/usecases/get_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/features/get_product/presentation/controllers/bloc/get_product_bloc.dart'
    as get_products;

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProduct addProduct;
  final UpdateProductUseCase updateProduct;
  final GetProductsUseCase
      getProductsUseCase; // استفاده از یوزکیس دریافت محصولات

  ProductBloc({
    required this.addProduct,
    required this.updateProduct,
    required this.getProductsUseCase, // اینجا نیز اضافه شده
  }) : super(ProductInitial()) {
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<LoadProductsEvent>(
        _onLoadProducts); // اضافه کردن مدیریت رویداد LoadProductsEvent
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      await addProduct(event.product);
      emit(ProductAdded());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      // استفاده از یوزکیس جدید برای بروزرسانی
      await updateProduct(event.product);
      emit(ProductUpdatedSuccess(event.product)); // وضعیت موفقیت‌آمیز
    } catch (e) {
      emit(ProductError(e.toString())); // وضعیت شکست
    }
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await getProductsUseCase(
        GetProductsUseCaseParams(
          page: 1,
          limit: 10,
        ),
      );
      emit(get_products.ProductLoaded(
        products: products.products,
        currentPage: 1,
        totalPages: 1,
        hasNextPage: false,
      ) as ProductState); // ارسال لیست محصولات
    } catch (e) {
      emit(const ProductError('خطا در بارگذاری محصولات'));
    }
  }
}
