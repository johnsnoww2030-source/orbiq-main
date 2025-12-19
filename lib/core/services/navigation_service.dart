import 'package:flutter/material.dart';
import 'package:orbiq/core/adaptor/routes_constants.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

/// A service class that provides navigation functionality throughout the app
class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  /// Navigate to the login screen
  void navigateToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
  }

  /// Navigate to the manager dashboard
  void navigateToManager(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.manager,
      (route) => false,
    );
  }

  /// Navigate to the seller dashboard
  void navigateToSeller(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.seller, (route) => false);
  }

  /// Navigate to the change password screen
  void navigateToChangePassword(BuildContext context, String username) {
    Navigator.pushNamed(context, Routes.changePassword, arguments: username);
  }

  /// Navigate to the user management screen
  void navigateToUserManagement(BuildContext context) {
    Navigator.pushNamed(context, Routes.userManagement);
  }

  /// Navigate to the add product screen
  void navigateToAddProduct(BuildContext context) {
    Navigator.pushNamed(context, Routes.addProduct);
  }

  /// Navigate to the products list screen
  void navigateToProducts(BuildContext context) {
    Navigator.pushNamed(context, Routes.products);
  }

  /// Navigate to the edit product screen
  void navigateToEditProduct(BuildContext context, ProductEntity product) {
    Navigator.pushNamed(context, Routes.editProduct, arguments: product);
  }

  /// Navigate to the update screen
  void navigateToUpdate(BuildContext context) {
    Navigator.pushNamed(context, Routes.update);
  }

  /// Navigate to the barcode reader screen
  void navigateToBarcodeReader(BuildContext context) {
    Navigator.pushNamed(context, Routes.barcodeReader);
  }

  /// Navigate to the language settings screen
  void navigateToLanguageSettings(BuildContext context) {
    Navigator.pushNamed(context, Routes.languageSettings);
  }

  /// Go back to the previous screen
  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// Go back to the previous screen with a result
  void goBackWithResult<T>(BuildContext context, T result) {
    Navigator.pop(context, result);
  }

  /// Check if there's a previous screen to go back to
  bool canGoBack(BuildContext context) {
    return Navigator.canPop(context);
  }
}
