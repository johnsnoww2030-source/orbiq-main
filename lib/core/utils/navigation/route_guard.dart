import 'package:flutter/material.dart';
import 'package:orbiq/core/adaptor/routes_constants.dart';
import 'package:orbiq/core/utils/navigation/navigation_utils.dart';

/// Route guard utility to protect routes based on authentication status
class RouteGuard {
  /// Check if user is authenticated before allowing access to a route
  static Future<bool> isAuthenticated(BuildContext context) async {
    // In a real app, you would check the actual authentication state
    // For now, we'll just return true to demonstrate the concept
    // You could check for a token, user session, etc.

    // Example implementation:
    // final authState = context.read<AuthBloc>().state;
    // return authState is AuthSuccess;

    // For demonstration purposes, always return true
    return true;
  }

  /// Redirect to login if user is not authenticated
  static void redirectToLoginIfNotAuthenticated(BuildContext context) {
    // In a real app, you would implement actual authentication checking
    // For now, we'll just show how the redirect would work

    // Example implementation:
    // if (!isAuthenticated) {
    //   NavigationUtils.goHome(context);
    // }
  }

  /// Guard a route and redirect if conditions are not met
  static Future<bool> guardRoute(BuildContext context, String route) async {
    // Example: Only allow access to manager routes if user is a manager
    if (route == Routes.manager ||
        route == Routes.userManagement ||
        route == Routes.addProduct ||
        route == Routes.products ||
        route == Routes.editProduct ||
        route == Routes.paymentsReport ||
        route == Routes.update) {
      // Check if user is authenticated and is a manager
      final isAuthenticated = await RouteGuard.isAuthenticated(context);
      if (!isAuthenticated) {
        // Redirect to login
        if (context.mounted) {
          NavigationUtils.goHome(context);
        }
        return false;
      }
      // In a real app, you would also check if the user is a manager
      return true;
    }

    // Allow access to all other routes
    return true;
  }
}
