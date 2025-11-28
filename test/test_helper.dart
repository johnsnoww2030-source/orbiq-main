import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

/// A helper class for common testing utilities
class TestHelper {
  /// Pump the widget tree and settle
  static Future<void> pumpWidgetAndSettle(
    WidgetTester tester,
    Widget widget,
  ) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  }

  /// Create a mock repository with predefined behavior
  static T mockRepository<T extends Mock>(T mock, Function(T) setup) {
    setup(mock);
    return mock;
  }

  /// Create a mock use case with predefined behavior
  static T mockUseCase<T extends Mock>(T mock, Function(T) setup) {
    setup(mock);
    return mock;
  }
}
