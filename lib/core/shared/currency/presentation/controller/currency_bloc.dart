import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:orbiq/core/shared/currency/domain/repositories/currency_repository.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_event.dart';
import 'package:orbiq/core/shared/currency/presentation/controller/currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository repository;

  CurrencyBloc({required this.repository}) : super(CurrencyInitial()) {
    on<LoadCurrencySettings>(_onLoadCurrencySettings);
    on<ChangeCurrency>(_onChangeCurrency);
    on<UpdateCurrencyRates>(_onUpdateCurrencyRates);
  }

  Future<void> _onLoadCurrencySettings(
    LoadCurrencySettings event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(CurrencyLoading());
    try {
      final selectedCurrency = await repository.getSelectedCurrency();
      final rates = await repository.getcurrencyRates();
      emit(CurrencyLoaded(selectedCurrency: selectedCurrency, rates: rates));
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }

  Future<void> _onChangeCurrency(
    ChangeCurrency event,
    Emitter<CurrencyState> emit,
  ) async {
    if (state is CurrencyLoaded) {
      final currentState = state as CurrencyLoaded;
      emit(CurrencyLoading());
      try {
        await repository.saveSelectedCurrency(event.currency);
        emit(
          CurrencyLoaded(
            selectedCurrency: event.currency,
            rates: currentState.rates,
          ),
        );
      } catch (e) {
        emit(CurrencyError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateCurrencyRates(
    UpdateCurrencyRates event,
    Emitter<CurrencyState> emit,
  ) async {
    if (state is CurrencyLoaded) {
      final currentState = state as CurrencyLoaded;
      emit(CurrencyLoading());
      try {
        await repository.saveCurrencyRates(event.rates);
        emit(
          CurrencyLoaded(
            selectedCurrency: currentState.selectedCurrency,
            rates: event.rates,
          ),
        );
      } catch (e) {
        emit(CurrencyError(e.toString()));
      }
    }
  }
}
