import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';
import 'package:orbiq/features/auth/domain/usecases/add_user_usecase.dart';
import 'package:orbiq/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final LogoutUseCase logoutUseCase;
  final AddUserUseCase addUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.updatePasswordUseCase,
    required this.logoutUseCase,
    required this.addUserUseCase,
  }) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<UpdatePasswordRequested>(_onUpdatePasswordRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AddUserRequested>(_onAddUserRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await loginUseCase.execute(event.username, event.password);

    result.fold(
      (failure) {
        if (failure is FirstLoginFailure) {
          emit(AuthFirstLogin(event.username));
        } else {
          emit(AuthFailure(failure.message));
        }
      },
      (user) {
        if (user.role == 'admin') {
          emit(AuthSuccess(user, isManager: true));
        } else if (user.role == 'seller') {
          emit(AuthSuccess(user, isManager: false));
        }
      },
    );
  }

  Future<void> _onUpdatePasswordRequested(
    UpdatePasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await updatePasswordUseCase.execute(
      event.username,
      event.newPassword,
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(const PasswordUpdateSuccess()),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await logoutUseCase.execute(event.userId);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(const UnauthenticatedState()),
    );
  }

  Future<void> _onAddUserRequested(
    AddUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    final previousState = state;

    emit(const AuthLoading());

    final result = await addUserUseCase.execute(
      event.username,
      event.password,
      event.role,
      event.nickname,
    );

    result.fold((failure) => emit(AuthFailure(failure.message)), (_) {
      emit(const UserAddedSuccess());
      // Restore previous state if it was success
      if (previousState is AuthSuccess) {
        emit(previousState);
      }
    });
  }
}
