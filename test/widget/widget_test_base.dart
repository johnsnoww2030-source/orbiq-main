import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Base class for widget tests
abstract class WidgetTestBase {
  /// Create a testable widget with necessary providers
  Widget createTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  /// Pump the widget and wait for it to settle
  Future<void> pumpTestWidget(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(createTestableWidget(widget));
    await tester.pumpAndSettle();
  }
}
