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
  int _limit = 20;

  PaymentBloc({
    required SavePayment savePayment,
    required GetPaymentsByUserIdAndNickname getPaymentsByUserIdAndNickname,
    required GetAllPaymentsUseCase getAllPaymentsUseCase,
  }) : _savePayment = savePayment,
       _getPaymentsByUserIdAndNickname = getPaymentsByUserIdAndNickname,
       _getAllPaymentsUseCase = getAllPaymentsUseCase,
       super(const PaymentState.initial()) {
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
    emit(const PaymentState.loading());
    final result = await _savePayment(event.payment);
    result.fold(
      (failure) => emit(PaymentState.failure(failure.message)),
      (_) => emit(const PaymentState.success()),
    );
  }

  Future<void> _onGetPaymentsByUserIdAndNicknameEvent(
    GetPaymentsByUserIdAndNicknameEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentState.loading());
    final result = await _getPaymentsByUserIdAndNickname(
      event.userId,
      event.nickname,
    );
    result.fold(
      (failure) => emit(PaymentState.failure(failure.message)),
      (payments) => emit(
        PaymentState.listLoaded(
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
    emit(const PaymentState.loading());
    _currentPage = event.page < 1 ? 1 : event.page;
    _limit = event.limit;

    final params = GetAllPaymentsUseCaseParams(
      page: _currentPage,
      limit: _limit,
    );
    final result = await _getAllPaymentsUseCase(params);

    result.fold(
      (failure) => emit(PaymentState.failure(failure.message)),
      (paginatedData) => emit(
        PaymentState.listLoaded(
          payments: paginatedData.payments,
          currentPage: paginatedData.currentPage,
          totalPages: paginatedData.totalPages,
          hasNextPage: paginatedData.currentPage < paginatedData.totalPages,
        ),
      ),
    );
  }

  Future<void> _onLoadPaymentPageEvent(
    LoadPaymentPageEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentState.loadingPage());
    _currentPage = event.page < 1 ? 1 : event.page;

    final params = GetAllPaymentsUseCaseParams(
      page: _currentPage,
      limit: _limit,
    );
    final result = await _getAllPaymentsUseCase(params);

    result.fold(
      (failure) => emit(PaymentState.failure(failure.message)),
      (paginatedData) => emit(
        PaymentState.listLoaded(
          payments: paginatedData.payments,
          currentPage: paginatedData.currentPage,
          totalPages: paginatedData.totalPages,
          hasNextPage: paginatedData.currentPage < paginatedData.totalPages,
        ),
      ),
    );
  }
}
