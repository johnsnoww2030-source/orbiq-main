import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrencySettings extends CurrencyEvent {}

class ChangeCurrency extends CurrencyEvent {
  final CurrencyCode currency;

  const ChangeCurrency(this.currency);

  @override
  List<Object> get props => [currency];
}

class UpdateCurrencyRates extends CurrencyEvent {
  final Map<CurrencyCode, double> rates;

  const UpdateCurrencyRates(this.rates);

  @override
  List<Object> get props => [rates];
}
