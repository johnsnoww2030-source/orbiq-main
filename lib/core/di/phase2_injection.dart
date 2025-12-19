import 'package:get_it/get_it.dart';
import 'package:orbiq/core/database/app_database.dart';

// Event Bus
import 'package:orbiq/core/events/event_bus.dart';

// Exchange Rate Module
import 'package:orbiq/features/exchange_rate/data/repositories/exchange_rate_repository_impl.dart';
import 'package:orbiq/features/exchange_rate/domain/repositories/exchange_rate_repository.dart';
import 'package:orbiq/features/exchange_rate/domain/usecases/get_current_rate_usecase.dart';
import 'package:orbiq/features/exchange_rate/domain/usecases/get_rate_history_usecase.dart';
import 'package:orbiq/features/exchange_rate/domain/usecases/add_rate_event_usecase.dart';
import 'package:orbiq/features/exchange_rate/presentation/bloc/exchange_rate_bloc.dart';

// Pricing Module
import 'package:orbiq/features/pricing/data/repositories/pricing_repository_impl.dart';
import 'package:orbiq/features/pricing/domain/repositories/pricing_repository.dart';
import 'package:orbiq/features/pricing/presentation/bloc/pricing_settings_bloc.dart';

// Profit Module
import 'package:orbiq/features/profit/data/repositories/profit_repository_impl.dart';
import 'package:orbiq/features/profit/domain/repositories/profit_repository.dart';
import 'package:orbiq/features/profit/domain/services/profit_calculator.dart';
import 'package:orbiq/features/profit/domain/usecases/get_profit_summary_usecase.dart';
import 'package:orbiq/features/profit/domain/usecases/get_daily_profits_usecase.dart';
import 'package:orbiq/features/profit/presentation/bloc/profit_report_bloc.dart';

/// Register Phase 2 dependencies
/// Call this after main injection configuration
void registerPhase2Dependencies(GetIt getIt) {
  // === Event Bus (Singleton) ===
  getIt.registerLazySingleton<EventBus>(() => EventBus());

  // === Exchange Rate Module ===

  // Repository
  getIt.registerLazySingleton<ExchangeRateRepository>(
    () => ExchangeRateRepositoryImpl(getIt<AppDatabase>().exchangeRateDao),
  );

  // Use Cases
  getIt.registerFactory(
    () => GetCurrentRateUseCase(getIt<ExchangeRateRepository>()),
  );
  getIt.registerFactory(
    () => GetRateHistoryUseCase(getIt<ExchangeRateRepository>()),
  );
  getIt.registerFactory(
    () => AddRateEventUseCase(getIt<ExchangeRateRepository>()),
  );

  // BLoC
  getIt.registerFactory(
    () => ExchangeRateBloc(
      getCurrentRateUseCase: getIt<GetCurrentRateUseCase>(),
      getRateHistoryUseCase: getIt<GetRateHistoryUseCase>(),
      addRateEventUseCase: getIt<AddRateEventUseCase>(),
      repository: getIt<ExchangeRateRepository>(),
      eventBus: getIt<EventBus>(),
    ),
  );

  // === Pricing Module ===

  // Repository
  getIt.registerLazySingleton<PricingRepository>(
    () => PricingRepositoryImpl(getIt<AppDatabase>().pricingSettingsDao),
  );

  // BLoC
  getIt.registerFactory(
    () => PricingSettingsBloc(repository: getIt<PricingRepository>()),
  );

  // === Profit Module ===

  // Calculator (pure functions, singleton)
  getIt.registerLazySingleton(() => ProfitCalculator());

  // Repository
  getIt.registerLazySingleton<ProfitRepository>(
    () => ProfitRepositoryImpl(
      salesDao: getIt<AppDatabase>().salesDao,
      exchangeRateRepository: getIt<ExchangeRateRepository>(),
      calculator: getIt<ProfitCalculator>(),
    ),
  );

  // Use Cases
  getIt.registerFactory(
    () => GetProfitSummaryUseCase(getIt<ProfitRepository>()),
  );
  getIt.registerFactory(
    () => GetDailyProfitsUseCase(getIt<ProfitRepository>()),
  );

  // BLoC
  getIt.registerFactory(
    () => ProfitReportBloc(
      repository: getIt<ProfitRepository>(),
      calculator: getIt<ProfitCalculator>(),
      getProfitSummaryUseCase: getIt<GetProfitSummaryUseCase>(),
      getDailyProfitsUseCase: getIt<GetDailyProfitsUseCase>(),
      eventBus: getIt<EventBus>(),
    ),
  );
}
