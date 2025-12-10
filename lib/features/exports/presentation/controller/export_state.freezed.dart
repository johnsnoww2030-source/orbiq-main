// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExportState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExportState()';
}


}

/// @nodoc
class $ExportStateCopyWith<$Res>  {
$ExportStateCopyWith(ExportState _, $Res Function(ExportState) __);
}


/// Adds pattern-matching-related methods to [ExportState].
extension ExportStatePatterns on ExportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExportInitial value)?  initial,TResult Function( Exporting value)?  exporting,TResult Function( ExportSuccess value)?  success,TResult Function( ExportFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExportInitial() when initial != null:
return initial(_that);case Exporting() when exporting != null:
return exporting(_that);case ExportSuccess() when success != null:
return success(_that);case ExportFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExportInitial value)  initial,required TResult Function( Exporting value)  exporting,required TResult Function( ExportSuccess value)  success,required TResult Function( ExportFailure value)  failure,}){
final _that = this;
switch (_that) {
case ExportInitial():
return initial(_that);case Exporting():
return exporting(_that);case ExportSuccess():
return success(_that);case ExportFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExportInitial value)?  initial,TResult? Function( Exporting value)?  exporting,TResult? Function( ExportSuccess value)?  success,TResult? Function( ExportFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ExportInitial() when initial != null:
return initial(_that);case Exporting() when exporting != null:
return exporting(_that);case ExportSuccess() when success != null:
return success(_that);case ExportFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  exporting,TResult Function()?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExportInitial() when initial != null:
return initial();case Exporting() when exporting != null:
return exporting();case ExportSuccess() when success != null:
return success();case ExportFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  exporting,required TResult Function()  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ExportInitial():
return initial();case Exporting():
return exporting();case ExportSuccess():
return success();case ExportFailure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  exporting,TResult? Function()?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ExportInitial() when initial != null:
return initial();case Exporting() when exporting != null:
return exporting();case ExportSuccess() when success != null:
return success();case ExportFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ExportInitial implements ExportState {
  const ExportInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExportState.initial()';
}


}




/// @nodoc


class Exporting implements ExportState {
  const Exporting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Exporting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExportState.exporting()';
}


}




/// @nodoc


class ExportSuccess implements ExportState {
  const ExportSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExportState.success()';
}


}




/// @nodoc


class ExportFailure implements ExportState {
  const ExportFailure(this.message);
  

 final  String message;

/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportFailureCopyWith<ExportFailure> get copyWith => _$ExportFailureCopyWithImpl<ExportFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ExportState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ExportFailureCopyWith<$Res> implements $ExportStateCopyWith<$Res> {
  factory $ExportFailureCopyWith(ExportFailure value, $Res Function(ExportFailure) _then) = _$ExportFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ExportFailureCopyWithImpl<$Res>
    implements $ExportFailureCopyWith<$Res> {
  _$ExportFailureCopyWithImpl(this._self, this._then);

  final ExportFailure _self;
  final $Res Function(ExportFailure) _then;

/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ExportFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
