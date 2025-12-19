import 'package:orbiq/core/events/domain_event.dart';

/// Event fired when a purchase is completed
class PurchaseCompletedEvent extends DomainEvent {
  final String invoiceUuid;
  final double totalAmount;
  final double exchangeRateAtPurchase;
  final List<String> itemUuids;
  final int itemCount;
  final String? supplierInfo;

  PurchaseCompletedEvent({
    required this.invoiceUuid,
    required this.totalAmount,
    required this.exchangeRateAtPurchase,
    required this.itemUuids,
    required this.itemCount,
    this.supplierInfo,
    super.correlationId,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    invoiceUuid,
    totalAmount,
    exchangeRateAtPurchase,
    itemUuids,
    itemCount,
    supplierInfo,
  ];
}

/// Event fired when a purchase item is returned to supplier
class PurchaseReturnedEvent extends DomainEvent {
  final String invoiceUuid;
  final List<String> returnedItemUuids;
  final double returnAmount;
  final String reason;

  PurchaseReturnedEvent({
    required this.invoiceUuid,
    required this.returnedItemUuids,
    required this.returnAmount,
    required this.reason,
    super.correlationId,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    invoiceUuid,
    returnedItemUuids,
    returnAmount,
    reason,
  ];
}
