import 'package:equatable/equatable.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';

/// Base event for SalesBloc
abstract class SalesEvent extends Equatable {
  const SalesEvent();

  @override
  List<Object?> get props => [];
}

/// Load all sales
class LoadSalesEvent extends SalesEvent {
  const LoadSalesEvent();
}

/// Watch sales (reactive)
class WatchSalesEvent extends SalesEvent {
  const WatchSalesEvent();
}

/// Create a new sale
class CreateSaleEvent extends SalesEvent {
  final SalesEntity sale;

  const CreateSaleEvent(this.sale);

  @override
  List<Object?> get props => [sale];
}

/// Delete a sale
class DeleteSaleEvent extends SalesEvent {
  final String uuid;

  const DeleteSaleEvent(this.uuid);

  @override
  List<Object?> get props => [uuid];
}

/// Load sale details
class LoadSaleDetailsEvent extends SalesEvent {
  final String uuid;

  const LoadSaleDetailsEvent(this.uuid);

  @override
  List<Object?> get props => [uuid];
}

/// Get today's sales
class LoadTodaySalesEvent extends SalesEvent {
  const LoadTodaySalesEvent();
}
