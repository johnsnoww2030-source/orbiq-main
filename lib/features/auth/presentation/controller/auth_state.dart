import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.success(UserEntity user, {required bool isManager}) =
      AuthSuccess;
  const factory AuthState.firstLogin(String username) = AuthFirstLogin;
  const factory AuthState.failure(String message) = AuthFailure;
  const factory AuthState.passwordUpdateSuccess() = PasswordUpdateSuccess;
  const factory AuthState.unauthenticated() = UnauthenticatedState;
  const factory AuthState.userAddedSuccess() = UserAddedSuccess;
}

// Extension to get userId from AuthSuccess
extension AuthSuccessExtension on AuthState {
  int? get userId => mapOrNull(success: (s) => s.user.id);
}
