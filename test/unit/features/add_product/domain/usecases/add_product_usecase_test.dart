import 'package:flutter_test/flutter_test.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/repository/product_repository.dart';
import 'package:orbiq/features/add_product/domain/usecases/add_product_usecase.dart';

class FakeProductRepository implements ProductRepository {
  bool addProductCalled = false;
  ProductEntity? lastAddedProduct;

  @override
  Future<void> addProduct(ProductEntity product) async {
    addProductCalled = true;
    lastAddedProduct = product;
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    // Not implemented for this test
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

    test('should call addProduct on the repository', () async {
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
      await usecase(product);

      // Assert
      expect(fakeProductRepository.addProductCalled, true);
      expect(fakeProductRepository.lastAddedProduct, product);
    });
  });
}
