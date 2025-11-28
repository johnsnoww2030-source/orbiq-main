import 'package:orbiq/core/shared/product/data/models/product_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProductDao {
  @Query('SELECT * FROM ProductModel')
  Future<List<ProductModel>> getAllProducts();

  @Query('SELECT * FROM ProductModel WHERE serialNumber = :serialNumber')
  Future<ProductModel?> getProductBySerialNumber(String serialNumber); // اضافه کردن جستجو بر اساس شماره سریال

  @insert
  Future<void> insertProduct(ProductModel product);

  @update
  Future<void> updateProduct(ProductModel product); // اضافه کردن متد بروزرسانی
}
