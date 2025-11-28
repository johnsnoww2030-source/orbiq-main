// lib/features/add_product/presentation/bloc/product_state.dart

import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductAdded extends ProductState {}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [
        message
      ];
}

class ProductUpdated extends ProductState {
  final ProductEntity updatedProduct;

  const ProductUpdated(this.updatedProduct);

  @override
  List<Object?> get props => [
        updatedProduct
      ];
}

class ProductUpdatedSuccess extends ProductState {
  final ProductEntity updatedProduct;
  const ProductUpdatedSuccess(this.updatedProduct);
}
