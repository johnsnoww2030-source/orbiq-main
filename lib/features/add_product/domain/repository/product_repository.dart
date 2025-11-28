import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<void> addProduct(ProductEntity product);
  Future<void> updateProduct(ProductEntity product); // متد بروزرسانی
}
