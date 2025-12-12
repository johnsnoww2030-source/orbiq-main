// lib/features/add_product/presentation/bloc/product_state.dart

import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

sealed class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial();

  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  const ProductLoading();

  @override
  List<Object?> get props => [];
}

class ProductAdded extends ProductState {
  const ProductAdded();

  @override
  List<Object?> get props => [];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductUpdated extends ProductState {
  final ProductEntity updatedProduct;

  const ProductUpdated(this.updatedProduct);

  @override
  List<Object?> get props => [updatedProduct];
}

class ProductUpdatedSuccess extends ProductState {
  final ProductEntity updatedProduct;

  const ProductUpdatedSuccess(this.updatedProduct);

  @override
  List<Object?> get props => [updatedProduct];
}
