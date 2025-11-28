// features/get_product/domain/use_cases/get_products_usecase.dart
import 'package:equatable/equatable.dart';
import 'package:orbiq/features/get_product/data/repository/product_repository_impl.dart'; // Import PaginatedProducts
import 'package:orbiq/features/get_product/domain/repository/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<PaginatedProducts> call(GetProductsUseCaseParams params) async {
    // Updated return type
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
