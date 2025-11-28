import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/database/database.dart';
import 'package:orbiq/features/payment/data/repositories/payment_repositroy_impl.dart';
import 'package:orbiq/features/payment/domain/usecases/get_all_payments_usecase.dart';
import 'package:orbiq/features/payment/domain/usecases/get_payment_by_nickname_usecase.dart';
import 'package:orbiq/features/payment/domain/usecases/save_payment_usecase.dart';
import 'package:orbiq/features/payment/presentation/controller/cart_bloc.dart';
import 'package:orbiq/features/payment/presentation/controller/payment_bloc.dart';

List<BlocProvider> paymentBlocProviders(AppDatabase database) {
  // ایجاد DataSource و Repository برای مدیریت پرداخت‌ها
  final paymentDao = database.paymentDao;
  final paymentRepository = PaymentRepositoryImpl(paymentDao);

  // ایجاد UseCase ها برای پرداخت‌ها
  final savePaymentUseCase = SavePayment(paymentRepository);
  final getPaymentsByUserIdAndNicknameUseCase = GetPaymentsByUserIdAndNickname(
    paymentRepository,
  );
  final getAllPaymentsUseCase = GetAllPaymentsUseCase(
    paymentRepository,
  ); // اضافه کردن UseCase برای دریافت همه فاکتورها

  return [
    BlocProvider<CartBloc>(create: (context) => CartBloc()),
    BlocProvider<PaymentBloc>(
      create: (context) => PaymentBloc(
        savePayment: savePaymentUseCase,
        getPaymentsByUserIdAndNickname: getPaymentsByUserIdAndNicknameUseCase,
        getAllPaymentsUseCase: getAllPaymentsUseCase,
      ),
    ),
  ];
}
