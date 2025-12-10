import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/payment_entity.dart';

part 'payment_state.freezed.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = PaymentInitial;
  const factory PaymentState.loading() = PaymentLoading;
  const factory PaymentState.loadingPage() = PaymentLoadingPage;
  const factory PaymentState.success() = PaymentSuccess;
  const factory PaymentState.failure(String message) = PaymentFailure;
  const factory PaymentState.listLoaded({
    required List<PaymentEntity> payments,
    required int currentPage,
    required int totalPages,
    required bool hasNextPage,
  }) = PaymentListLoaded;
}
