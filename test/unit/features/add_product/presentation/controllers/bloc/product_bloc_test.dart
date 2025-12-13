import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/add_product/domain/failures/product_failure.dart';
import 'package:orbiq/features/add_product/domain/usecases/add_product_usecase.dart';
import 'package:orbiq/features/add_product/domain/usecases/update_product_usecase.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_bloc.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_event.dart';
import 'package:orbiq/features/add_product/presentation/controllers/bloc/product_state.dart';

// Mock classes
class MockAddProduct extends Mock implements AddProduct {}

class MockUpdateProductUseCase extends Mock implements UpdateProductUseCase {}

class FakeProductEntity extends Fake implements ProductEntity {}

void main() {
  late ProductBloc productBloc;
  late MockAddProduct mockAddProduct;
  late MockUpdateProductUseCase mockUpdateProductUseCase;

  final testProduct = ProductEntity(
    uuid: 'test-uuid',
    name: 'Test Product',
    serialNumber: '12345',
    description: 'A test product',
    brand: 'Test Brand',
    model: 'Test Model',
    color: 'Red',
    material: 'Plastic',
    purchaseDate: DateTime(2024, 1, 1),
    originalPrice: 100.0,
    discountedPrice: 90.0,
    currentStock: 10,
    reorderPoint: 5,
    lastStockUpdate: DateTime(2024, 1, 1),
  );

  setUpAll(() {
    registerFallbackValue(FakeProductEntity());
  });

  setUp(() {
    mockAddProduct = MockAddProduct();
    mockUpdateProductUseCase = MockUpdateProductUseCase();
    productBloc = ProductBloc(
      addProduct: mockAddProduct,
      updateProduct: mockUpdateProductUseCase,
    );
  });

  tearDown(() {
    productBloc.close();
  });

  group('ProductBloc', () {
    test('initial state should be ProductInitial', () {
      expect(productBloc.state, const ProductInitial());
    });

    group('ProductAddRequested', () {
      blocTest<ProductBloc, ProductState>(
        'emits [ProductLoading, ProductAdded] when add product succeeds',
        build: () {
          when(
            () => mockAddProduct(any()),
          ).thenAnswer((_) async => const Right(unit));
          return productBloc;
        },
        act: (bloc) => bloc.add(ProductAddRequested(testProduct)),
        expect: () => [const ProductLoading(), const ProductAdded()],
        verify: (_) {
          verify(() => mockAddProduct(testProduct)).called(1);
        },
      );

      blocTest<ProductBloc, ProductState>(
        'emits [ProductLoading, ProductError] when add product fails',
        build: () {
          when(() => mockAddProduct(any())).thenAnswer(
            (_) async => const Left(ProductDatabaseFailure('Database error')),
          );
          return productBloc;
        },
        act: (bloc) => bloc.add(ProductAddRequested(testProduct)),
        expect: () => [
          const ProductLoading(),
          const ProductError('Database error'),
        ],
      );
    });

    group('ProductUpdateRequested', () {
      blocTest<ProductBloc, ProductState>(
        'emits [ProductLoading, ProductUpdatedSuccess] when update product succeeds',
        build: () {
          when(
            () => mockUpdateProductUseCase(any()),
          ).thenAnswer((_) async => const Right(unit));
          return productBloc;
        },
        act: (bloc) => bloc.add(ProductUpdateRequested(testProduct)),
        expect: () => [
          const ProductLoading(),
          ProductUpdatedSuccess(testProduct),
        ],
        verify: (_) {
          verify(() => mockUpdateProductUseCase(testProduct)).called(1);
        },
      );

      blocTest<ProductBloc, ProductState>(
        'emits [ProductLoading, ProductError] when update product fails',
        build: () {
          when(
            () => mockUpdateProductUseCase(any()),
          ).thenAnswer((_) async => const Left(ProductNotFoundFailure()));
          return productBloc;
        },
        act: (bloc) => bloc.add(ProductUpdateRequested(testProduct)),
        expect: () => [
          const ProductLoading(),
          const ProductError('Product not found'),
        ],
      );

      blocTest<ProductBloc, ProductState>(
        'emits [ProductLoading, ProductError] when validation fails',
        build: () {
          when(() => mockUpdateProductUseCase(any())).thenAnswer(
            (_) async =>
                const Left(ProductValidationFailure('UUID is required')),
          );
          return productBloc;
        },
        act: (bloc) => bloc.add(ProductUpdateRequested(testProduct)),
        expect: () => [
          const ProductLoading(),
          const ProductError('UUID is required'),
        ],
      );
    });
  });
}
