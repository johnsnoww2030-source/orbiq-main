import 'package:equatable/equatable.dart';
import 'package:orbiq/features/payment/domain/entities/payment_entity.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent(); // Added const constructor

  @override
  List<Object> get props => [];
}

class SavePaymentEvent extends PaymentEvent {
  final PaymentEntity payment;

  const SavePaymentEvent(this.payment); // Added const constructor

  @override
  List<Object> get props => [payment];
}

class GetPaymentsByUserIdAndNicknameEvent extends PaymentEvent {
  final int userId;
  final String nickname;

  const GetPaymentsByUserIdAndNicknameEvent(this.userId, this.nickname); // Added const constructor

  @override
  List<Object> get props => [userId, nickname];
}

class GetAllPaymentsEvent extends PaymentEvent {
  final int page;
  final int limit;

  const GetAllPaymentsEvent({this.page = 1, this.limit = 20});

  @override
  List<Object> get props => [page, limit];
}

class LoadPaymentPageEvent extends PaymentEvent {
  final int page;

  const LoadPaymentPageEvent(this.page);

  @override
  List<Object> get props => [page];
}
