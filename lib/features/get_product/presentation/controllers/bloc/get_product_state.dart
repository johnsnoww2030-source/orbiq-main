part of 'get_product_bloc.dart';

sealed class GetProductState extends Equatable {
  const GetProductState();

  @override
  List<Object> get props => [];
}

final class GetProductInitial extends GetProductState {}

class ProductLoading extends GetProductState {}

class ProductLoadingPage extends GetProductState {} // New state for loading next page

class ProductLoaded extends GetProductState {
  final List<ProductModel> products;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;

  const ProductLoaded({
    required this.products,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
  });

  @override
  List<Object> get props => [products, currentPage, totalPages, hasNextPage];
}

class ProductFound extends GetProductState {
  final ProductModel product;

  const ProductFound(this.product);

  @override
  List<Object> get props => [product];
}

class ProductNotFound extends GetProductState {}

class ProductError extends GetProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
