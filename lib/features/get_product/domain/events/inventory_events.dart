import 'package:orbiq/core/events/domain_event.dart';

/// Event fired when inventory changes
class InventoryChangedEvent extends DomainEvent {
  final String productUuid;
  final String productName;
  final int previousQuantity;
  final int newQuantity;
  final String reason; // 'sale', 'purchase', 'adjustment', 'return'
  final String? referenceUuid; // Invoice UUID if applicable

  InventoryChangedEvent({
    required this.productUuid,
    required this.productName,
    required this.previousQuantity,
    required this.newQuantity,
    required this.reason,
    this.referenceUuid,
    super.correlationId,
  });

  /// Quantity change (positive = increase, negative = decrease)
  int get quantityChange => newQuantity - previousQuantity;

  @override
  List<Object?> get props => [
    ...super.props,
    productUuid,
    productName,
    previousQuantity,
    newQuantity,
    reason,
    referenceUuid,
  ];
}

/// Event fired when stock falls below threshold
class LowStockAlertEvent extends DomainEvent {
  final String productUuid;
  final String productName;
  final int currentQuantity;
  final int threshold;

  LowStockAlertEvent({
    required this.productUuid,
    required this.productName,
    required this.currentQuantity,
    required this.threshold,
    super.correlationId,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    productUuid,
    productName,
    currentQuantity,
    threshold,
  ];
}

/// Event fired when stock is depleted
class OutOfStockEvent extends DomainEvent {
  final String productUuid;
  final String productName;

  OutOfStockEvent({
    required this.productUuid,
    required this.productName,
    super.correlationId,
  });

  @override
  List<Object?> get props => [...super.props, productUuid, productName];
}
