import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/core/shared/product/data/mappers/product_mapper.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/core/shared/product/domain/repositories/product_stock_repository.dart';

/// Implementation of ProductStockRepository using ProductDao
@Injectable(as: ProductStockRepository)
class ProductStockRepositoryImpl implements ProductStockRepository {
  final ProductDao _productDao;

  ProductStockRepositoryImpl(this._productDao);

  @override
  Future<Either<String, ProductEntity>> getProductByUuid(String uuid) async {
    try {
      final product = await _productDao.getProductByUuid(uuid);
      if (product == null) {
        return const Left('محصول یافت نشد');
      }
      return Right(ProductMapper.toEntity(product));
    } catch (e) {
      return Left('خطا در دریافت محصول: $e');
    }
  }

  @override
  Future<Either<String, void>> updateStock(String uuid, int newStock) async {
    try {
      await _productDao.updateStock(uuid, newStock);
      return const Right(null);
    } catch (e) {
      return Left('خطا در بروزرسانی موجودی: $e');
    }
  }

  @override
  Future<Either<String, void>> updateStockAndWAC({
    required String uuid,
    required int additionalQty,
    required double newUnitPrice,
  }) async {
    try {
      await _productDao.updateStockAndWAC(
        uuid: uuid,
        additionalQty: additionalQty,
        newUnitPrice: newUnitPrice,
      );
      return const Right(null);
    } catch (e) {
      return Left('خطا در بروزرسانی موجودی و قیمت: $e');
    }
  }

  @override
  Future<Either<String, void>> updateOriginalPrice(
    String uuid,
    double newPrice,
  ) async {
    try {
      await _productDao.updateOriginalPrice(uuid, newPrice);
      return const Right(null);
    } catch (e) {
      return Left('خطا در بروزرسانی قیمت: $e');
    }
  }
}
