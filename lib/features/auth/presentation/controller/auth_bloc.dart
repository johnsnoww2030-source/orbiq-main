// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:orbiq/features/auth/domain/failures/failure.dart';
// import 'package:orbiq/features/auth/domain/usecases/update_password_usecase.dart';
// import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';
// import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
// import '../../domain/usecases/login_usecase.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final LoginUseCase loginUseCase;
//   final UpdatePasswordUseCase updatePasswordUseCase;

//   AuthBloc({
//     required this.loginUseCase,
//     required this.updatePasswordUseCase,
//   }) : super(AuthInitial()) {
//     on<LoginRequested>(_onLoginRequested);
//     on<UpdatePasswordRequested>(_onUpdatePasswordRequested);
//   }

//   Future<void> _onLoginRequested(
//     LoginRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());

//     final result = await loginUseCase.execute(event.username, event.password);

//     result.fold(
//       (failure) {
//         if (failure is FirstLoginFailure) {
//           emit(AuthFirstLogin(event.username));
//         } else {
//           emit(AuthFailure(failure.message));
//         }
//       },
//       (user) {
//         if (user.role == 'admin') {
//           emit(AuthSuccess(user, isManager: true));
//         } else if (user.role == 'seller') {
//           emit(AuthSuccess(user, isManager: false));
//         }
//       },
//     );
//   }

//   Future<void> _onUpdatePasswordRequested(
//     UpdatePasswordRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());

//     final result = await updatePasswordUseCase.execute(
//       event.username,
//       event.newPassword,
//     );

//     result.fold(
//       (failure) {
//         emit(AuthFailure(failure.message));
//       },
//       (_) {
//         emit(PasswordUpdateSuccess());
//       },
//     );
//   }
// }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:orbiq/features/auth/domain/failures/failure.dart';
// import 'package:orbiq/features/auth/domain/usecases/add_user_usecase.dart';
// import 'package:orbiq/features/auth/domain/usecases/update_password_usecase.dart';
// import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';
// import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
// import '../../domain/usecases/login_usecase.dart';
// import '../../domain/usecases/logout_usecase.dart'; // اضافه کردن logoutUseCase

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final LoginUseCase loginUseCase;
//   final UpdatePasswordUseCase updatePasswordUseCase;
//   final LogoutUseCase logoutUseCase; // اضافه کردن logoutUseCase
//   final AddUserUseCase addUserUseCase; // اضافه کردن addUserUseCase

//   AuthBloc({
//     required this.loginUseCase,
//     required this.updatePasswordUseCase,
//     required this.logoutUseCase, // اضافه کردن logoutUseCase به کانستراکتور
//     required this.addUserUseCase, // اضافه کردن addUserUseCase به کانستراکتور
//   }) : super(AuthInitial()) {
//     on<LoginRequested>(_onLoginRequested);
//     on<UpdatePasswordRequested>(_onUpdatePasswordRequested);
//     on<LogoutRequested>(_onLogoutRequested); // اضافه کردن رویداد Logout
//     on<AddUserRequested>(_onAddUserRequested); // اضافه کردن رویداد AddUserRequested
//     on<RefreshAuth>(_onRefreshAuthState);
//     add(RefreshAuth());
//   }

//   Future<void> _onLoginRequested(
//     LoginRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());

//     final result = await loginUseCase.execute(event.username, event.password);

//     result.fold(
//       (failure) {
//         if (failure is FirstLoginFailure) {
//           emit(AuthFirstLogin(event.username));
//         } else {
//           emit(AuthFailure(failure.message));
//         }
//       },
//       (user) {
//         if (user.role == 'admin') {
//           emit(AuthSuccess(user, isManager: true));
//         } else if (user.role == 'seller') {
//           emit(AuthSuccess(user, isManager: false));
//         }
//       },
//     );
//   }

//   Future<void> _onUpdatePasswordRequested(
//     UpdatePasswordRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());

//     final result = await updatePasswordUseCase.execute(
//       event.username,
//       event.newPassword,
//     );

//     result.fold(
//       (failure) {
//         emit(AuthFailure(failure.message));
//       },
//       (_) {
//         emit(PasswordUpdateSuccess());
//       },
//     );
//   }

//   // متد جدید برای مدیریت خروج کاربر
//   Future<void> _onLogoutRequested(
//     LogoutRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());

//     final result = await logoutUseCase.execute(event.userId);

//     result.fold(
//       (failure) {
//         emit(AuthFailure(failure.message));
//       },
//       (_) {
//         emit(UnauthenticatedState()); // بعد از خروج به حالت Unauthenticated برو
//       },
//     );
//   }

//   Future<void> _onAddUserRequested(
//     AddUserRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());

//     final result = await addUserUseCase.execute(
//       event.username,
//       event.password,
//       event.role,
//       event.nickname,
//     );

//     result.fold(
//       (failure) {
//         emit(AuthFailure(failure.message));
//       },
//       (_) {
//         emit(UserAddedSuccess());
//         // پس از افزودن کاربر، وضعیت را به حالت قبلی برمی‌گردانیم
//         final currentState = state;
//         if (currentState is AuthSuccess) {
//           emit(currentState);
//         }
//       },
//     );
//   }

//   Future<void> _onRefreshAuthState(
//     RefreshAuth event,
//     Emitter<AuthState> emit,
//   ) async {
//     // بررسی وجود توکن معتبر یا اطلاعات session
//     final isAuthenticated = await _checkAuthStatus(); // این متد را باید پیاده‌سازی کنید
//     if (isAuthenticated) {
//       final user = await _getUserInfo(); // این متد را باید پیاده‌سازی کنید
//       emit(AuthSuccess(user, isManager: user.role == 'admin'));
//     } else {
//       emit(UnauthenticatedState());
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';
import 'package:orbiq/features/auth/domain/usecases/add_user_usecase.dart';
import 'package:orbiq/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_event.dart';
import 'package:orbiq/features/auth/presentation/controller/auth_state.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart'; // اضافه کردن logoutUseCase

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final LogoutUseCase logoutUseCase; // اضافه کردن logoutUseCase
  final AddUserUseCase addUserUseCase; // اضافه کردن addUserUseCase

  AuthBloc({
    required this.loginUseCase,
    required this.updatePasswordUseCase,
    required this.logoutUseCase, // اضافه کردن logoutUseCase به کانستراکتور
    required this.addUserUseCase, // اضافه کردن addUserUseCase به کانستراکتور
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<UpdatePasswordRequested>(_onUpdatePasswordRequested);
    on<LogoutRequested>(_onLogoutRequested); // اضافه کردن رویداد Logout
    on<AddUserRequested>(
      _onAddUserRequested,
    ); // اضافه کردن رویداد AddUserRequested
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

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
    emit(AuthLoading());

    final result = await updatePasswordUseCase.execute(
      event.username,
      event.newPassword,
    );

    result.fold(
      (failure) {
        emit(AuthFailure(failure.message));
      },
      (_) {
        emit(PasswordUpdateSuccess());
      },
    );
  }

  // متد جدید برای مدیریت خروج کاربر
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await logoutUseCase.execute(event.userId);

    result.fold(
      (failure) {
        emit(AuthFailure(failure.message));
      },
      (_) {
        emit(UnauthenticatedState()); // بعد از خروج به حالت Unauthenticated برو
      },
    );
  }

  Future<void> _onAddUserRequested(
    AddUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    // ذخیره وضعیت قبلی
    final previousState = state;

    emit(AuthLoading());

    final result = await addUserUseCase.execute(
      event.username,
      event.password,
      event.role,
      event.nickname,
    );

    result.fold(
      (failure) {
        emit(AuthFailure(failure.message));
      },
      (_) {
        emit(UserAddedSuccess());

        // بازگرداندن وضعیت قبلی در صورت نیاز
        if (previousState is AuthSuccess) {
          emit(previousState);
        }
      },
    );
  }
}
