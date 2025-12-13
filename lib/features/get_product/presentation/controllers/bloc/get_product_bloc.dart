// get_product_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/get_product/data/constants/product_constants.dart';
import 'package:orbiq/features/get_product/domain/usecases/get_product_usecase.dart';
import 'package:orbiq/features/get_product/domain/usecases/get_products_usecase.dart';

import 'get_product_event.dart';
import 'get_product_state.dart';

@injectable
class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductBySerialUseCase getProductBySerialUseCase;

  int _currentPage = 1;

  GetProductBloc({
    required this.getProductsUseCase,
    required this.getProductBySerialUseCase,
  }) : super(const GetProductInitial()) {
    on<ProductsLoadRequested>(_onProductsLoadRequested);
    on<ProductBySerialSearchRequested>(_onProductBySerialSearchRequested);
    on<ProductPageLoadRequested>(_onProductPageLoadRequested);
  }

  void _onProductsLoadRequested(
    ProductsLoadRequested event,
    Emitter<GetProductState> emit,
  ) async {
    emit(const ProductLoading());
    _currentPage = event.page < 1 ? 1 : event.page;

    final result = await getProductsUseCase(
      GetProductsUseCaseParams(page: _currentPage, limit: event.limit),
    );

    result.fold((failure) => emit(ProductError(failure.toString())), (
      paginatedData,
    ) {
      final totalPages = (paginatedData.totalProducts / event.limit).ceil();
      emit(
        ProductLoaded(
          products: paginatedData.products,
          currentPage: _currentPage,
          totalPages: totalPages,
          hasNextPage: _currentPage < totalPages,
        ),
      );
    });
  }

  void _onProductPageLoadRequested(
    ProductPageLoadRequested event,
    Emitter<GetProductState> emit,
  ) async {
    emit(const ProductLoadingPage());
    _currentPage = event.page < 1 ? 1 : event.page;

    final result = await getProductsUseCase(
      GetProductsUseCaseParams(
        page: _currentPage,
        limit: ProductConstants.defaultPageLimit,
      ),
    );

    result.fold((failure) => emit(ProductError(failure.toString())), (
      paginatedData,
    ) {
      final totalPages =
          (paginatedData.totalProducts / ProductConstants.defaultPageLimit)
              .ceil();
      emit(
        ProductLoaded(
          products: paginatedData.products,
          currentPage: _currentPage,
          totalPages: totalPages,
          hasNextPage: _currentPage < totalPages,
        ),
      );
    });
  }

  void _onProductBySerialSearchRequested(
    ProductBySerialSearchRequested event,
    Emitter<GetProductState> emit,
  ) async {
    emit(const ProductLoading());

    final result = await getProductBySerialUseCase(event.serialNumber);

    result.fold((failure) => emit(ProductError(failure.toString())), (product) {
      if (product != null) {
        emit(ProductFound(product));
      } else {
        emit(const ProductNotFound());
      }
    });
  }
}
