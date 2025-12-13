// features/get_product/domain/use_cases/get_products_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/utils/error/failures.dart';
import 'package:orbiq/features/get_product/domain/entities/paginated_products.dart';
import 'package:orbiq/features/get_product/domain/repository/product_repository.dart';

@injectable
class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, PaginatedProductsEntity>> call(
    GetProductsUseCaseParams params,
  ) async {
    return await repository.getProducts(page: params.page, limit: params.limit);
  }
}

class GetProductsUseCaseParams extends Equatable {
  final int page;
  final int limit;

  const GetProductsUseCaseParams({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
