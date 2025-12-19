import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/adaptor/routes_constants.dart';
import 'package:orbiq/core/di/injection.dart';
import 'package:orbiq/core/shared/localization/presentation/pages/language_setting_page.dart';
import 'package:orbiq/features/exchange_rate/presentation/pages/unified_currency_settings_page.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:orbiq/features/auth/presentation/ui/login_page.dart';
import 'package:orbiq/features/auth/presentation/ui/change_pass_page.dart';
import 'package:orbiq/features/auth/presentation/ui/manager_page.dart';
import 'package:orbiq/features/auth/presentation/ui/seller_page.dart';
import 'package:orbiq/features/add_product/presentation/ui/add_product_page.dart';
import 'package:orbiq/features/add_product/presentation/ui/edit_product_page.dart';
import 'package:orbiq/features/auth/presentation/ui/user_management_page.dart';
import 'package:orbiq/features/get_product/presentation/ui/get_product_page.dart';
import 'package:orbiq/features/upgrader/presentation/ui/upgrader_page.dart';

// Phase 2 imports
import 'package:orbiq/features/exchange_rate/presentation/bloc/exchange_rate_bloc.dart';
// UnifiedCurrencySettingsPage replaces both CurrencySettingsPage and ExchangeRateManagementPage
import 'package:orbiq/features/pricing/presentation/bloc/pricing_settings_bloc.dart';
import 'package:orbiq/features/pricing/presentation/pages/pricing_settings_page.dart';
import 'package:orbiq/features/profit/presentation/bloc/profit_report_bloc.dart';
import 'package:orbiq/features/profit/presentation/pages/profit_report_page.dart';

import '../../features/barcode_reader/presentation/ui/data_transfer_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  Routes.login: (context) => const LoginPage(),
  Routes.changePassword: (context) => ChangePasswordPage(
    username: ModalRoute.of(context)?.settings.arguments as String,
  ),
  Routes.manager: (context) => const ManagerPage(),
  Routes.seller: (context) => const SellerPage(),
  Routes.addProduct: (context) => const AddProductPage(),
  Routes.products: (context) => const ProductListPage(),
  Routes.update: (context) => const UpgraderPage(),
  Routes.userManagement: (context) => const UserManagementPage(),
  Routes.editProduct: (context) => EditProductPage(
    product: ModalRoute.of(context)?.settings.arguments as ProductEntity,
  ),
  Routes.barcodeReader: (context) => const DataTransferScreen(),
  Routes.languageSettings: (context) => const LanguageSettingsPage(),
  // Unified Currency Settings (combines currency display and exchange rate)
  Routes.currencySettings: (context) => BlocProvider(
    create: (_) => getIt<ExchangeRateBloc>(),
    child: const UnifiedCurrencySettingsPage(),
  ),

  // Phase 2: Pricing, Profit
  Routes.pricingSettings: (context) => BlocProvider(
    create: (_) => getIt<PricingSettingsBloc>(),
    child: const PricingSettingsPage(),
  ),
  Routes.profitReport: (context) => BlocProvider(
    create: (_) => getIt<ProfitReportBloc>(),
    child: const ProfitReportPage(),
  ),
};
