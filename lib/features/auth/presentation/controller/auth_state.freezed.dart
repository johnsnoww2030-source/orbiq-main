// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthInitial value)?  initial,TResult Function( AuthLoading value)?  loading,TResult Function( AuthSuccess value)?  success,TResult Function( AuthFirstLogin value)?  firstLogin,TResult Function( AuthFailure value)?  failure,TResult Function( PasswordUpdateSuccess value)?  passwordUpdateSuccess,TResult Function( UnauthenticatedState value)?  unauthenticated,TResult Function( UserAddedSuccess value)?  userAddedSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthInitial() when initial != null:
return initial(_that);case AuthLoading() when loading != null:
return loading(_that);case AuthSuccess() when success != null:
return success(_that);case AuthFirstLogin() when firstLogin != null:
return firstLogin(_that);case AuthFailure() when failure != null:
return failure(_that);case PasswordUpdateSuccess() when passwordUpdateSuccess != null:
return passwordUpdateSuccess(_that);case UnauthenticatedState() when unauthenticated != null:
return unauthenticated(_that);case UserAddedSuccess() when userAddedSuccess != null:
return userAddedSuccess(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthInitial value)  initial,required TResult Function( AuthLoading value)  loading,required TResult Function( AuthSuccess value)  success,required TResult Function( AuthFirstLogin value)  firstLogin,required TResult Function( AuthFailure value)  failure,required TResult Function( PasswordUpdateSuccess value)  passwordUpdateSuccess,required TResult Function( UnauthenticatedState value)  unauthenticated,required TResult Function( UserAddedSuccess value)  userAddedSuccess,}){
final _that = this;
switch (_that) {
case AuthInitial():
return initial(_that);case AuthLoading():
return loading(_that);case AuthSuccess():
return success(_that);case AuthFirstLogin():
return firstLogin(_that);case AuthFailure():
return failure(_that);case PasswordUpdateSuccess():
return passwordUpdateSuccess(_that);case UnauthenticatedState():
return unauthenticated(_that);case UserAddedSuccess():
return userAddedSuccess(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthInitial value)?  initial,TResult? Function( AuthLoading value)?  loading,TResult? Function( AuthSuccess value)?  success,TResult? Function( AuthFirstLogin value)?  firstLogin,TResult? Function( AuthFailure value)?  failure,TResult? Function( PasswordUpdateSuccess value)?  passwordUpdateSuccess,TResult? Function( UnauthenticatedState value)?  unauthenticated,TResult? Function( UserAddedSuccess value)?  userAddedSuccess,}){
final _that = this;
switch (_that) {
case AuthInitial() when initial != null:
return initial(_that);case AuthLoading() when loading != null:
return loading(_that);case AuthSuccess() when success != null:
return success(_that);case AuthFirstLogin() when firstLogin != null:
return firstLogin(_that);case AuthFailure() when failure != null:
return failure(_that);case PasswordUpdateSuccess() when passwordUpdateSuccess != null:
return passwordUpdateSuccess(_that);case UnauthenticatedState() when unauthenticated != null:
return unauthenticated(_that);case UserAddedSuccess() when userAddedSuccess != null:
return userAddedSuccess(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( UserEntity user,  bool isManager)?  success,TResult Function( String username)?  firstLogin,TResult Function( String message)?  failure,TResult Function()?  passwordUpdateSuccess,TResult Function()?  unauthenticated,TResult Function()?  userAddedSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthInitial() when initial != null:
return initial();case AuthLoading() when loading != null:
return loading();case AuthSuccess() when success != null:
return success(_that.user,_that.isManager);case AuthFirstLogin() when firstLogin != null:
return firstLogin(_that.username);case AuthFailure() when failure != null:
return failure(_that.message);case PasswordUpdateSuccess() when passwordUpdateSuccess != null:
return passwordUpdateSuccess();case UnauthenticatedState() when unauthenticated != null:
return unauthenticated();case UserAddedSuccess() when userAddedSuccess != null:
return userAddedSuccess();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( UserEntity user,  bool isManager)  success,required TResult Function( String username)  firstLogin,required TResult Function( String message)  failure,required TResult Function()  passwordUpdateSuccess,required TResult Function()  unauthenticated,required TResult Function()  userAddedSuccess,}) {final _that = this;
switch (_that) {
case AuthInitial():
return initial();case AuthLoading():
return loading();case AuthSuccess():
return success(_that.user,_that.isManager);case AuthFirstLogin():
return firstLogin(_that.username);case AuthFailure():
return failure(_that.message);case PasswordUpdateSuccess():
return passwordUpdateSuccess();case UnauthenticatedState():
return unauthenticated();case UserAddedSuccess():
return userAddedSuccess();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( UserEntity user,  bool isManager)?  success,TResult? Function( String username)?  firstLogin,TResult? Function( String message)?  failure,TResult? Function()?  passwordUpdateSuccess,TResult? Function()?  unauthenticated,TResult? Function()?  userAddedSuccess,}) {final _that = this;
switch (_that) {
case AuthInitial() when initial != null:
return initial();case AuthLoading() when loading != null:
return loading();case AuthSuccess() when success != null:
return success(_that.user,_that.isManager);case AuthFirstLogin() when firstLogin != null:
return firstLogin(_that.username);case AuthFailure() when failure != null:
return failure(_that.message);case PasswordUpdateSuccess() when passwordUpdateSuccess != null:
return passwordUpdateSuccess();case UnauthenticatedState() when unauthenticated != null:
return unauthenticated();case UserAddedSuccess() when userAddedSuccess != null:
return userAddedSuccess();case _:
  return null;

}
}

}

/// @nodoc


class AuthInitial implements AuthState {
  const AuthInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class AuthLoading implements AuthState {
  const AuthLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class AuthSuccess implements AuthState {
  const AuthSuccess(this.user, {required this.isManager});
  

 final  UserEntity user;
 final  bool isManager;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSuccessCopyWith<AuthSuccess> get copyWith => _$AuthSuccessCopyWithImpl<AuthSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSuccess&&(identical(other.user, user) || other.user == user)&&(identical(other.isManager, isManager) || other.isManager == isManager));
}


@override
int get hashCode => Object.hash(runtimeType,user,isManager);

@override
String toString() {
  return 'AuthState.success(user: $user, isManager: $isManager)';
}


}

/// @nodoc
abstract mixin class $AuthSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthSuccessCopyWith(AuthSuccess value, $Res Function(AuthSuccess) _then) = _$AuthSuccessCopyWithImpl;
@useResult
$Res call({
 UserEntity user, bool isManager
});




}
/// @nodoc
class _$AuthSuccessCopyWithImpl<$Res>
    implements $AuthSuccessCopyWith<$Res> {
  _$AuthSuccessCopyWithImpl(this._self, this._then);

  final AuthSuccess _self;
  final $Res Function(AuthSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,Object? isManager = null,}) {
  return _then(AuthSuccess(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity,isManager: null == isManager ? _self.isManager : isManager // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class AuthFirstLogin implements AuthState {
  const AuthFirstLogin(this.username);
  

 final  String username;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFirstLoginCopyWith<AuthFirstLogin> get copyWith => _$AuthFirstLoginCopyWithImpl<AuthFirstLogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFirstLogin&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString() {
  return 'AuthState.firstLogin(username: $username)';
}


}

/// @nodoc
abstract mixin class $AuthFirstLoginCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthFirstLoginCopyWith(AuthFirstLogin value, $Res Function(AuthFirstLogin) _then) = _$AuthFirstLoginCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class _$AuthFirstLoginCopyWithImpl<$Res>
    implements $AuthFirstLoginCopyWith<$Res> {
  _$AuthFirstLoginCopyWithImpl(this._self, this._then);

  final AuthFirstLogin _self;
  final $Res Function(AuthFirstLogin) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(AuthFirstLogin(
null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthFailure implements AuthState {
  const AuthFailure(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<AuthFailure> get copyWith => _$AuthFailureCopyWithImpl<AuthFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $AuthFailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthFailureCopyWith(AuthFailure value, $Res Function(AuthFailure) _then) = _$AuthFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AuthFailureCopyWithImpl<$Res>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._self, this._then);

  final AuthFailure _self;
  final $Res Function(AuthFailure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AuthFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PasswordUpdateSuccess implements AuthState {
  const PasswordUpdateSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordUpdateSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.passwordUpdateSuccess()';
}


}




/// @nodoc


class UnauthenticatedState implements AuthState {
  const UnauthenticatedState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthenticatedState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class UserAddedSuccess implements AuthState {
  const UserAddedSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAddedSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.userAddedSuccess()';
}


}




// dart format on
