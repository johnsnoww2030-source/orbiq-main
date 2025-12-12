import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/daos/product_dao.dart';
import 'package:orbiq/core/shared/product/data/mappers/product_mapper.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/get_product/domain/repository/product_repository.dart';

class PaginatedProducts {
  final List<ProductEntity> products;
  final int totalProducts;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  PaginatedProducts({
    required this.products,
    required this.totalProducts,
    required this.currentPage,
    required int limit,
  }) : totalPages = (totalProducts / limit).ceil(),
       hasNextPage = currentPage * limit < totalProducts,
       hasPreviousPage = currentPage > 1;
}

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  final ProductDao productDao;

  ProductRepositoryImpl(this.productDao);

  @override
  Future<PaginatedProducts> getProducts({
    required int page,
    required int limit,
  }) async {
    try {
      if (page <= 0) {
        throw ArgumentError('صفحه باید بزرگتر از صفر باشد');
      }
      if (limit <= 0) {
        throw ArgumentError('حد باید بزرگتر از صفر باشد');
      }
      if (limit > 100) {
        throw ArgumentError('حداکثر حد مجاز 100 محصول است');
      }

      final allProducts = await productDao.getAllProducts();
      final allEntities = ProductMapper.toEntityList(allProducts);

      final totalProducts = allEntities.length;
      final startIndex = (page - 1) * limit;
      final endIndex = min(page * limit, totalProducts);

      if (startIndex >= totalProducts) {
        return PaginatedProducts(
          products: [],
          totalProducts: totalProducts,
          currentPage: page,
          limit: limit,
        );
      }

      return PaginatedProducts(
        products: allEntities.sublist(startIndex, endIndex),
        totalProducts: totalProducts,
        currentPage: page,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductEntity?> getProductBySerialNumber(String serialNumber) async {
    try {
      if (serialNumber.trim().isEmpty) {
        return null;
      }

      final product = await productDao.getProductBySerialNumber(
        serialNumber.trim(),
      );
      return product != null ? ProductMapper.toEntity(product) : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<PaginatedProducts> searchProducts({
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
        return PaginatedProducts(
          products: [],
          totalProducts: totalProducts,
          currentPage: page,
          limit: limit,
        );
      }

      return PaginatedProducts(
        products: filteredProducts.sublist(startIndex, endIndex),
        totalProducts: totalProducts,
        currentPage: page,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }
}
