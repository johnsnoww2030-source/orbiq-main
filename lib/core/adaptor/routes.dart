import 'package:flutter/material.dart';
import 'package:orbiq/core/adaptor/routes_constants.dart';
import 'package:orbiq/core/shared/localization/presentation/pages/language_setting_page.dart';
import 'package:orbiq/core/shared/currency/presentation/pages/currency_settings_page.dart';
import 'package:orbiq/core/shared/product/data/models/product_model.dart';
import 'package:orbiq/features/auth/presentation/ui/login_page.dart';
import 'package:orbiq/features/auth/presentation/ui/change_pass_page.dart';
import 'package:orbiq/features/auth/presentation/ui/manager_page.dart';
import 'package:orbiq/features/auth/presentation/ui/seller_page.dart';
import 'package:orbiq/features/add_product/presentation/ui/add_product_page.dart';
import 'package:orbiq/features/add_product/presentation/ui/edit_product_page.dart'; // اضافه کردن این import
import 'package:orbiq/features/auth/presentation/ui/user_management_page.dart';
import 'package:orbiq/features/get_product/presentation/ui/get_product_page.dart';
import 'package:orbiq/features/payment/presentation/ui/payment_report_page.dart';
import 'package:orbiq/features/upgrader/presentation/ui/upgrader_page.dart';

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
  Routes.paymentsReport: (context) => const PaymentsReportPage(),
  Routes.editProduct: (context) => EditProductPage(
    product:
        ModalRoute.of(context)?.settings.arguments
            as ProductModel, // اضافه کردن این مسیر
  ),
  Routes.barcodeReader: (context) => const DataTransferScreen(),
  Routes.languageSettings: (context) => const LanguageSettingsPage(),
  Routes.currencySettings: (context) => const CurrencySettingsPage(),
};
