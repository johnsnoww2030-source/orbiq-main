import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/failures/product_failure.dart';
import 'package:orbiq/features/add_product/domain/repository/product_repository.dart';

abstract class AddProduct {
  Future<Either<ProductFailure, Unit>> call(ProductEntity product);
}

@Injectable(as: AddProduct)
class AddProductUsecase implements AddProduct {
  final ProductRepository productRepository;

  const AddProductUsecase(this.productRepository);

  @override
  Future<Either<ProductFailure, Unit>> call(ProductEntity product) async {
    return await productRepository.addProduct(product);
  }
}
