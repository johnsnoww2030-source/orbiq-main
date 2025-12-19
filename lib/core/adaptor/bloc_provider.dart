import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/database/app_database.dart';

// Import feature-specific provider factories
import 'bloc_providers/auth_bloc_provider.dart';
import 'bloc_providers/product_bloc_provider.dart';
import 'bloc_providers/chat_bloc_provider.dart';
import 'bloc_providers/update_bloc_provider.dart';
import 'bloc_providers/export_bloc_provider.dart';
import 'bloc_providers/theme_bloc_provider.dart';
import 'bloc_providers/language_bloc_provider.dart';
import 'bloc_providers/currency_bloc_provider.dart';
import 'bloc_providers/purchase_bloc_provider.dart';
import 'bloc_providers/sales_bloc_provider.dart';
// Phase 2
import 'bloc_providers/exchange_rate_bloc_provider.dart';

List<BlocProvider> blocProviders(AppDatabase database) {
  final dio = Dio();

  // Combine all feature-specific providers
  return [
    ...authBlocProviders(database),
    ...productBlocProviders(database),
    ...chatBlocProviders(),
    ...updateBlocProviders(dio),
    ...exportBlocProviders(),
    ...themeBlocProviders(database),
    ...languageBlocProviders(database),
    ...currencyBlocProviders(),
    ...purchaseBlocProviders,
    ...salesBlocProviders,
    // Phase 2
    ...exchangeRateBlocProviders,
  ];
}
