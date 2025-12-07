import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object> get props => [];
}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final CurrencyCode selectedCurrency;
  final Map<CurrencyCode, double> rates;

  const CurrencyLoaded({required this.selectedCurrency, required this.rates});

  @override
  List<Object> get props => [selectedCurrency, rates];
}

class CurrencyError extends CurrencyState {
  final String message;

  const CurrencyError(this.message);

  @override
  List<Object> get props => [message];
}
