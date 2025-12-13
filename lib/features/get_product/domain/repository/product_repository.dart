import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/get_product/domain/entities/paginated_products.dart';

abstract class ProductRepository {
  Future<PaginatedProducts> getProducts({
    required int page,
    required int limit,
  }); // Updated return type
  Future<ProductEntity?> getProductBySerialNumber(String serialNumber);
}
