import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/payment/domain/usecases/get_all_payments_usecase.dart';
import 'package:orbiq/features/payment/domain/usecases/get_payment_by_nickname_usecase.dart';
import 'package:orbiq/features/payment/domain/usecases/save_payment_usecase.dart';
import 'package:orbiq/features/payment/presentation/controller/payment_event.dart';
import 'package:orbiq/features/payment/presentation/controller/payment_state.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final SavePayment _savePayment;
  final GetPaymentsByUserIdAndNickname _getPaymentsByUserIdAndNickname;
  final GetAllPaymentsUseCase _getAllPaymentsUseCase;

  int _currentPage = 1;
  int _limit = 20; // Default items per page

  PaymentBloc({
    required SavePayment savePayment,
    required GetPaymentsByUserIdAndNickname getPaymentsByUserIdAndNickname,
    required GetAllPaymentsUseCase getAllPaymentsUseCase,
  }) : _savePayment = savePayment,
       _getPaymentsByUserIdAndNickname = getPaymentsByUserIdAndNickname,
       _getAllPaymentsUseCase = getAllPaymentsUseCase,
       super(const PaymentInitial()) {
    on<SavePaymentEvent>(_onSavePaymentEvent);
    on<GetPaymentsByUserIdAndNicknameEvent>(
      _onGetPaymentsByUserIdAndNicknameEvent,
    );
    on<GetAllPaymentsEvent>(_onGetAllPaymentsEvent);
    on<LoadPaymentPageEvent>(_onLoadPaymentPageEvent);
  }

  Future<void> _onSavePaymentEvent(
    SavePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentLoading());
    final result = await _savePayment(event.payment);
    result.fold(
      (failure) => emit(PaymentFailure(failure.message)),
      (_) => emit(const PaymentSuccess()),
    );
  }

  Future<void> _onGetPaymentsByUserIdAndNicknameEvent(
    GetPaymentsByUserIdAndNicknameEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentLoading());
    final result = await _getPaymentsByUserIdAndNickname(
      event.userId,
      event.nickname,
    );
    result.fold(
      (failure) => emit(PaymentFailure(failure.message)),
      // This use case doesn't seem to support pagination, so it returns a simple list.
      // The state PaymentListLoaded now expects paginated data.
      // This part might need adjustment depending on how non-paginated lists should be handled.
      // For now, creating a single-page PaginatedPayments-like structure for compatibility.
      (payments) => emit(
        PaymentListLoaded(
          payments: payments,
          currentPage: 1,
          totalPages: 1,
          hasNextPage: false,
        ),
      ),
    );
  }

  Future<void> _onGetAllPaymentsEvent(
    GetAllPaymentsEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentLoading());
    _currentPage = event.page < 1 ? 1 : event.page; // Ensure page >= 1
    _limit = event.limit;

    final params = GetAllPaymentsUseCaseParams(
      page: _currentPage,
      limit: _limit,
    );
    final result = await _getAllPaymentsUseCase(params);

    result.fold((failure) => emit(PaymentFailure(failure.message)), (
      paginatedData,
    ) {
      emit(
        PaymentListLoaded(
          payments: paginatedData.payments,
          currentPage: paginatedData.currentPage,
          totalPages: paginatedData.totalPages,
          hasNextPage: paginatedData.currentPage < paginatedData.totalPages,
        ),
      );
    });
  }

  Future<void> _onLoadPaymentPageEvent(
    LoadPaymentPageEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentLoadingPage());
    _currentPage = event.page < 1 ? 1 : event.page; // Ensure page >= 1

    final params = GetAllPaymentsUseCaseParams(
      page: _currentPage,
      limit: _limit,
    );
    final result = await _getAllPaymentsUseCase(params);

    result.fold((failure) => emit(PaymentFailure(failure.message)), (
      paginatedData,
    ) {
      emit(
        PaymentListLoaded(
          payments: paginatedData.payments,
          currentPage: paginatedData.currentPage,
          totalPages: paginatedData.totalPages,
          hasNextPage: paginatedData.currentPage < paginatedData.totalPages,
        ),
      );
    });
  }
}
