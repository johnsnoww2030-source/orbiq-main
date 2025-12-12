import 'package:equatable/equatable.dart';
import 'package:orbiq/features/purchase/domain/entities/purchase_entity.dart';

/// States for PurchaseBloc
abstract class PurchaseState extends Equatable {
  const PurchaseState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PurchaseInitial extends PurchaseState {
  const PurchaseInitial();
}

/// Loading state
class PurchaseLoading extends PurchaseState {
  const PurchaseLoading();
}

/// Loaded state with list of purchases
class PurchasesLoaded extends PurchaseState {
  final List<PurchaseEntity> purchases;

  const PurchasesLoaded(this.purchases);

  @override
  List<Object?> get props => [purchases];
}

/// Single purchase details loaded
class PurchaseDetailsLoaded extends PurchaseState {
  final PurchaseEntity purchase;

  const PurchaseDetailsLoaded(this.purchase);

  @override
  List<Object?> get props => [purchase];
}

/// Purchase created successfully
class PurchaseCreated extends PurchaseState {
  final PurchaseEntity purchase;

  const PurchaseCreated(this.purchase);

  @override
  List<Object?> get props => [purchase];
}

/// Purchase deleted successfully
class PurchaseDeleted extends PurchaseState {
  const PurchaseDeleted();
}

/// Error state
class PurchaseError extends PurchaseState {
  final String message;

  const PurchaseError(this.message);

  @override
  List<Object?> get props => [message];
}
