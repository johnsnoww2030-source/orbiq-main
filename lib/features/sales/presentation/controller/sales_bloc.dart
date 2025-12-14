import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/sales/domain/repositories/sales_repository.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_event.dart';
import 'package:orbiq/features/sales/presentation/controller/sales_state.dart';

/// BLoC for managing sales operations
@injectable
class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final SalesRepository _repository;
  StreamSubscription? _salesSubscription;

  SalesBloc(this._repository) : super(const SalesInitial()) {
    on<LoadSalesEvent>(_onLoadSales);
    on<WatchSalesEvent>(_onWatchSales);
    on<CreateSaleEvent>(_onCreateSale);
    on<DeleteSaleEvent>(_onDeleteSale);
    on<LoadSaleDetailsEvent>(_onLoadSaleDetails);
    on<LoadTodaySalesEvent>(_onLoadTodaySales);
  }

  Future<void> _onLoadSales(
    LoadSalesEvent event,
    Emitter<SalesState> emit,
  ) async {
    emit(const SalesLoading());

    final result = await _repository.getAllSales();

    await result.fold((failure) async => emit(SalesError(failure.message)), (
      sales,
    ) async {
      final revenueResult = await _repository.getTotalRevenue();
      final profitResult = await _repository.getTotalProfit();

      double revenue = 0.0;
      double profit = 0.0;

      revenueResult.fold((e) => null, (r) => revenue = r);
      profitResult.fold((e) => null, (p) => profit = p);

      emit(
        SalesLoaded(sales: sales, totalRevenue: revenue, totalProfit: profit),
      );
    });
  }

  void _onWatchSales(WatchSalesEvent event, Emitter<SalesState> emit) {
    _salesSubscription?.cancel();
    _salesSubscription = _repository.watchAllSales().listen((sales) {
      add(const LoadSalesEvent());
    });
  }

  Future<void> _onCreateSale(
    CreateSaleEvent event,
    Emitter<SalesState> emit,
  ) async {
    emit(const SalesLoading());

    final result = await _repository.createSale(event.sale);
    result.fold(
      (failure) => emit(SalesError(failure.message)),
      (sale) => emit(SaleCreated(sale)),
    );
  }

  Future<void> _onDeleteSale(
    DeleteSaleEvent event,
    Emitter<SalesState> emit,
  ) async {
    emit(const SalesLoading());

    final result = await _repository.deleteSale(event.uuid);
    result.fold(
      (failure) => emit(SalesError(failure.message)),
      (_) => emit(const SaleDeleted()),
    );
  }

  Future<void> _onLoadSaleDetails(
    LoadSaleDetailsEvent event,
    Emitter<SalesState> emit,
  ) async {
    emit(const SalesLoading());

    final result = await _repository.getSalesByUuid(event.uuid);
    result.fold(
      (failure) => emit(SalesError(failure.message)),
      (sale) => emit(SalesDetailsLoaded(sale)),
    );
  }

  Future<void> _onLoadTodaySales(
    LoadTodaySalesEvent event,
    Emitter<SalesState> emit,
  ) async {
    emit(const SalesLoading());

    final result = await _repository.getTodaySales();
    result.fold((failure) => emit(SalesError(failure.message)), (sales) async {
      double revenue = 0.0;
      double profit = 0.0;

      for (final sale in sales) {
        revenue += sale.totalAmount;
        profit += sale.totalProfit;
      }

      emit(
        SalesLoaded(sales: sales, totalRevenue: revenue, totalProfit: profit),
      );
    });
  }

  @override
  Future<void> close() {
    _salesSubscription?.cancel();
    return super.close();
  }
}
