import 'package:orbiq/core/shared/product/data/data_source/local/product_dao.dart';
import 'package:orbiq/core/shared/product/data/models/product_model.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDao _productDao;

  ProductRepositoryImpl(this._productDao);

  @override
  Future<void> addProduct(ProductEntity product) async {
    final productModel = ProductModel.fromEntity(product);
    await _productDao.insertProduct(productModel);
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    final productModel = ProductModel.fromEntity(product);
    try {
      await _productDao.updateProduct(productModel); // بروزرسانی محصول
    } catch (e) {
      // چاپ خطا در صورت بروز
    }
  }
}
