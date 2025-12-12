import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/purchase/domain/repositories/purchase_repository.dart';
import 'purchase_event.dart';
import 'purchase_state.dart';

/// BLoC for managing Purchase states
@injectable
class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final PurchaseRepository _purchaseRepository;
  StreamSubscription? _purchasesSubscription;

  PurchaseBloc(this._purchaseRepository) : super(const PurchaseInitial()) {
    on<LoadPurchasesEvent>(_onLoadPurchases);
    on<WatchPurchasesEvent>(_onWatchPurchases);
    on<CreatePurchaseEvent>(_onCreatePurchase);
    on<DeletePurchaseEvent>(_onDeletePurchase);
    on<LoadPurchaseDetailsEvent>(_onLoadPurchaseDetails);
  }

  Future<void> _onLoadPurchases(
    LoadPurchasesEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(const PurchaseLoading());

    final result = await _purchaseRepository.getAllPurchases();
    result.fold(
      (error) => emit(PurchaseError(error)),
      (purchases) => emit(PurchasesLoaded(purchases)),
    );
  }

  void _onWatchPurchases(
    WatchPurchasesEvent event,
    Emitter<PurchaseState> emit,
  ) {
    emit(const PurchaseLoading());

    _purchasesSubscription?.cancel();
    _purchasesSubscription = _purchaseRepository.watchAllPurchases().listen((
      purchases,
    ) {
      add(const LoadPurchasesEvent());
    });
  }

  Future<void> _onCreatePurchase(
    CreatePurchaseEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(const PurchaseLoading());

    final result = await _purchaseRepository.createPurchase(event.purchase);
    result.fold((error) => emit(PurchaseError(error)), (purchase) {
      emit(PurchaseCreated(purchase));
      // Reload purchases after creation
      add(const LoadPurchasesEvent());
    });
  }

  Future<void> _onDeletePurchase(
    DeletePurchaseEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(const PurchaseLoading());

    final result = await _purchaseRepository.deletePurchase(event.purchaseUuid);
    result.fold((error) => emit(PurchaseError(error)), (_) {
      emit(const PurchaseDeleted());
      // Reload purchases after deletion
      add(const LoadPurchasesEvent());
    });
  }

  Future<void> _onLoadPurchaseDetails(
    LoadPurchaseDetailsEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(const PurchaseLoading());

    final result = await _purchaseRepository.getPurchaseByUuid(
      event.purchaseUuid,
    );
    result.fold(
      (error) => emit(PurchaseError(error)),
      (purchase) => emit(PurchaseDetailsLoaded(purchase)),
    );
  }

  @override
  Future<void> close() {
    _purchasesSubscription?.cancel();
    return super.close();
  }
}
