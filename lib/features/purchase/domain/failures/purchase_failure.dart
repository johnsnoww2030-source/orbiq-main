import 'package:equatable/equatable.dart';

/// Base failure class for Purchase feature
/// Follows the pattern from ProductFailure
abstract class PurchaseFailure extends Equatable {
  final String message;

  const PurchaseFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when a database operation fails
class PurchaseDatabaseFailure extends PurchaseFailure {
  const PurchaseDatabaseFailure([super.message = 'خطا در عملیات دیتابیس']);
}

/// Failure when purchase is not found
class PurchaseNotFoundFailure extends PurchaseFailure {
  const PurchaseNotFoundFailure([super.message = 'خرید مورد نظر یافت نشد']);
}

/// Failure for validation errors
class PurchaseValidationFailure extends PurchaseFailure {
  const PurchaseValidationFailure([super.message = 'اطلاعات خرید نامعتبر است']);
}

/// Failure when stock rollback fails during purchase deletion
class StockRollbackFailure extends PurchaseFailure {
  const StockRollbackFailure([super.message = 'خطا در بازگردانی موجودی']);
}

/// Failure when items are empty or invalid
class EmptyItemsFailure extends PurchaseFailure {
  const EmptyItemsFailure([super.message = 'لیست اقلام خرید خالی است']);
}
