import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/failures/product_failure.dart';
import 'package:orbiq/features/add_product/domain/repository/product_repository.dart';
import 'package:orbiq/features/add_product/domain/usecases/add_product_usecase.dart';

class FakeProductRepository implements ProductRepository {
  bool addProductCalled = false;
  ProductEntity? lastAddedProduct;

  @override
  Future<Either<ProductFailure, Unit>> addProduct(ProductEntity product) async {
    addProductCalled = true;
    lastAddedProduct = product;
    return const Right(unit);
  }

  @override
  Future<Either<ProductFailure, Unit>> updateProduct(
    ProductEntity product,
  ) async {
    // Not implemented for this test
    return const Right(unit);
  }
}

void main() {
  group('AddProductUsecase', () {
    late AddProductUsecase usecase;
    late FakeProductRepository fakeProductRepository;

    setUp(() {
      fakeProductRepository = FakeProductRepository();
      usecase = AddProductUsecase(fakeProductRepository);
    });

    test(
      'should call addProduct on the repository and return Right(unit)',
      () async {
        // Arrange
        final product = ProductEntity(
          name: 'Test Product',
          serialNumber: '12345',
          description: 'A test product',
          brand: 'Test Brand',
          model: 'Test Model',
          color: 'Red',
          material: 'Plastic',
          purchaseDate: DateTime.now(),
          originalPrice: 100.0,
          discountedPrice: 90.0,
          currentStock: 10,
          reorderPoint: 5,
          lastStockUpdate: DateTime.now(),
        );

        // Act
        final result = await usecase(product);

        // Assert
        expect(fakeProductRepository.addProductCalled, true);
        expect(fakeProductRepository.lastAddedProduct, product);
        expect(result.isRight(), true);
      },
    );
  });
}
