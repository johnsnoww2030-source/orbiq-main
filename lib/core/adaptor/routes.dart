import 'package:flutter/material.dart';
import 'package:orbiq/core/adaptor/routes_constants.dart';
import 'package:orbiq/core/shared/localization/presentation/pages/language_setting_page.dart';
import 'package:orbiq/core/shared/currency/presentation/pages/currency_settings_page.dart';
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

import '../../features/barcode_reader/presentation/ui/data_transfer_screen.dart';

// TODO: Replace with Sales Module (PRD)
// Removed: payment_report_page.dart

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
  // TODO: Replace with Sales Module (PRD)
  // Routes.paymentsReport: (context) => const PaymentsReportPage(),
  Routes.editProduct: (context) => EditProductPage(
    product: ModalRoute.of(context)?.settings.arguments as ProductEntity,
  ),
  Routes.barcodeReader: (context) => const DataTransferScreen(),
  Routes.languageSettings: (context) => const LanguageSettingsPage(),
  Routes.currencySettings: (context) => const CurrencySettingsPage(),
};
