part of 'get_product_bloc.dart';

@freezed
class GetProductState with _$GetProductState {
  const factory GetProductState.initial() = GetProductInitial;
  const factory GetProductState.loading() = ProductLoading;
  const factory GetProductState.loadingPage() = ProductLoadingPage;
  const factory GetProductState.loaded({
    required List<ProductModel> products,
    required int currentPage,
    required int totalPages,
    required bool hasNextPage,
  }) = ProductLoaded;
  const factory GetProductState.found(ProductModel product) = ProductFound;
  const factory GetProductState.notFound() = ProductNotFound;
  const factory GetProductState.error(String message) = ProductError;
}
