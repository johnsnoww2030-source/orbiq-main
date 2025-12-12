import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/product/data/models/product_model.dart';

sealed class GetProductState extends Equatable {
  const GetProductState();
}

class GetProductInitial extends GetProductState {
  const GetProductInitial();

  @override
  List<Object?> get props => [];
}

class ProductLoading extends GetProductState {
  const ProductLoading();

  @override
  List<Object?> get props => [];
}

class ProductLoadingPage extends GetProductState {
  const ProductLoadingPage();

  @override
  List<Object?> get props => [];
}

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
  List<Object?> get props => [products, currentPage, totalPages, hasNextPage];
}

class ProductFound extends GetProductState {
  final ProductModel product;

  const ProductFound(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductNotFound extends GetProductState {
  const ProductNotFound();

  @override
  List<Object?> get props => [];
}

class ProductError extends GetProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
