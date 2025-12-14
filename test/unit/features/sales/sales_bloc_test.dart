import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';
import 'package:orbiq/features/sales/domain/failures/sales_failure.dart';
import 'package:orbiq/features/sales/domain/repositories/sales_repository.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_bloc.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_event.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_state.dart';

/// Fake implementation of SalesRepository for testing
class FakeSalesRepository implements SalesRepository {
  bool getAllSalesCalled = false;
  bool getSalesByUuidCalled = false;
  bool createSaleCalled = false;
  bool deleteSaleCalled = false;
  bool updateSaleStatusCalled = false;
  bool getTodaySalesCalled = false;
  bool getTotalRevenueCalled = false;
  bool getTotalProfitCalled = false;

  SalesEntity? lastCreatedSale;
  String? lastDeletedUuid;

  // Configurable responses
  Either<SalesFailure, List<SalesEntity>> allSalesResponse = const Right([]);
  Either<SalesFailure, SalesEntity>? getSaleResponse;
  Either<SalesFailure, SalesEntity>? createResponse;
  Either<SalesFailure, void>? deleteResponse;
  Either<SalesFailure, void>? updateStatusResponse;
  Either<SalesFailure, List<SalesEntity>>? todaySalesResponse;
  Either<SalesFailure, double> revenueResponse = const Right(0.0);
  Either<SalesFailure, double> profitResponse = const Right(0.0);

  @override
  Future<Either<SalesFailure, List<SalesEntity>>> getAllSales() async {
    getAllSalesCalled = true;
    return allSalesResponse;
  }

  @override
  Future<Either<SalesFailure, SalesEntity>> getSalesByUuid(String uuid) async {
    getSalesByUuidCalled = true;
    return getSaleResponse ?? const Left(SalesNotFoundFailure());
  }

  @override
  Future<Either<SalesFailure, SalesEntity>> createSale(SalesEntity sale) async {
    createSaleCalled = true;
    lastCreatedSale = sale;
    return createResponse ?? Right(sale);
  }

  @override
  Future<Either<SalesFailure, void>> deleteSale(String uuid) async {
    deleteSaleCalled = true;
    lastDeletedUuid = uuid;
    return deleteResponse ?? const Right(null);
  }

  @override
  Future<Either<SalesFailure, void>> updateSaleStatus(
    String uuid,
    String status,
  ) async {
    updateSaleStatusCalled = true;
    return updateStatusResponse ?? const Right(null);
  }

  @override
  Future<Either<SalesFailure, List<SalesEntity>>> getTodaySales() async {
    getTodaySalesCalled = true;
    return todaySalesResponse ?? const Right([]);
  }

  @override
  Future<Either<SalesFailure, double>> getTotalRevenue() async {
    getTotalRevenueCalled = true;
    return revenueResponse;
  }

  @override
  Future<Either<SalesFailure, double>> getTotalProfit() async {
    getTotalProfitCalled = true;
    return profitResponse;
  }

  @override
  Stream<List<SalesEntity>> watchAllSales() {
    return Stream.value([]);
  }
}

/// Factory for creating test data
class SalesTestFactory {
  static SalesEntity createSale({
    String invoiceUuid = 'test-uuid',
    String? customerInfo = 'Test Customer',
    double totalAmount = 1000.0,
    String status = 'COMPLETED',
    List<SalesItemEntity> items = const [],
  }) {
    final now = DateTime.now();
    return SalesEntity(
      invoiceUuid: invoiceUuid,
      customerInfo: customerInfo,
      invoiceDate: now,
      totalAmount: totalAmount,
      status: status,
      userUuid: 'user-uuid',
      createdAt: now,
      updatedAt: now,
      items: items,
    );
  }

  static SalesItemEntity createItem({
    String itemUuid = 'item-uuid',
    String invoiceUuid = 'test-uuid',
    String productUuid = 'product-uuid',
    String? productName = 'Test Product',
    int quantity = 10,
    double unitSellPrice = 100.0,
    double costAtSale = 80.0,
    double totalPrice = 1000.0,
    double profit = 200.0,
  }) {
    return SalesItemEntity(
      itemUuid: itemUuid,
      invoiceUuid: invoiceUuid,
      productUuid: productUuid,
      productName: productName,
      quantity: quantity,
      unitSellPrice: unitSellPrice,
      costAtSale: costAtSale,
      totalPrice: totalPrice,
      profit: profit,
    );
  }
}

void main() {
  group('SalesBloc', () {
    late SalesBloc bloc;
    late FakeSalesRepository fakeRepository;

    setUp(() {
      fakeRepository = FakeSalesRepository();
      bloc = SalesBloc(fakeRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is SalesInitial', () {
      expect(bloc.state, isA<SalesInitial>());
    });

    group('LoadSalesEvent', () {
      blocTest<SalesBloc, SalesState>(
        'emits [SalesLoading, SalesLoaded] when successful',
        build: () {
          fakeRepository.allSalesResponse = Right([
            SalesTestFactory.createSale(),
          ]);
          fakeRepository.revenueResponse = const Right(1000.0);
          fakeRepository.profitResponse = const Right(200.0);
          return SalesBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const LoadSalesEvent()),
        expect: () => [isA<SalesLoading>(), isA<SalesLoaded>()],
        verify: (_) {
          expect(fakeRepository.getAllSalesCalled, true);
          expect(fakeRepository.getTotalRevenueCalled, true);
          expect(fakeRepository.getTotalProfitCalled, true);
        },
      );

      blocTest<SalesBloc, SalesState>(
        'emits [SalesLoading, SalesError] when fails',
        build: () {
          fakeRepository.allSalesResponse = const Left(
            SalesDatabaseFailure('Database error'),
          );
          return SalesBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const LoadSalesEvent()),
        expect: () => [isA<SalesLoading>(), isA<SalesError>()],
      );
    });

    group('CreateSaleEvent', () {
      blocTest<SalesBloc, SalesState>(
        'emits [SalesLoading, SaleCreated] when successful',
        build: () {
          final sale = SalesTestFactory.createSale();
          fakeRepository.createResponse = Right(sale);
          return SalesBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(CreateSaleEvent(SalesTestFactory.createSale())),
        expect: () => [isA<SalesLoading>(), isA<SaleCreated>()],
        verify: (_) {
          expect(fakeRepository.createSaleCalled, true);
          expect(fakeRepository.lastCreatedSale, isNotNull);
        },
      );

      blocTest<SalesBloc, SalesState>(
        'emits [SalesLoading, SalesError] when stock is insufficient',
        build: () {
          fakeRepository.createResponse = const Left(
            InsufficientStockFailure(
              productName: 'Test Product',
              available: 5,
              requested: 10,
            ),
          );
          return SalesBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(CreateSaleEvent(SalesTestFactory.createSale())),
        expect: () => [isA<SalesLoading>(), isA<SalesError>()],
      );
    });

    group('DeleteSaleEvent', () {
      blocTest<SalesBloc, SalesState>(
        'emits [SalesLoading, SaleDeleted] when successful',
        build: () {
          fakeRepository.deleteResponse = const Right(null);
          return SalesBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const DeleteSaleEvent('test-uuid')),
        expect: () => [isA<SalesLoading>(), isA<SaleDeleted>()],
        verify: (_) {
          expect(fakeRepository.deleteSaleCalled, true);
          expect(fakeRepository.lastDeletedUuid, 'test-uuid');
        },
      );

      blocTest<SalesBloc, SalesState>(
        'emits [SalesLoading, SalesError] when sale not found',
        build: () {
          fakeRepository.deleteResponse = const Left(SalesNotFoundFailure());
          return SalesBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const DeleteSaleEvent('non-existent')),
        expect: () => [isA<SalesLoading>(), isA<SalesError>()],
      );
    });

    group('LoadSaleDetailsEvent', () {
      blocTest<SalesBloc, SalesState>(
        'emits [SalesLoading, SalesDetailsLoaded] when successful',
        build: () {
          fakeRepository.getSaleResponse = Right(SalesTestFactory.createSale());
          return SalesBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const LoadSaleDetailsEvent('test-uuid')),
        expect: () => [isA<SalesLoading>(), isA<SalesDetailsLoaded>()],
        verify: (_) {
          expect(fakeRepository.getSalesByUuidCalled, true);
        },
      );
    });

    group('LoadTodaySalesEvent', () {
      blocTest<SalesBloc, SalesState>(
        'emits [SalesLoading, SalesLoaded] when successful',
        build: () {
          fakeRepository.todaySalesResponse = Right([
            SalesTestFactory.createSale(items: [SalesTestFactory.createItem()]),
          ]);
          return SalesBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const LoadTodaySalesEvent()),
        expect: () => [isA<SalesLoading>(), isA<SalesLoaded>()],
        verify: (_) {
          expect(fakeRepository.getTodaySalesCalled, true);
        },
      );
    });
  });
}
