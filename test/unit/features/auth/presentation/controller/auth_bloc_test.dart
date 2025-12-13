import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:orbiq/features/auth/domain/entities/user_entity.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';
import 'package:orbiq/features/auth/domain/usecases/add_user_usecase.dart';
import 'package:orbiq/features/auth/domain/usecases/login_usecase.dart';
import 'package:orbiq/features/auth/domain/usecases/logout_usecase.dart';
import 'package:orbiq/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_bloc.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';

// Mock classes
class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockUpdatePasswordUseCase extends Mock implements UpdatePasswordUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

class MockAddUserUseCase extends Mock implements AddUserUseCase {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockUpdatePasswordUseCase mockUpdatePasswordUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockAddUserUseCase mockAddUserUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockUpdatePasswordUseCase = MockUpdatePasswordUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockAddUserUseCase = MockAddUserUseCase();

    authBloc = AuthBloc(
      loginUseCase: mockLoginUseCase,
      updatePasswordUseCase: mockUpdatePasswordUseCase,
      logoutUseCase: mockLogoutUseCase,
      addUserUseCase: mockAddUserUseCase,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state should be AuthInitial', () {
      expect(authBloc.state, const AuthInitial());
    });

    group('LoginRequested', () {
      const testUsername = 'testuser';
      const testPassword = 'password123';
      const testUser = UserEntity(
        id: 1,
        uuid: 'test-uuid',
        username: testUsername,
        password: 'hashed',
        role: 'admin',
        isFirstLogin: false,
        loggedin: true,
        nickname: 'Test User',
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthSuccess] when login is successful for admin',
        build: () {
          when(
            () => mockLoginUseCase.execute(testUsername, testPassword),
          ).thenAnswer((_) async => const Right(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(LoginRequested(testUsername, testPassword)),
        expect: () => [
          const AuthLoading(),
          const AuthSuccess(testUser, isManager: true),
        ],
        verify: (_) {
          verify(
            () => mockLoginUseCase.execute(testUsername, testPassword),
          ).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthSuccess] when login is successful for seller',
        build: () {
          const sellerUser = UserEntity(
            id: 2,
            uuid: 'seller-uuid',
            username: 'seller',
            password: 'hashed',
            role: 'seller',
            isFirstLogin: false,
            loggedin: true,
            nickname: 'Seller User',
          );
          when(
            () => mockLoginUseCase.execute('seller', testPassword),
          ).thenAnswer((_) async => const Right(sellerUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(LoginRequested('seller', testPassword)),
        expect: () => [
          const AuthLoading(),
          isA<AuthSuccess>().having((s) => s.isManager, 'isManager', false),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFirstLogin] when first login is detected',
        build: () {
          when(
            () => mockLoginUseCase.execute(testUsername, testPassword),
          ).thenAnswer((_) async => Left(FirstLoginFailure()));
          return authBloc;
        },
        act: (bloc) => bloc.add(LoginRequested(testUsername, testPassword)),
        expect: () => [const AuthLoading(), const AuthFirstLogin(testUsername)],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when login fails',
        build: () {
          when(
            () => mockLoginUseCase.execute(testUsername, testPassword),
          ).thenAnswer(
            (_) async =>
                Left(LoginFailure(type: AuthFailureType.invalidCredentials)),
          );
          return authBloc;
        },
        act: (bloc) => bloc.add(LoginRequested(testUsername, testPassword)),
        expect: () => [
          const AuthLoading(),
          const AuthFailure(failureType: AuthFailureType.invalidCredentials),
        ],
      );
    });

    group('UpdatePasswordRequested', () {
      const testUsername = 'testuser';
      const newPassword = 'newpassword123';

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, PasswordUpdateSuccess] when password update succeeds',
        build: () {
          when(
            () => mockUpdatePasswordUseCase.execute(testUsername, newPassword),
          ).thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          UpdatePasswordRequested(
            username: testUsername,
            newPassword: newPassword,
          ),
        ),
        expect: () => [const AuthLoading(), const PasswordUpdateSuccess()],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when password update fails',
        build: () {
          when(
            () => mockUpdatePasswordUseCase.execute(testUsername, newPassword),
          ).thenAnswer(
            (_) async => Left(
              GeneralFailure(
                type: AuthFailureType.general,
                message: 'Update failed',
              ),
            ),
          );
          return authBloc;
        },
        act: (bloc) => bloc.add(
          UpdatePasswordRequested(
            username: testUsername,
            newPassword: newPassword,
          ),
        ),
        expect: () => [
          const AuthLoading(),
          const AuthFailure(
            failureType: AuthFailureType.general,
            extraMessage: 'Update failed',
          ),
        ],
      );
    });

    group('LogoutRequested', () {
      const testUserId = 1;

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, UnauthenticatedState] when logout succeeds',
        build: () {
          when(
            () => mockLogoutUseCase.execute(testUserId),
          ).thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(LogoutRequested(userId: testUserId)),
        expect: () => [const AuthLoading(), const UnauthenticatedState()],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when logout fails',
        build: () {
          when(() => mockLogoutUseCase.execute(testUserId)).thenAnswer(
            (_) async =>
                Left(GeneralFailure(type: AuthFailureType.logoutFailed)),
          );
          return authBloc;
        },
        act: (bloc) => bloc.add(LogoutRequested(userId: testUserId)),
        expect: () => [
          const AuthLoading(),
          const AuthFailure(failureType: AuthFailureType.logoutFailed),
        ],
      );
    });

    group('AddUserRequested', () {
      const testUsername = 'newuser';
      const testPassword = 'password123';
      const testRole = 'seller';
      const testNickname = 'New User';

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, UserAddedSuccess] when user is added successfully',
        build: () {
          when(
            () => mockAddUserUseCase.execute(
              testUsername,
              testPassword,
              testRole,
              testNickname,
            ),
          ).thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          AddUserRequested(
            username: testUsername,
            password: testPassword,
            role: testRole,
            nickname: testNickname,
          ),
        ),
        expect: () => [const AuthLoading(), const UserAddedSuccess()],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when adding user fails',
        build: () {
          when(
            () => mockAddUserUseCase.execute(
              testUsername,
              testPassword,
              testRole,
              testNickname,
            ),
          ).thenAnswer(
            (_) async => Left(
              GeneralFailure(
                type: AuthFailureType.addUserFailed,
                message: 'Failed to add user',
              ),
            ),
          );
          return authBloc;
        },
        act: (bloc) => bloc.add(
          AddUserRequested(
            username: testUsername,
            password: testPassword,
            role: testRole,
            nickname: testNickname,
          ),
        ),
        expect: () => [
          const AuthLoading(),
          const AuthFailure(
            failureType: AuthFailureType.addUserFailed,
            extraMessage: 'Failed to add user',
          ),
        ],
      );
    });
  });
}
