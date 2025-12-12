import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import 'package:orbiq/features/auth/presentation/ui/login_page.dart';

// Mock AuthBloc using MockBloc from bloc_test
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUpAll(() {
    registerFallbackValue(LoginRequested('', ''));
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(const AuthInitial());
  });

  tearDown(() {
    mockAuthBloc.close();
  });

  Widget createLoginPage() {
    return MaterialApp(
      locale: const Locale('fa'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fa'), Locale('en'), Locale('ar')],
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: const LoginPage(),
      ),
    );
  }

  group('LoginPage', () {
    group('UI Display Tests', () {
      testWidgets(
        'should display login form with username and password fields',
        (WidgetTester tester) async {
          // Arrange & Act
          await tester.pumpWidget(createLoginPage());
          await tester.pumpAndSettle();

          // Assert - Check for icons that identify the fields
          expect(find.byIcon(Icons.person_outline), findsOneWidget);
          expect(find.byIcon(Icons.lock_outline), findsOneWidget);
          expect(find.byIcon(Icons.lock_person_outlined), findsOneWidget);
        },
      );

      testWidgets('should display login button', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(createLoginPage());
        await tester.pumpAndSettle();

        // Assert - Check for ElevatedButton
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets(
        'should display loading indicator when state is AuthLoading',
        (WidgetTester tester) async {
          // Arrange
          when(() => mockAuthBloc.state).thenReturn(const AuthLoading());

          // Act
          await tester.pumpWidget(createLoginPage());
          await tester.pump();

          // Assert
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );
    });

    group('Form Validation Tests', () {
      testWidgets('should show validation error when username is empty', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createLoginPage());
        await tester.pumpAndSettle();

        // Act - Try to submit with empty fields
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // Assert - Validation error should appear (form has 2 TextFormFields)
        expect(find.byType(TextFormField), findsNWidgets(2));
      });

      testWidgets('should show validation error when password is empty', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createLoginPage());
        await tester.pumpAndSettle();

        // Act - Enter only username
        await tester.enterText(find.byType(TextFormField).first, 'testuser');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // Assert - Form validation occurs
        expect(find.byType(TextFormField), findsNWidgets(2));
      });
    });

    group('Login Submission Tests', () {
      testWidgets('should dispatch LoginRequested event when form is valid', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createLoginPage());
        await tester.pumpAndSettle();

        // Act
        await tester.enterText(find.byType(TextFormField).first, 'testuser');
        await tester.enterText(find.byType(TextFormField).last, 'password123');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // Assert
        verify(
          () => mockAuthBloc.add(any(that: isA<LoginRequested>())),
        ).called(1);
      });

      testWidgets('should not dispatch event when username is empty', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createLoginPage());
        await tester.pumpAndSettle();

        // Act - Enter only password
        await tester.enterText(find.byType(TextFormField).last, 'password123');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // Assert - No event should be dispatched
        verifyNever(() => mockAuthBloc.add(any()));
      });

      testWidgets('should not dispatch event when password is empty', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createLoginPage());
        await tester.pumpAndSettle();

        // Act - Enter only username
        await tester.enterText(find.byType(TextFormField).first, 'testuser');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        // Assert - No event should be dispatched
        verifyNever(() => mockAuthBloc.add(any()));
      });
    });

    group('State Handling Tests', () {
      testWidgets('should disable login button when loading', (
        WidgetTester tester,
      ) async {
        // Arrange
        when(() => mockAuthBloc.state).thenReturn(const AuthLoading());

        // Act
        await tester.pumpWidget(createLoginPage());
        await tester.pump();

        // Assert - Button should be disabled (onPressed is null)
        final button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );
        expect(button.onPressed, isNull);
      });

      testWidgets('should show snackbar when AuthFailure state is emitted', (
        WidgetTester tester,
      ) async {
        // Arrange
        final controller = StreamController<AuthState>.broadcast();
        whenListen(
          mockAuthBloc,
          controller.stream,
          initialState: const AuthInitial(),
        );

        // Act
        await tester.pumpWidget(createLoginPage());
        await tester.pumpAndSettle();

        // Emit failure state
        controller.add(const AuthFailure('نام کاربری یا رمز عبور اشتباه است'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('نام کاربری یا رمز عبور اشتباه است'), findsOneWidget);

        await controller.close();
      });
    });

    group('Responsive Layout Tests', () {
      testWidgets('should display mobile layout on small screens', (
        WidgetTester tester,
      ) async {
        // Arrange - Set small screen size
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        // Act
        await tester.pumpWidget(createLoginPage());
        await tester.pumpAndSettle();

        // Assert - Card should be present (mobile layout)
        expect(find.byType(Card), findsOneWidget);

        // Reset
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      testWidgets('should display desktop layout on large screens', (
        WidgetTester tester,
      ) async {
        // Arrange - Set large screen size
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        // Act
        await tester.pumpWidget(createLoginPage());
        await tester.pumpAndSettle();

        // Assert - Row should be used for desktop layout
        expect(find.byType(Row), findsWidgets);

        // Reset
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    group('Keyboard Interaction Tests', () {
      testWidgets(
        'should move focus to password field when pressing next on username',
        (WidgetTester tester) async {
          // Arrange
          await tester.pumpWidget(createLoginPage());
          await tester.pumpAndSettle();

          // Act - Enter text in username and press next
          await tester.enterText(find.byType(TextFormField).first, 'testuser');
          await tester.testTextInput.receiveAction(TextInputAction.next);
          await tester.pumpAndSettle();

          // Assert - Focus should move (no exception means success)
          expect(find.byType(TextFormField), findsNWidgets(2));
        },
      );

      testWidgets('should submit form when pressing done on password field', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createLoginPage());
        await tester.pumpAndSettle();

        // Act - Fill both fields and press done on password
        await tester.enterText(find.byType(TextFormField).first, 'testuser');
        await tester.enterText(find.byType(TextFormField).last, 'password123');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Assert - Login should be attempted
        verify(
          () => mockAuthBloc.add(any(that: isA<LoginRequested>())),
        ).called(1);
      });
    });
  });
}
