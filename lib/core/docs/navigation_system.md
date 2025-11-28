# Navigation System Documentation

## Overview

This document explains the navigation system implemented in the Orbiq application. The system is designed to provide a consistent and maintainable way to handle navigation throughout the app.

## Components

### 1. Route Constants (`routes_constants.dart`)

This file contains all the route names used in the application as constants. Using constants ensures consistency and makes it easier to update route names if needed.

```dart
class Routes {
  static const String login = '/login';
  static const String manager = '/manager';
  // ... other routes
}
```

### 2. Navigation Service (`navigation_service.dart`)

A singleton service that provides methods for navigating to different parts of the application. This service encapsulates all navigation logic and provides a clean API for navigation.

Key features:
- Singleton pattern for consistent access
- Type-safe navigation methods
- Clear method names that indicate the destination

### 3. Navigation Utilities (`navigation_utils.dart`)

A utility class that provides generic navigation methods that can be used throughout the application.

### 4. Route Guards (`route_guard.dart`)

Utilities for protecting routes based on authentication status or other conditions.

## Usage

### Navigating to a Screen

To navigate to a specific screen, use the NavigationService:

```dart
final navigationService = NavigationService();
navigationService.navigateToManager(context);
```

### Adding New Routes

1. Add the route constant to `routes_constants.dart`
2. Add the route to the `appRoutes` map in `routes.dart`
3. Add a method to `NavigationService` for the new route

## Benefits

1. **Consistency**: All navigation is handled through a single service
2. **Maintainability**: Route names are centralized in one location
3. **Type Safety**: Methods provide clear parameters and return types
4. **Scalability**: Easy to add new routes and navigation methods
5. **Testability**: Navigation logic is isolated and can be easily tested

## Best Practices

1. Always use the `Routes` constants instead of hardcoded strings
2. Add new navigation methods to `NavigationService` rather than using `Navigator` directly
3. Use route guards for protected routes
4. Keep the navigation service focused on navigation - don't add business logic to it