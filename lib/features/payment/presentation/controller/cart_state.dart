import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<ProductEntity> cartItems;

  CartUpdated(this.cartItems);

  @override
  List<Object> get props => [
        cartItems
      ];
}
