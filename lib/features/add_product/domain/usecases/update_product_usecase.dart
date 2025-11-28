// lib/features/add_product/domain/usecases/update_product_usecase.dart

import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/repository/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository repository;

  UpdateProductUseCase(this.repository);

  Future<void> call(ProductEntity product) async {
    return await repository.updateProduct(product);
  }
}
