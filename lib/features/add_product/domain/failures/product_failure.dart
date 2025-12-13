import 'package:equatable/equatable.dart';

/// Base failure class for Product feature
abstract class ProductFailure extends Equatable {
  final String message;

  const ProductFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when a database operation fails
class ProductDatabaseFailure extends ProductFailure {
  const ProductDatabaseFailure([super.message = 'Database operation failed']);
}

/// Failure when product is not found
class ProductNotFoundFailure extends ProductFailure {
  const ProductNotFoundFailure([super.message = 'Product not found']);
}

/// Failure when barcode already exists
class DuplicateBarcodeFailure extends ProductFailure {
  const DuplicateBarcodeFailure([super.message = 'Barcode already exists']);
}

/// Failure for validation errors
class ProductValidationFailure extends ProductFailure {
  const ProductValidationFailure([super.message = 'Invalid product data']);
}
