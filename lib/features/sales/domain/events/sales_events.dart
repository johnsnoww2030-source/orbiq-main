import 'package:orbiq/core/events/domain_event.dart';

/// Event fired when a sale is completed
class SaleCompletedEvent extends DomainEvent {
  final String invoiceUuid;
  final double totalAmount;
  final double totalProfit;
  final double exchangeRateAtSale;
  final List<String> itemUuids;
  final int itemCount;
  final String? customerInfo;

  SaleCompletedEvent({
    required this.invoiceUuid,
    required this.totalAmount,
    required this.totalProfit,
    required this.exchangeRateAtSale,
    required this.itemUuids,
    required this.itemCount,
    this.customerInfo,
    super.correlationId,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    invoiceUuid,
    totalAmount,
    totalProfit,
    exchangeRateAtSale,
    itemUuids,
    itemCount,
    customerInfo,
  ];
}

/// Event fired when a sale is voided/cancelled
class SaleVoidedEvent extends DomainEvent {
  final String invoiceUuid;
  final String reason;
  final double refundedAmount;
  final List<String> refundedItemUuids;

  SaleVoidedEvent({
    required this.invoiceUuid,
    required this.reason,
    required this.refundedAmount,
    required this.refundedItemUuids,
    super.correlationId,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    invoiceUuid,
    reason,
    refundedAmount,
    refundedItemUuids,
  ];
}

/// Event fired when a sale item is returned
class SaleItemReturnedEvent extends DomainEvent {
  final String invoiceUuid;
  final String itemUuid;
  final int quantity;
  final double refundAmount;
  final String reason;

  SaleItemReturnedEvent({
    required this.invoiceUuid,
    required this.itemUuid,
    required this.quantity,
    required this.refundAmount,
    required this.reason,
    super.correlationId,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    invoiceUuid,
    itemUuid,
    quantity,
    refundAmount,
    reason,
  ];
}
