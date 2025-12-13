import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/core/shared/product/data/mappers/product_mapper.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/core/utils/error/failures.dart';
import 'package:orbiq/features/get_product/data/constants/product_constants.dart';
import 'package:orbiq/features/get_product/domain/entities/paginated_products.dart';
import 'package:orbiq/features/get_product/domain/repository/product_repository.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  final ProductDao productDao;

  ProductRepositoryImpl(this.productDao);

  @override
  Future<Either<Failure, PaginatedProductsEntity>> getProducts({
    required int page,
    required int limit,
  }) async {
    try {
      if (page < ProductConstants.minPage) {
        return const Left(ProductFailure('INVALID_PAGE'));
      }
      if (limit <= 0) {
        return const Left(ProductFailure('INVALID_LIMIT'));
      }
      if (limit > ProductConstants.maxPageLimit) {
        return const Left(ProductFailure('LIMIT_EXCEEDED'));
      }

      final allProducts = await productDao.getAllProducts();
      final allEntities = ProductMapper.toEntityList(allProducts);

      final totalProducts = allEntities.length;
      final startIndex = (page - 1) * limit;
      final endIndex = min(page * limit, totalProducts);

      if (startIndex >= totalProducts) {
        return Right(
          PaginatedProductsEntity(
            products: [],
            totalProducts: totalProducts,
            currentPage: page,
            limit: limit,
          ),
        );
      }

      return Right(
        PaginatedProductsEntity(
          products: allEntities.sublist(startIndex, endIndex),
          totalProducts: totalProducts,
          currentPage: page,
          limit: limit,
        ),
      );
    } catch (e) {
      return Left(ProductFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity?>> getProductBySerialNumber(
    String serialNumber,
  ) async {
    try {
      if (serialNumber.trim().isEmpty) {
        return const Right(null);
      }

      final product = await productDao.getProductBySerialNumber(
        serialNumber.trim(),
      );
      return Right(product != null ? ProductMapper.toEntity(product) : null);
    } catch (e) {
      return Left(ProductFailure(e.toString()));
    }
  }

  Future<Either<Failure, PaginatedProductsEntity>> searchProducts({
    required String query,
    required int page,
    required int limit,
  }) async {
    try {
      if (query.trim().isEmpty) {
        return getProducts(page: page, limit: limit);
      }

      final allProducts = await productDao.getAllProducts();
      final allEntities = ProductMapper.toEntityList(allProducts);

      final filteredProducts = allEntities.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.serialNumber.toLowerCase().contains(query.toLowerCase());
      }).toList();

      final totalProducts = filteredProducts.length;
      final startIndex = (page - 1) * limit;
      final endIndex = min(page * limit, totalProducts);

      if (startIndex >= totalProducts) {
        return Right(
          PaginatedProductsEntity(
            products: [],
            totalProducts: totalProducts,
            currentPage: page,
            limit: limit,
          ),
        );
      }

      return Right(
        PaginatedProductsEntity(
          products: filteredProducts.sublist(startIndex, endIndex),
          totalProducts: totalProducts,
          currentPage: page,
          limit: limit,
        ),
      );
    } catch (e) {
      return Left(ProductFailure(e.toString()));
    }
  }
}
