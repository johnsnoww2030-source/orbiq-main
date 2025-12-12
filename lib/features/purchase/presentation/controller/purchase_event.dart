import 'package:equatable/equatable.dart';
import 'package:orbiq/features/purchase/domain/entities/purchase_entity.dart';

/// Events for PurchaseBloc
abstract class PurchaseEvent extends Equatable {
  const PurchaseEvent();

  @override
  List<Object?> get props => [];
}

/// Load all purchases
class LoadPurchasesEvent extends PurchaseEvent {
  const LoadPurchasesEvent();
}

/// Watch purchases (reactive stream)
class WatchPurchasesEvent extends PurchaseEvent {
  const WatchPurchasesEvent();
}

/// Create a new purchase
class CreatePurchaseEvent extends PurchaseEvent {
  final PurchaseEntity purchase;

  const CreatePurchaseEvent(this.purchase);

  @override
  List<Object?> get props => [purchase];
}

/// Delete a purchase
class DeletePurchaseEvent extends PurchaseEvent {
  final String purchaseUuid;

  const DeletePurchaseEvent(this.purchaseUuid);

  @override
  List<Object?> get props => [purchaseUuid];
}

/// Get purchase details
class LoadPurchaseDetailsEvent extends PurchaseEvent {
  final String purchaseUuid;

  const LoadPurchaseDetailsEvent(this.purchaseUuid);

  @override
  List<Object?> get props => [purchaseUuid];
}
