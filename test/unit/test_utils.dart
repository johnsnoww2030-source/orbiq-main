import 'package:flutter_test/flutter_test.dart';

/// Utility functions for unit tests
class TestUtils {
  /// Helper function to run setup and teardown
  static void runWithSetupAndTeardown(
    void Function() setup,
    void Function() testFunction,
    void Function() teardown,
  ) {
    setUp(() {
      setup();
    });

    testFunction();

    tearDown(() {
      teardown();
    });
  }
}
