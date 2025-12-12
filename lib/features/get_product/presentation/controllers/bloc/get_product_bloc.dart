// get_product_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/get_product/domain/usecases/get_product_usecase.dart';
import 'package:orbiq/features/get_product/domain/usecases/get_products_usecase.dart';

import 'get_product_event.dart';
import 'get_product_state.dart';

@injectable
class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductBySerialUseCase getProductBySerialUseCase;

  int _currentPage = 1;
  final int _limit = 20;

  GetProductBloc({
    required this.getProductsUseCase,
    required this.getProductBySerialUseCase,
  }) : super(const GetProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProductBySerial>(_onSearchProductBySerial);
    on<LoadProductPageEvent>(_onLoadProductPageEvent);
  }

  void _onLoadProducts(
    LoadProducts event,
    Emitter<GetProductState> emit,
  ) async {
    emit(const ProductLoading());
    _currentPage = event.page < 1 ? 1 : event.page;
    try {
      final params = GetProductsUseCaseParams(
        page: _currentPage,
        limit: event.limit,
      );
      final paginatedData = await getProductsUseCase(params);
      final totalPages = (paginatedData.totalProducts / event.limit).ceil();
      emit(
        ProductLoaded(
          products: paginatedData.products,
          currentPage: _currentPage,
          totalPages: totalPages,
          hasNextPage: _currentPage < totalPages,
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onLoadProductPageEvent(
    LoadProductPageEvent event,
    Emitter<GetProductState> emit,
  ) async {
    emit(const ProductLoadingPage());
    _currentPage = event.page < 1 ? 1 : event.page;
    try {
      final params = GetProductsUseCaseParams(
        page: _currentPage,
        limit: _limit,
      );
      final paginatedData = await getProductsUseCase(params);
      final totalPages = (paginatedData.totalProducts / _limit).ceil();
      emit(
        ProductLoaded(
          products: paginatedData.products,
          currentPage: _currentPage,
          totalPages: totalPages,
          hasNextPage: _currentPage < totalPages,
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onSearchProductBySerial(
    SearchProductBySerial event,
    Emitter<GetProductState> emit,
  ) async {
    emit(const ProductLoading());
    try {
      final product = await getProductBySerialUseCase(event.serialNumber);
      if (product != null) {
        emit(ProductFound(product));
      } else {
        emit(const ProductNotFound());
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
