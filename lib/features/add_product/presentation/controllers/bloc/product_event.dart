// lib/features/add_product/presentation/bloc/product_event.dart

import 'package:equatable/equatable.dart';
import '../../../../../core/shared/product/domain/entities/product_entity.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class AddProductEvent extends ProductEvent {
  final ProductEntity product;

  const AddProductEvent(this.product);

  @override
  List<Object?> get props => [
        product
      ];
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;

  const UpdateProductEvent(this.product);

  @override
  List<Object?> get props => [
        product
      ];
}

class LoadProductsEvent extends ProductEvent {
  const LoadProductsEvent();

  @override
  List<Object?> get props => [];
}
