import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/pricing_settings.dart';
import '../../domain/repositories/pricing_repository.dart';
import 'pricing_settings_event.dart';
import 'pricing_settings_state.dart';

/// BLoC for managing pricing settings
class PricingSettingsBloc
    extends Bloc<PricingSettingsEvent, PricingSettingsState> {
  final PricingRepository repository;

  PricingSettings? _currentSettings;

  PricingSettingsBloc({required this.repository})
    : super(const PricingSettingsInitial()) {
    on<LoadPricingSettingsEvent>(_onLoadSettings);
    on<UpdatePricingSettingsEvent>(_onUpdateSettings);
    on<CalculatePricesEvent>(_onCalculatePrices);
    on<ValidatePriceEvent>(_onValidatePrice);
  }

  /// Get current settings (sync)
  PricingSettings? get currentSettings => _currentSettings;

  /// Load pricing settings
  Future<void> _onLoadSettings(
    LoadPricingSettingsEvent event,
    Emitter<PricingSettingsState> emit,
  ) async {
    emit(const PricingSettingsLoading());

    final result = await repository.getSettings();

    result.fold((failure) => emit(PricingSettingsError(failure.message)), (
      settings,
    ) {
      _currentSettings = settings;
      emit(PricingSettingsLoaded(settings));
    });
  }

  /// Update pricing settings
  Future<void> _onUpdateSettings(
    UpdatePricingSettingsEvent event,
    Emitter<PricingSettingsState> emit,
  ) async {
    emit(const PricingSettingsLoading());

    final newSettings = PricingSettings(
      minProfitMargin: event.minProfitMargin,
      defaultProfitMargin: event.defaultProfitMargin,
      maxProfitMargin: event.maxProfitMargin,
      baseCurrency: _currentSettings?.baseCurrency ?? 'IRR',
      trackCurrencies: event.trackCurrencies,
      roundingStep: event.roundingStep,
      // Note: User tracking requires integration with user session management
      updatedBy: 'system',
    );

    final result = await repository.saveSettings(newSettings);

    result.fold((failure) => emit(PricingSettingsError(failure.message)), (
      savedSettings,
    ) {
      _currentSettings = savedSettings;
      emit(PricingSettingsUpdated(savedSettings));
    });
  }

  /// Calculate prices for a product
  void _onCalculatePrices(
    CalculatePricesEvent event,
    Emitter<PricingSettingsState> emit,
  ) {
    // Convert to base currency if needed
    double costInBaseCurrency = event.costPrice;
    if (event.exchangeRate != null && event.exchangeRate! > 0) {
      costInBaseCurrency = event.costPrice * event.exchangeRate!;
    }

    final result = repository.calculatePrices(
      costPrice: costInBaseCurrency,
      settings: _currentSettings,
    );

    result.fold(
      (failure) => emit(PricingSettingsError(failure.message)),
      (priceRange) => emit(
        PricesCalculated(
          priceRange: priceRange,
          costPrice: event.costPrice,
          currencyCode: event.currencyCode,
          exchangeRate: event.exchangeRate,
        ),
      ),
    );
  }

  /// Validate a selling price
  void _onValidatePrice(
    ValidatePriceEvent event,
    Emitter<PricingSettingsState> emit,
  ) {
    final result = repository.validateSellingPrice(
      sellingPrice: event.sellingPrice,
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
    );

    emit(
      PriceValidated(
        result: result,
        sellingPrice: event.sellingPrice,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        requiresPin: result == PriceValidationResult.belowMinimum,
      ),
    );
  }

  /// Calculate prices synchronously (helper method)
  double roundPrice(double price) {
    return repository.roundPrice(price);
  }
}
