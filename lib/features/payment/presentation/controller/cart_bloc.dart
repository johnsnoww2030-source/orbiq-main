import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/payment/presentation/controller/cart_event.dart';
import 'package:orbiq/features/payment/presentation/controller/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<ProductEntity> _cartItems = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCartEvent>((event, emit) {
      _cartItems.add(event.product);
      emit(CartUpdated(List.from(_cartItems)));
    });

    on<RemoveFromCartEvent>((event, emit) {
      _cartItems.remove(event.product);
      emit(CartUpdated(List.from(_cartItems)));
    });

    on<ClearCartEvent>((event, emit) {
      _cartItems.clear();
      emit(CartUpdated(List.from(_cartItems)));
    });
  }
}
