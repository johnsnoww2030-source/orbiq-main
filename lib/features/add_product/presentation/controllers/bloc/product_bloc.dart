import 'package:injectable/injectable.dart';
import 'package:orbiq/features/add_product/domain/usecases/add_product_usecase.dart';
import 'package:orbiq/features/add_product/domain/usecases/update_product_usecase.dart';
import 'package:orbiq/features/get_product/domain/usecases/get_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_event.dart';
import 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProduct addProduct;
  final UpdateProductUseCase updateProduct;
  final GetProductsUseCase getProductsUseCase;

  ProductBloc({
    required this.addProduct,
    required this.updateProduct,
    required this.getProductsUseCase,
  }) : super(const ProductInitial()) {
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    try {
      await addProduct(event.product);
      emit(const ProductAdded());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    try {
      await updateProduct(event.product);
      emit(ProductUpdatedSuccess(event.product));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
