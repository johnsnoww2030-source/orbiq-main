import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/features/exchange_rate/presentation/bloc/exchange_rate_bloc.dart';

/// Exchange Rate BLoC provider for Phase 2
List<BlocProvider> exchangeRateBlocProviders = [
  BlocProvider<ExchangeRateBloc>(create: (_) => getIt<ExchangeRateBloc>()),
];
