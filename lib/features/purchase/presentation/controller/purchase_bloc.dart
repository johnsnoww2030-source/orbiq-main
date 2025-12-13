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
    on<UpdatePurchaseEvent>(_onUpdatePurchase);
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
      (failure) => emit(PurchaseError(failure.message)),
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
    result.fold((failure) => emit(PurchaseError(failure.message)), (purchase) {
      emit(PurchaseCreated(purchase));
      // Reload purchases after creation
      add(const LoadPurchasesEvent());
    });
  }

  Future<void> _onUpdatePurchase(
    UpdatePurchaseEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(const PurchaseLoading());

    final result = await _purchaseRepository.updatePurchase(event.purchase);
    result.fold((failure) => emit(PurchaseError(failure.message)), (purchase) {
      emit(PurchaseUpdated(purchase));
      // Reload purchases after update
      add(const LoadPurchasesEvent());
    });
  }

  Future<void> _onDeletePurchase(
    DeletePurchaseEvent event,
    Emitter<PurchaseState> emit,
  ) async {
    emit(const PurchaseLoading());

    final result = await _purchaseRepository.deletePurchase(event.purchaseUuid);
    result.fold((failure) => emit(PurchaseError(failure.message)), (_) {
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
      (failure) => emit(PurchaseError(failure.message)),
      (purchase) => emit(PurchaseDetailsLoaded(purchase)),
    );
  }

  @override
  Future<void> close() {
    _purchasesSubscription?.cancel();
    return super.close();
  }
}
