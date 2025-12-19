import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/events/event_bus.dart';
import '../../domain/events/rate_events.dart';
import '../../domain/usecases/get_current_rate_usecase.dart';
import '../../domain/usecases/get_rate_history_usecase.dart';
import '../../domain/usecases/add_rate_event_usecase.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import 'exchange_rate_event.dart';
import 'exchange_rate_state.dart';

/// BLoC for managing exchange rates
/// Handles loading, adding, and watching exchange rates
class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  final GetCurrentRateUseCase getCurrentRateUseCase;
  final GetRateHistoryUseCase getRateHistoryUseCase;
  final AddRateEventUseCase addRateEventUseCase;
  final ExchangeRateRepository repository;
  final EventBus eventBus;

  // Cache previous rates for change detection
  final Map<String, double> _previousRates = {};

  ExchangeRateBloc({
    required this.getCurrentRateUseCase,
    required this.getRateHistoryUseCase,
    required this.addRateEventUseCase,
    required this.repository,
    required this.eventBus,
  }) : super(const ExchangeRateInitial()) {
    on<LoadCurrentRatesEvent>(_onLoadCurrentRates);
    on<LoadRateHistoryEvent>(_onLoadRateHistory);
    on<AddExchangeRateEvent>(_onAddExchangeRate);
    on<RefreshRatesEvent>(_onRefreshRates);
  }

  /// Load current rates for all tracked currencies
  Future<void> _onLoadCurrentRates(
    LoadCurrentRatesEvent event,
    Emitter<ExchangeRateState> emit,
  ) async {
    emit(const ExchangeRateLoading());

    final result = await repository.getAllCurrentRates(event.currencyCodes);

    result.fold(
      (failure) => emit(ExchangeRateError(message: failure.message)),
      (rates) {
        // Update previous rates cache
        rates.forEach((code, rate) {
          _previousRates[code] = rate.rate;
        });

        emit(
          ExchangeRatesLoaded(currentRates: rates, loadedAt: DateTime.now()),
        );
      },
    );
  }

  /// Load rate history for a specific currency
  Future<void> _onLoadRateHistory(
    LoadRateHistoryEvent event,
    Emitter<ExchangeRateState> emit,
  ) async {
    emit(const ExchangeRateLoading());

    final params = GetRateHistoryParams(
      currencyCode: event.currencyCode,
      fromDate: event.fromDate,
      toDate: event.toDate,
    );

    final result = await getRateHistoryUseCase(params);

    result.fold(
      (failure) => emit(ExchangeRateError(message: failure.message)),
      (history) => emit(
        RateHistoryLoaded(
          currencyCode: event.currencyCode,
          history: history,
          fromDate:
              event.fromDate ??
              DateTime.now().subtract(const Duration(days: 30)),
          toDate: event.toDate ?? DateTime.now(),
        ),
      ),
    );
  }

  /// Add a new exchange rate
  Future<void> _onAddExchangeRate(
    AddExchangeRateEvent event,
    Emitter<ExchangeRateState> emit,
  ) async {
    emit(const ExchangeRateLoading());

    // No more blocking for significant changes - just save the rate
    // The UI will show a notification but won't prevent saving
    await _saveRate(event, emit);
  }

  /// Actually save the rate (after confirmation if needed)
  Future<void> _saveRate(
    AddExchangeRateEvent event,
    Emitter<ExchangeRateState> emit,
  ) async {
    // Get current user UUID (should come from auth)
    const recordedBy = 'current-user-uuid'; // TODO: Get from AuthBloc

    final params = AddRateEventParams(
      currencyCode: event.currencyCode,
      rate: event.rate,
      source: event.source,
      recordedBy: recordedBy,
      confidence: event.confidence,
      notes: event.notes,
    );

    final result = await addRateEventUseCase(params);

    result.fold(
      (failure) => emit(ExchangeRateError(message: failure.message)),
      (rate) {
        // Get previous rate for event
        final previousRate = _previousRates[event.currencyCode] ?? 0;

        // Update cache
        _previousRates[event.currencyCode] = rate.rate;

        final hasSignificantChange =
            previousRate > 0 &&
            ((rate.rate - previousRate) / previousRate).abs() > 0.05;

        emit(
          ExchangeRateAdded(
            rate: rate,
            hasSignificantChange: hasSignificantChange,
          ),
        );

        // Fire domain event for other BLoCs to react
        eventBus.fire(
          ExchangeRateUpdatedEvent(
            currencyCode: event.currencyCode,
            previousRate: previousRate,
            newRate: rate.rate,
            source: event.source,
          ),
        );
      },
    );
  }

  /// Refresh rates from repository
  Future<void> _onRefreshRates(
    RefreshRatesEvent event,
    Emitter<ExchangeRateState> emit,
  ) async {
    // Get default tracked currencies
    const defaultCurrencies = ['USD', 'EUR', 'AED'];
    add(LoadCurrentRatesEvent(defaultCurrencies));
  }

  /// Get current rate for a currency (sync, from cache)
  double? getCurrentRate(String currencyCode) => _previousRates[currencyCode];
}
