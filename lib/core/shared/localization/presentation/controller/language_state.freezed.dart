// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LanguageState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LanguageState()';
}


}

/// @nodoc
class $LanguageStateCopyWith<$Res>  {
$LanguageStateCopyWith(LanguageState _, $Res Function(LanguageState) __);
}


/// Adds pattern-matching-related methods to [LanguageState].
extension LanguageStatePatterns on LanguageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LanguageInitial value)?  initial,TResult Function( LanguageLoading value)?  loading,TResult Function( LanguageLoaded value)?  loaded,TResult Function( LanguageError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LanguageInitial() when initial != null:
return initial(_that);case LanguageLoading() when loading != null:
return loading(_that);case LanguageLoaded() when loaded != null:
return loaded(_that);case LanguageError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LanguageInitial value)  initial,required TResult Function( LanguageLoading value)  loading,required TResult Function( LanguageLoaded value)  loaded,required TResult Function( LanguageError value)  error,}){
final _that = this;
switch (_that) {
case LanguageInitial():
return initial(_that);case LanguageLoading():
return loading(_that);case LanguageLoaded():
return loaded(_that);case LanguageError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LanguageInitial value)?  initial,TResult? Function( LanguageLoading value)?  loading,TResult? Function( LanguageLoaded value)?  loaded,TResult? Function( LanguageError value)?  error,}){
final _that = this;
switch (_that) {
case LanguageInitial() when initial != null:
return initial(_that);case LanguageLoading() when loading != null:
return loading(_that);case LanguageLoaded() when loaded != null:
return loaded(_that);case LanguageError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( LanguageEntity language)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LanguageInitial() when initial != null:
return initial();case LanguageLoading() when loading != null:
return loading();case LanguageLoaded() when loaded != null:
return loaded(_that.language);case LanguageError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( LanguageEntity language)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case LanguageInitial():
return initial();case LanguageLoading():
return loading();case LanguageLoaded():
return loaded(_that.language);case LanguageError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( LanguageEntity language)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case LanguageInitial() when initial != null:
return initial();case LanguageLoading() when loading != null:
return loading();case LanguageLoaded() when loaded != null:
return loaded(_that.language);case LanguageError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class LanguageInitial implements LanguageState {
  const LanguageInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LanguageState.initial()';
}


}




/// @nodoc


class LanguageLoading implements LanguageState {
  const LanguageLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LanguageState.loading()';
}


}




/// @nodoc


class LanguageLoaded implements LanguageState {
  const LanguageLoaded(this.language);
  

 final  LanguageEntity language;

/// Create a copy of LanguageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageLoadedCopyWith<LanguageLoaded> get copyWith => _$LanguageLoadedCopyWithImpl<LanguageLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageLoaded&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,language);

@override
String toString() {
  return 'LanguageState.loaded(language: $language)';
}


}

/// @nodoc
abstract mixin class $LanguageLoadedCopyWith<$Res> implements $LanguageStateCopyWith<$Res> {
  factory $LanguageLoadedCopyWith(LanguageLoaded value, $Res Function(LanguageLoaded) _then) = _$LanguageLoadedCopyWithImpl;
@useResult
$Res call({
 LanguageEntity language
});




}
/// @nodoc
class _$LanguageLoadedCopyWithImpl<$Res>
    implements $LanguageLoadedCopyWith<$Res> {
  _$LanguageLoadedCopyWithImpl(this._self, this._then);

  final LanguageLoaded _self;
  final $Res Function(LanguageLoaded) _then;

/// Create a copy of LanguageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? language = null,}) {
  return _then(LanguageLoaded(
null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as LanguageEntity,
  ));
}


}

/// @nodoc


class LanguageError implements LanguageState {
  const LanguageError(this.message);
  

 final  String message;

/// Create a copy of LanguageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageErrorCopyWith<LanguageError> get copyWith => _$LanguageErrorCopyWithImpl<LanguageError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LanguageState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $LanguageErrorCopyWith<$Res> implements $LanguageStateCopyWith<$Res> {
  factory $LanguageErrorCopyWith(LanguageError value, $Res Function(LanguageError) _then) = _$LanguageErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LanguageErrorCopyWithImpl<$Res>
    implements $LanguageErrorCopyWith<$Res> {
  _$LanguageErrorCopyWithImpl(this._self, this._then);

  final LanguageError _self;
  final $Res Function(LanguageError) _then;

/// Create a copy of LanguageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LanguageError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
