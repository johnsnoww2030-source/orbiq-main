import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

sealed class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();

  @override
  List<Object?> get props => [];
}

class CartUpdated extends CartState {
  final List<ProductEntity> items;

  const CartUpdated(this.items);

  @override
  List<Object?> get props => [items];
}
