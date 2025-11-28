import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

// تعریف رویدادها
abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final ProductEntity product;

  AddToCartEvent(this.product);

  @override
  List<Object> get props => [
        product
      ];
}

class RemoveFromCartEvent extends CartEvent {
  final ProductEntity product;

  RemoveFromCartEvent(this.product);

  @override
  List<Object> get props => [
        product
      ];
}

class ClearCartEvent extends CartEvent {}
