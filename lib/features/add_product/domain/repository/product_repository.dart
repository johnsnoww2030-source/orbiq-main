import 'package:dartz/dartz.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/failures/product_failure.dart';

abstract class ProductRepository {
  Future<Either<ProductFailure, Unit>> addProduct(ProductEntity product);
  Future<Either<ProductFailure, Unit>> updateProduct(ProductEntity product);
}
