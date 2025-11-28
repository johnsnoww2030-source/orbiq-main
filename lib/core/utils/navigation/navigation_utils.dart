import 'package:flutter/material.dart';

/// Utility class for navigation throughout the app
class NavigationUtils {
  /// Navigate to a named route
  static void goTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  /// Navigate to a named route with arguments
  static void goToWithArgs(
    BuildContext context,
    String route,
    Object arguments,
  ) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  /// Push a new route onto the navigation stack
  static void pushTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  /// Push a new route onto the navigation stack with arguments
  static void pushToWithArgs(
    BuildContext context,
    String route,
    Object arguments,
  ) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  /// Navigate back to the previous screen
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigate back to the previous screen with a result
  static void popWithResult<T>(BuildContext context, T result) {
    Navigator.pop(context, result);
  }

  /// Navigate back to the root route, clearing the navigation stack
  static void goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  /// Push a new route and remove all previous routes
  static void pushAndRemoveUntil(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }
}
