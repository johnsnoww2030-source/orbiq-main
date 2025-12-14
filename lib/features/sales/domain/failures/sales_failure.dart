import 'package:equatable/equatable.dart';

/// Base failure class for Sales feature
/// Follows the pattern from PurchaseFailure
abstract class SalesFailure extends Equatable {
  final String message;

  const SalesFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when a database operation fails
class SalesDatabaseFailure extends SalesFailure {
  const SalesDatabaseFailure([super.message = 'Database operation error']);
}

/// Failure when sale is not found
class SalesNotFoundFailure extends SalesFailure {
  const SalesNotFoundFailure([super.message = 'Sale not found']);
}

/// Failure for validation errors
class SalesValidationFailure extends SalesFailure {
  const SalesValidationFailure([super.message = 'Invalid sale data']);
}

/// Failure when stock is insufficient
class InsufficientStockFailure extends SalesFailure {
  final String productName;
  final int available;
  final int requested;

  const InsufficientStockFailure({
    required this.productName,
    required this.available,
    required this.requested,
    String message = 'Insufficient stock',
  }) : super(message);

  @override
  List<Object?> get props => [message, productName, available, requested];
}

/// Failure when product is not found during sale
class ProductNotFoundForSaleFailure extends SalesFailure {
  final String productId;

  const ProductNotFoundForSaleFailure({
    required this.productId,
    String message = 'Product not found',
  }) : super(message);

  @override
  List<Object?> get props => [message, productId];
}

/// Failure when status update fails
class SalesStatusUpdateFailure extends SalesFailure {
  const SalesStatusUpdateFailure([super.message = 'Failed to update status']);
}
