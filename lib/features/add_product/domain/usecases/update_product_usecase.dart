import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/failures/product_failure.dart';
import 'package:orbiq/features/add_product/domain/repository/product_repository.dart';

@injectable
class UpdateProductUseCase {
  final ProductRepository repository;

  UpdateProductUseCase(this.repository);

  Future<Either<ProductFailure, Unit>> call(ProductEntity product) async {
    return await repository.updateProduct(product);
  }
}
