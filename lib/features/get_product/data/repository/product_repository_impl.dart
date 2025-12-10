// import 'dart:math';

// import 'package:orbiq/core/shared/product/data/data_source/local/product_dao.dart';
// import 'package:orbiq/core/shared/product/data/models/product_model.dart';
// import 'package:orbiq/features/get_product/domain/repository/product_repository.dart';

// class PaginatedProducts {
//   final List<ProductModel> products;
//   final int totalProducts;

//   PaginatedProducts({required this.products, required this.totalProducts});
// }

// class ProductRepositoryImpl extends ProductRepository {
//   final ProductDao productDao; // Changed to a final field

//   ProductRepositoryImpl(this.productDao); // Correctly initialize productDao

//   @override
//   Future<PaginatedProducts> getProducts(
//       {required int page, required int limit}) async {
//     final allProducts = await productDao.getAllProducts();

//     // Sort products by creation date in descending order (newest first)
//     // allProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

//     final totalProducts = allProducts.length;

//     // Calculate startIndex and endIndex for pagination
//     final startIndex = (page - 1) * limit;
//     final endIndex = min(page * limit, totalProducts);

//     if (startIndex >= totalProducts) {
//       // Page is out of bounds
//       return PaginatedProducts(products: [], totalProducts: totalProducts);
//     }

//     // Return the sublist of products
//     return PaginatedProducts(
//         products: allProducts.sublist(startIndex, endIndex),
//         totalProducts: totalProducts);
//   }

//   @override
//   Future<ProductModel?> getProductBySerialNumber(String serialNumber) async {
//     return await productDao.getProductBySerialNumber(serialNumber);
//   }
// }

import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/shared/product/data/data_source/local/product_dao.dart';
import 'package:orbiq/core/shared/product/data/models/product_model.dart';
import 'package:orbiq/features/get_product/domain/repository/product_repository.dart';

class PaginatedProducts {
  final List<ProductModel> products;
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
      // اعتبارسنجی ورودی
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

      // مرتب‌سازی محصولات بر اساس تاریخ ایجاد (جدیدترین ابتدا)
      // اگر نیاز به مرتب‌سازی دارید، کامنت زیر را فعال کنید
      // allProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      final totalProducts = allProducts.length;

      // محاسبه شاخص شروع و پایان برای pagination
      final startIndex = (page - 1) * limit;
      final endIndex = min(page * limit, totalProducts);

      // بررسی اینکه آیا صفحه خارج از محدوده است یا نه
      if (startIndex >= totalProducts) {
        return PaginatedProducts(
          products: [],
          totalProducts: totalProducts,
          currentPage: page,
          limit: limit,
        );
      }

      // بازگرداندن زیرلیست محصولات
      return PaginatedProducts(
        products: allProducts.sublist(startIndex, endIndex),
        totalProducts: totalProducts,
        currentPage: page,
        limit: limit,
      );
    } catch (e) {
      // در صورت بروز خطا، خطا را دوباره پرتاب کنید
      rethrow;
    }
  }

  @override
  Future<ProductModel?> getProductBySerialNumber(String serialNumber) async {
    try {
      // اعتبارسنجی ورودی
      if (serialNumber.trim().isEmpty) {
        return null;
      }

      return await productDao.getProductBySerialNumber(serialNumber.trim());
    } catch (e) {
      // لاگ خطا (در صورت نیاز)
      // logger.error('خطا در دریافت محصول با شماره سریال: $serialNumber', e);
      rethrow;
    }
  }

  // متد اضافی برای جستجوی محصولات
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

      // فیلتر کردن محصولات بر اساس query
      final filteredProducts = allProducts.where((product) {
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
