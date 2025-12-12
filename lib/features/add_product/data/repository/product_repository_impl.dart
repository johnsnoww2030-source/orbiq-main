import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/core/shared/product/data/mappers/product_mapper.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/repository/product_repository.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductDao _productDao;

  ProductRepositoryImpl(this._productDao);

  @override
  Future<void> addProduct(ProductEntity product) async {
    final companion = ProductMapper.toCompanion(product);
    await _productDao.insertProduct(companion);
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    if (product.uuid != null) {
      final existing = await _productDao.getProductByUuid(product.uuid!);
      if (existing != null) {
        final companion = ProductMapper.toCompanion(
          product,
          existingUuid: product.uuid,
        );
        await _productDao.updateProductByUuid(product.uuid!, companion);
      }
    }
  }
}
