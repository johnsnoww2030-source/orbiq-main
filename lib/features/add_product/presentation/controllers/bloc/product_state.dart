// lib/features/add_product/presentation/bloc/product_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = ProductInitial;
  const factory ProductState.loading() = ProductLoading;
  const factory ProductState.added() = ProductAdded;
  const factory ProductState.error(String message) = ProductError;
  const factory ProductState.updated(ProductEntity updatedProduct) =
      ProductUpdated;
  const factory ProductState.updatedSuccess(ProductEntity updatedProduct) =
      ProductUpdatedSuccess;
}
