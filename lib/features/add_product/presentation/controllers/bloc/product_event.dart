import 'package:equatable/equatable.dart';
import '../../../../../core/shared/product/domain/entities/product_entity.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when user requests to add a new product
class ProductAddRequested extends ProductEvent {
  final ProductEntity product;

  const ProductAddRequested(this.product);

  @override
  List<Object?> get props => [product];
}

/// Event triggered when user requests to update an existing product
class ProductUpdateRequested extends ProductEvent {
  final ProductEntity product;

  const ProductUpdateRequested(this.product);

  @override
  List<Object?> get props => [product];
}

/// Event triggered when user requests to load all products
class ProductsLoadRequested extends ProductEvent {
  const ProductsLoadRequested();

  @override
  List<Object?> get props => [];
}
