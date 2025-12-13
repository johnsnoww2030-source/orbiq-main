import 'package:dartz/dartz.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/core/utils/error/failures.dart';
import 'package:orbiq/features/get_product/domain/entities/paginated_products.dart';

abstract class ProductRepository {
  Future<Either<Failure, PaginatedProductsEntity>> getProducts({
    required int page,
    required int limit,
  });
  Future<Either<Failure, ProductEntity?>> getProductBySerialNumber(
    String serialNumber,
  );
}
