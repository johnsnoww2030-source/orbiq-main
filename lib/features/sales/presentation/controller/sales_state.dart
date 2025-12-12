import 'package:equatable/equatable.dart';
import 'package:orbiq/features/sales/domain/entities/sales_entity.dart';

/// Base state for SalesBloc
abstract class SalesState extends Equatable {
  const SalesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class SalesInitial extends SalesState {
  const SalesInitial();
}

/// Loading state
class SalesLoading extends SalesState {
  const SalesLoading();
}

/// Loaded state with sales list
class SalesLoaded extends SalesState {
  final List<SalesEntity> sales;
  final double totalRevenue;
  final double totalProfit;

  const SalesLoaded({
    required this.sales,
    this.totalRevenue = 0.0,
    this.totalProfit = 0.0,
  });

  @override
  List<Object?> get props => [sales, totalRevenue, totalProfit];
}

/// Sale details loaded
class SalesDetailsLoaded extends SalesState {
  final SalesEntity sale;

  const SalesDetailsLoaded(this.sale);

  @override
  List<Object?> get props => [sale];
}

/// Sale created successfully
class SaleCreated extends SalesState {
  final SalesEntity sale;

  const SaleCreated(this.sale);

  @override
  List<Object?> get props => [sale];
}

/// Sale deleted successfully
class SaleDeleted extends SalesState {
  const SaleDeleted();
}

/// Error state
class SalesError extends SalesState {
  final String message;

  const SalesError(this.message);

  @override
  List<Object?> get props => [message];
}
