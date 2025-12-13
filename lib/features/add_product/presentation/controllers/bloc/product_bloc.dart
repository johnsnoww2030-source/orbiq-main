import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/add_product/domain/usecases/add_product_usecase.dart';
import 'package:orbiq/features/add_product/domain/usecases/update_product_usecase.dart';

import 'product_event.dart';
import 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProduct addProduct;
  final UpdateProductUseCase updateProduct;

  ProductBloc({required this.addProduct, required this.updateProduct})
    : super(const ProductInitial()) {
    on<ProductAddRequested>(_onAddProduct);
    on<ProductUpdateRequested>(_onUpdateProduct);
  }

  Future<void> _onAddProduct(
    ProductAddRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());

    final result = await addProduct(event.product);

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (_) => emit(const ProductAdded()),
    );
  }

  Future<void> _onUpdateProduct(
    ProductUpdateRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());

    final result = await updateProduct(event.product);

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (_) => emit(ProductUpdatedSuccess(event.product)),
    );
  }
}
