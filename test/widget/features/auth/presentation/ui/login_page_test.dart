import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbiq/features/auth/presentation/ui/login_page.dart';

void main() {
  group('LoginPage', () {
    testWidgets('should display login form', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      // Assert
      expect(find.text('ورود'), findsOneWidget); // Login button text
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    testWidgets('should display error message when login fails', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      // TODO: Add test for error message display when login fails
      // This would require mocking the AuthBloc
    });
  });
}
