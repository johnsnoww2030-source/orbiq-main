import 'package:orbiq/core/shared/product/data/models/product_model.dart';
import 'package:orbiq/features/get_product/domain/repository/product_repository.dart';

class GetProductBySerialUseCase {
  final ProductRepository repository;

  GetProductBySerialUseCase(this.repository);

  Future<ProductModel?> call(String serialNumber) {
    return repository.getProductBySerialNumber(serialNumber);
  }
}
