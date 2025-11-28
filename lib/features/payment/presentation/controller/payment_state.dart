import 'package:equatable/equatable.dart';
import 'package:orbiq/features/payment/domain/entities/payment_entity.dart';

abstract class PaymentState extends Equatable {
  const PaymentState(); // Added const constructor

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial(); // Added const constructor
}

class PaymentLoading extends PaymentState {
  const PaymentLoading(); // Added const constructor
}

class PaymentLoadingPage extends PaymentState { // New state for loading next page
  const PaymentLoadingPage();
}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess(); // Added const constructor
}

class PaymentFailure extends PaymentState {
  final String message;

  const PaymentFailure(this.message); // Added const constructor

  @override
  List<Object> get props => [message];
}

class PaymentListLoaded extends PaymentState {
  final List<PaymentEntity> payments;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;

  const PaymentListLoaded({
    required this.payments,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
  });

  @override
  List<Object> get props => [payments, currentPage, totalPages, hasNextPage];
}
