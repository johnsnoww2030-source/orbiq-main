import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/repository/product_repository.dart';

abstract class AddProduct {
  AddProduct(ProductEntity product);

  Future call(ProductEntity product);
}

class AddProductUsecase implements AddProduct {
  final ProductRepository productRepository;

  const AddProductUsecase(this.productRepository);

  @override
  Future<void> call(ProductEntity product) async {
    await productRepository.addProduct(product);
  }
}
