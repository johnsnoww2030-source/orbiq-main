import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/core/utils/error/failures.dart';
import 'package:orbiq/features/get_product/domain/repository/product_repository.dart';

@injectable
class GetProductBySerialUseCase {
  final ProductRepository repository;

  GetProductBySerialUseCase(this.repository);

  Future<Either<Failure, ProductEntity?>> call(String serialNumber) {
    return repository.getProductBySerialNumber(serialNumber);
  }
}
