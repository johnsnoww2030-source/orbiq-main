import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = CartInitial;
  const factory CartState.updated(List<ProductEntity> items) = CartUpdated;
}
