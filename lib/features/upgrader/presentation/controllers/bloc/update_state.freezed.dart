// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateState()';
}


}

/// @nodoc
class $UpdateStateCopyWith<$Res>  {
$UpdateStateCopyWith(UpdateState _, $Res Function(UpdateState) __);
}


/// Adds pattern-matching-related methods to [UpdateState].
extension UpdateStatePatterns on UpdateState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UpdateInitial value)?  initial,TResult Function( UpdateChecking value)?  checking,TResult Function( UpdateAvailable value)?  available,TResult Function( UpdateNotAvailable value)?  notAvailable,TResult Function( UpdateDownloading value)?  downloading,TResult Function( UpdateInstalled value)?  installed,TResult Function( UpdateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UpdateInitial() when initial != null:
return initial(_that);case UpdateChecking() when checking != null:
return checking(_that);case UpdateAvailable() when available != null:
return available(_that);case UpdateNotAvailable() when notAvailable != null:
return notAvailable(_that);case UpdateDownloading() when downloading != null:
return downloading(_that);case UpdateInstalled() when installed != null:
return installed(_that);case UpdateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UpdateInitial value)  initial,required TResult Function( UpdateChecking value)  checking,required TResult Function( UpdateAvailable value)  available,required TResult Function( UpdateNotAvailable value)  notAvailable,required TResult Function( UpdateDownloading value)  downloading,required TResult Function( UpdateInstalled value)  installed,required TResult Function( UpdateError value)  error,}){
final _that = this;
switch (_that) {
case UpdateInitial():
return initial(_that);case UpdateChecking():
return checking(_that);case UpdateAvailable():
return available(_that);case UpdateNotAvailable():
return notAvailable(_that);case UpdateDownloading():
return downloading(_that);case UpdateInstalled():
return installed(_that);case UpdateError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UpdateInitial value)?  initial,TResult? Function( UpdateChecking value)?  checking,TResult? Function( UpdateAvailable value)?  available,TResult? Function( UpdateNotAvailable value)?  notAvailable,TResult? Function( UpdateDownloading value)?  downloading,TResult? Function( UpdateInstalled value)?  installed,TResult? Function( UpdateError value)?  error,}){
final _that = this;
switch (_that) {
case UpdateInitial() when initial != null:
return initial(_that);case UpdateChecking() when checking != null:
return checking(_that);case UpdateAvailable() when available != null:
return available(_that);case UpdateNotAvailable() when notAvailable != null:
return notAvailable(_that);case UpdateDownloading() when downloading != null:
return downloading(_that);case UpdateInstalled() when installed != null:
return installed(_that);case UpdateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  checking,TResult Function( VersionInfoEntity versionInfo)?  available,TResult Function()?  notAvailable,TResult Function()?  downloading,TResult Function()?  installed,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UpdateInitial() when initial != null:
return initial();case UpdateChecking() when checking != null:
return checking();case UpdateAvailable() when available != null:
return available(_that.versionInfo);case UpdateNotAvailable() when notAvailable != null:
return notAvailable();case UpdateDownloading() when downloading != null:
return downloading();case UpdateInstalled() when installed != null:
return installed();case UpdateError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  checking,required TResult Function( VersionInfoEntity versionInfo)  available,required TResult Function()  notAvailable,required TResult Function()  downloading,required TResult Function()  installed,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case UpdateInitial():
return initial();case UpdateChecking():
return checking();case UpdateAvailable():
return available(_that.versionInfo);case UpdateNotAvailable():
return notAvailable();case UpdateDownloading():
return downloading();case UpdateInstalled():
return installed();case UpdateError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  checking,TResult? Function( VersionInfoEntity versionInfo)?  available,TResult? Function()?  notAvailable,TResult? Function()?  downloading,TResult? Function()?  installed,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case UpdateInitial() when initial != null:
return initial();case UpdateChecking() when checking != null:
return checking();case UpdateAvailable() when available != null:
return available(_that.versionInfo);case UpdateNotAvailable() when notAvailable != null:
return notAvailable();case UpdateDownloading() when downloading != null:
return downloading();case UpdateInstalled() when installed != null:
return installed();case UpdateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class UpdateInitial implements UpdateState {
  const UpdateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateState.initial()';
}


}




/// @nodoc


class UpdateChecking implements UpdateState {
  const UpdateChecking();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateChecking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateState.checking()';
}


}




/// @nodoc


class UpdateAvailable implements UpdateState {
  const UpdateAvailable(this.versionInfo);
  

 final  VersionInfoEntity versionInfo;

/// Create a copy of UpdateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateAvailableCopyWith<UpdateAvailable> get copyWith => _$UpdateAvailableCopyWithImpl<UpdateAvailable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateAvailable&&(identical(other.versionInfo, versionInfo) || other.versionInfo == versionInfo));
}


@override
int get hashCode => Object.hash(runtimeType,versionInfo);

@override
String toString() {
  return 'UpdateState.available(versionInfo: $versionInfo)';
}


}

/// @nodoc
abstract mixin class $UpdateAvailableCopyWith<$Res> implements $UpdateStateCopyWith<$Res> {
  factory $UpdateAvailableCopyWith(UpdateAvailable value, $Res Function(UpdateAvailable) _then) = _$UpdateAvailableCopyWithImpl;
@useResult
$Res call({
 VersionInfoEntity versionInfo
});




}
/// @nodoc
class _$UpdateAvailableCopyWithImpl<$Res>
    implements $UpdateAvailableCopyWith<$Res> {
  _$UpdateAvailableCopyWithImpl(this._self, this._then);

  final UpdateAvailable _self;
  final $Res Function(UpdateAvailable) _then;

/// Create a copy of UpdateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? versionInfo = null,}) {
  return _then(UpdateAvailable(
null == versionInfo ? _self.versionInfo : versionInfo // ignore: cast_nullable_to_non_nullable
as VersionInfoEntity,
  ));
}


}

/// @nodoc


class UpdateNotAvailable implements UpdateState {
  const UpdateNotAvailable();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateNotAvailable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateState.notAvailable()';
}


}




/// @nodoc


class UpdateDownloading implements UpdateState {
  const UpdateDownloading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateDownloading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateState.downloading()';
}


}




/// @nodoc


class UpdateInstalled implements UpdateState {
  const UpdateInstalled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateInstalled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateState.installed()';
}


}




/// @nodoc


class UpdateError implements UpdateState {
  const UpdateError(this.message);
  

 final  String message;

/// Create a copy of UpdateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateErrorCopyWith<UpdateError> get copyWith => _$UpdateErrorCopyWithImpl<UpdateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UpdateState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $UpdateErrorCopyWith<$Res> implements $UpdateStateCopyWith<$Res> {
  factory $UpdateErrorCopyWith(UpdateError value, $Res Function(UpdateError) _then) = _$UpdateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UpdateErrorCopyWithImpl<$Res>
    implements $UpdateErrorCopyWith<$Res> {
  _$UpdateErrorCopyWithImpl(this._self, this._then);

  final UpdateError _self;
  final $Res Function(UpdateError) _then;

/// Create a copy of UpdateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UpdateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
