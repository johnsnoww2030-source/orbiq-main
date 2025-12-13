import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:orbiq/features/purchase/domain/entities/purchase_entity.dart';
import 'package:orbiq/features/purchase/domain/failures/purchase_failure.dart';
import 'package:orbiq/features/purchase/domain/repositories/purchase_repository.dart';
import 'package:orbiq/features/purchase/presentation/controller/purchase_bloc.dart';
import 'package:orbiq/features/purchase/presentation/controller/purchase_event.dart';
import 'package:orbiq/features/purchase/presentation/controller/purchase_state.dart';

/// Fake implementation of PurchaseRepository for testing
class FakePurchaseRepository implements PurchaseRepository {
  bool getAllPurchasesCalled = false;
  bool getPurchaseByUuidCalled = false;
  bool createPurchaseCalled = false;
  bool updatePurchaseCalled = false;
  bool deletePurchaseCalled = false;

  PurchaseEntity? lastCreatedPurchase;
  PurchaseEntity? lastUpdatedPurchase;
  String? lastDeletedUuid;

  // Configurable responses
  Either<PurchaseFailure, List<PurchaseEntity>> allPurchasesResponse =
      const Right([]);
  Either<PurchaseFailure, PurchaseEntity>? getPurchaseResponse;
  Either<PurchaseFailure, PurchaseEntity>? createResponse;
  Either<PurchaseFailure, PurchaseEntity>? updateResponse;
  Either<PurchaseFailure, void>? deleteResponse;

  @override
  Future<Either<PurchaseFailure, List<PurchaseEntity>>>
  getAllPurchases() async {
    getAllPurchasesCalled = true;
    return allPurchasesResponse;
  }

  @override
  Future<Either<PurchaseFailure, PurchaseEntity>> getPurchaseByUuid(
    String uuid,
  ) async {
    getPurchaseByUuidCalled = true;
    return getPurchaseResponse ?? const Left(PurchaseNotFoundFailure());
  }

  @override
  Future<Either<PurchaseFailure, PurchaseEntity>> createPurchase(
    PurchaseEntity purchase,
  ) async {
    createPurchaseCalled = true;
    lastCreatedPurchase = purchase;
    return createResponse ?? Right(purchase);
  }

  @override
  Future<Either<PurchaseFailure, PurchaseEntity>> updatePurchase(
    PurchaseEntity purchase,
  ) async {
    updatePurchaseCalled = true;
    lastUpdatedPurchase = purchase;
    return updateResponse ?? Right(purchase);
  }

  @override
  Future<Either<PurchaseFailure, void>> deletePurchase(String uuid) async {
    deletePurchaseCalled = true;
    lastDeletedUuid = uuid;
    return deleteResponse ?? const Right(null);
  }

  @override
  Stream<List<PurchaseEntity>> watchAllPurchases() {
    return Stream.value([]);
  }
}

/// Factory for creating test data
class PurchaseTestFactory {
  static PurchaseEntity createPurchase({
    String purchaseUuid = 'test-uuid',
    String? supplierName = 'Test Supplier',
    double totalCost = 100.0,
    double additionalCosts = 10.0,
    double finalTotal = 110.0,
    List<PurchaseItemEntity> items = const [],
  }) {
    final now = DateTime.now();
    return PurchaseEntity(
      purchaseUuid: purchaseUuid,
      supplierName: supplierName,
      purchaseDate: now,
      totalCost: totalCost,
      additionalCosts: additionalCosts,
      finalTotal: finalTotal,
      createdAt: now,
      updatedAt: now,
      items: items,
    );
  }

  static PurchaseItemEntity createItem({
    String itemUuid = 'item-uuid',
    String purchaseUuid = 'test-uuid',
    String productUuid = 'product-uuid',
    String? productName = 'Test Product',
    int quantity = 10,
    double unitBuyPrice = 100.0,
    double totalPrice = 1000.0,
  }) {
    return PurchaseItemEntity(
      itemUuid: itemUuid,
      purchaseUuid: purchaseUuid,
      productUuid: productUuid,
      productName: productName,
      quantity: quantity,
      unitBuyPrice: unitBuyPrice,
      totalPrice: totalPrice,
    );
  }
}

void main() {
  group('PurchaseBloc', () {
    late PurchaseBloc bloc;
    late FakePurchaseRepository fakeRepository;

    setUp(() {
      fakeRepository = FakePurchaseRepository();
      bloc = PurchaseBloc(fakeRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is PurchaseInitial', () {
      expect(bloc.state, isA<PurchaseInitial>());
    });

    group('LoadPurchasesEvent', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'emits [PurchaseLoading, PurchasesLoaded] when successful',
        build: () {
          fakeRepository.allPurchasesResponse = Right([
            PurchaseTestFactory.createPurchase(),
          ]);
          return PurchaseBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const LoadPurchasesEvent()),
        expect: () => [isA<PurchaseLoading>(), isA<PurchasesLoaded>()],
        verify: (_) {
          expect(fakeRepository.getAllPurchasesCalled, true);
        },
      );

      blocTest<PurchaseBloc, PurchaseState>(
        'emits [PurchaseLoading, PurchaseError] when fails',
        build: () {
          fakeRepository.allPurchasesResponse = const Left(
            PurchaseDatabaseFailure('Database error'),
          );
          return PurchaseBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const LoadPurchasesEvent()),
        expect: () => [isA<PurchaseLoading>(), isA<PurchaseError>()],
      );
    });

    group('CreatePurchaseEvent', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'emits [PurchaseLoading, PurchaseCreated, ...] when successful',
        build: () {
          final purchase = PurchaseTestFactory.createPurchase();
          fakeRepository.createResponse = Right(purchase);
          fakeRepository.allPurchasesResponse = Right([purchase]);
          return PurchaseBloc(fakeRepository);
        },
        act: (bloc) =>
            bloc.add(CreatePurchaseEvent(PurchaseTestFactory.createPurchase())),
        expect: () => [
          isA<PurchaseLoading>(),
          isA<PurchaseCreated>(),
          isA<PurchaseLoading>(), // From reload
          isA<PurchasesLoaded>(),
        ],
        verify: (_) {
          expect(fakeRepository.createPurchaseCalled, true);
          expect(fakeRepository.lastCreatedPurchase, isNotNull);
        },
      );

      blocTest<PurchaseBloc, PurchaseState>(
        'emits [PurchaseLoading, PurchaseError] when fails with validation error',
        build: () {
          fakeRepository.createResponse = const Left(EmptyItemsFailure());
          return PurchaseBloc(fakeRepository);
        },
        act: (bloc) =>
            bloc.add(CreatePurchaseEvent(PurchaseTestFactory.createPurchase())),
        expect: () => [isA<PurchaseLoading>(), isA<PurchaseError>()],
      );
    });

    group('DeletePurchaseEvent', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'emits [PurchaseLoading, PurchaseDeleted, ...] when successful',
        build: () {
          fakeRepository.deleteResponse = const Right(null);
          return PurchaseBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const DeletePurchaseEvent('test-uuid')),
        expect: () => [
          isA<PurchaseLoading>(),
          isA<PurchaseDeleted>(),
          isA<PurchaseLoading>(), // From reload
          isA<PurchasesLoaded>(),
        ],
        verify: (_) {
          expect(fakeRepository.deletePurchaseCalled, true);
          expect(fakeRepository.lastDeletedUuid, 'test-uuid');
        },
      );

      blocTest<PurchaseBloc, PurchaseState>(
        'emits [PurchaseLoading, PurchaseError] when purchase not found',
        build: () {
          fakeRepository.deleteResponse = const Left(PurchaseNotFoundFailure());
          return PurchaseBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const DeletePurchaseEvent('non-existent')),
        expect: () => [isA<PurchaseLoading>(), isA<PurchaseError>()],
      );
    });

    group('UpdatePurchaseEvent', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'emits [PurchaseLoading, PurchaseUpdated, ...] when successful',
        build: () {
          final purchase = PurchaseTestFactory.createPurchase();
          fakeRepository.updateResponse = Right(purchase);
          fakeRepository.allPurchasesResponse = Right([purchase]);
          return PurchaseBloc(fakeRepository);
        },
        act: (bloc) =>
            bloc.add(UpdatePurchaseEvent(PurchaseTestFactory.createPurchase())),
        expect: () => [
          isA<PurchaseLoading>(),
          isA<PurchaseUpdated>(),
          isA<PurchaseLoading>(), // From reload
          isA<PurchasesLoaded>(),
        ],
        verify: (_) {
          expect(fakeRepository.updatePurchaseCalled, true);
        },
      );
    });

    group('LoadPurchaseDetailsEvent', () {
      blocTest<PurchaseBloc, PurchaseState>(
        'emits [PurchaseLoading, PurchaseDetailsLoaded] when successful',
        build: () {
          fakeRepository.getPurchaseResponse = Right(
            PurchaseTestFactory.createPurchase(),
          );
          return PurchaseBloc(fakeRepository);
        },
        act: (bloc) => bloc.add(const LoadPurchaseDetailsEvent('test-uuid')),
        expect: () => [isA<PurchaseLoading>(), isA<PurchaseDetailsLoaded>()],
        verify: (_) {
          expect(fakeRepository.getPurchaseByUuidCalled, true);
        },
      );
    });
  });
}
