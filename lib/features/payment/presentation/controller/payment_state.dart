import 'package:equatable/equatable.dart';
import '../../domain/entities/payment_entity.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();

  @override
  List<Object?> get props => [];
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();

  @override
  List<Object?> get props => [];
}

class PaymentLoadingPage extends PaymentState {
  const PaymentLoadingPage();

  @override
  List<Object?> get props => [];
}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess();

  @override
  List<Object?> get props => [];
}

class PaymentFailure extends PaymentState {
  final String message;

  const PaymentFailure(this.message);

  @override
  List<Object?> get props => [message];
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
  List<Object?> get props => [payments, currentPage, totalPages, hasNextPage];
}
