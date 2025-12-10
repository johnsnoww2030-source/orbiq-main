// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentState()';
}


}

/// @nodoc
class $PaymentStateCopyWith<$Res>  {
$PaymentStateCopyWith(PaymentState _, $Res Function(PaymentState) __);
}


/// Adds pattern-matching-related methods to [PaymentState].
extension PaymentStatePatterns on PaymentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PaymentInitial value)?  initial,TResult Function( PaymentLoading value)?  loading,TResult Function( PaymentLoadingPage value)?  loadingPage,TResult Function( PaymentSuccess value)?  success,TResult Function( PaymentFailure value)?  failure,TResult Function( PaymentListLoaded value)?  listLoaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PaymentInitial() when initial != null:
return initial(_that);case PaymentLoading() when loading != null:
return loading(_that);case PaymentLoadingPage() when loadingPage != null:
return loadingPage(_that);case PaymentSuccess() when success != null:
return success(_that);case PaymentFailure() when failure != null:
return failure(_that);case PaymentListLoaded() when listLoaded != null:
return listLoaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PaymentInitial value)  initial,required TResult Function( PaymentLoading value)  loading,required TResult Function( PaymentLoadingPage value)  loadingPage,required TResult Function( PaymentSuccess value)  success,required TResult Function( PaymentFailure value)  failure,required TResult Function( PaymentListLoaded value)  listLoaded,}){
final _that = this;
switch (_that) {
case PaymentInitial():
return initial(_that);case PaymentLoading():
return loading(_that);case PaymentLoadingPage():
return loadingPage(_that);case PaymentSuccess():
return success(_that);case PaymentFailure():
return failure(_that);case PaymentListLoaded():
return listLoaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PaymentInitial value)?  initial,TResult? Function( PaymentLoading value)?  loading,TResult? Function( PaymentLoadingPage value)?  loadingPage,TResult? Function( PaymentSuccess value)?  success,TResult? Function( PaymentFailure value)?  failure,TResult? Function( PaymentListLoaded value)?  listLoaded,}){
final _that = this;
switch (_that) {
case PaymentInitial() when initial != null:
return initial(_that);case PaymentLoading() when loading != null:
return loading(_that);case PaymentLoadingPage() when loadingPage != null:
return loadingPage(_that);case PaymentSuccess() when success != null:
return success(_that);case PaymentFailure() when failure != null:
return failure(_that);case PaymentListLoaded() when listLoaded != null:
return listLoaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  loadingPage,TResult Function()?  success,TResult Function( String message)?  failure,TResult Function( List<PaymentEntity> payments,  int currentPage,  int totalPages,  bool hasNextPage)?  listLoaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PaymentInitial() when initial != null:
return initial();case PaymentLoading() when loading != null:
return loading();case PaymentLoadingPage() when loadingPage != null:
return loadingPage();case PaymentSuccess() when success != null:
return success();case PaymentFailure() when failure != null:
return failure(_that.message);case PaymentListLoaded() when listLoaded != null:
return listLoaded(_that.payments,_that.currentPage,_that.totalPages,_that.hasNextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  loadingPage,required TResult Function()  success,required TResult Function( String message)  failure,required TResult Function( List<PaymentEntity> payments,  int currentPage,  int totalPages,  bool hasNextPage)  listLoaded,}) {final _that = this;
switch (_that) {
case PaymentInitial():
return initial();case PaymentLoading():
return loading();case PaymentLoadingPage():
return loadingPage();case PaymentSuccess():
return success();case PaymentFailure():
return failure(_that.message);case PaymentListLoaded():
return listLoaded(_that.payments,_that.currentPage,_that.totalPages,_that.hasNextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  loadingPage,TResult? Function()?  success,TResult? Function( String message)?  failure,TResult? Function( List<PaymentEntity> payments,  int currentPage,  int totalPages,  bool hasNextPage)?  listLoaded,}) {final _that = this;
switch (_that) {
case PaymentInitial() when initial != null:
return initial();case PaymentLoading() when loading != null:
return loading();case PaymentLoadingPage() when loadingPage != null:
return loadingPage();case PaymentSuccess() when success != null:
return success();case PaymentFailure() when failure != null:
return failure(_that.message);case PaymentListLoaded() when listLoaded != null:
return listLoaded(_that.payments,_that.currentPage,_that.totalPages,_that.hasNextPage);case _:
  return null;

}
}

}

/// @nodoc


class PaymentInitial implements PaymentState {
  const PaymentInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentState.initial()';
}


}




/// @nodoc


class PaymentLoading implements PaymentState {
  const PaymentLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentState.loading()';
}


}




/// @nodoc


class PaymentLoadingPage implements PaymentState {
  const PaymentLoadingPage();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentLoadingPage);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentState.loadingPage()';
}


}




/// @nodoc


class PaymentSuccess implements PaymentState {
  const PaymentSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentState.success()';
}


}




/// @nodoc


class PaymentFailure implements PaymentState {
  const PaymentFailure(this.message);
  

 final  String message;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentFailureCopyWith<PaymentFailure> get copyWith => _$PaymentFailureCopyWithImpl<PaymentFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PaymentState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $PaymentFailureCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory $PaymentFailureCopyWith(PaymentFailure value, $Res Function(PaymentFailure) _then) = _$PaymentFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PaymentFailureCopyWithImpl<$Res>
    implements $PaymentFailureCopyWith<$Res> {
  _$PaymentFailureCopyWithImpl(this._self, this._then);

  final PaymentFailure _self;
  final $Res Function(PaymentFailure) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PaymentFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PaymentListLoaded implements PaymentState {
  const PaymentListLoaded({required final  List<PaymentEntity> payments, required this.currentPage, required this.totalPages, required this.hasNextPage}): _payments = payments;
  

 final  List<PaymentEntity> _payments;
 List<PaymentEntity> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}

 final  int currentPage;
 final  int totalPages;
 final  bool hasNextPage;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentListLoadedCopyWith<PaymentListLoaded> get copyWith => _$PaymentListLoadedCopyWithImpl<PaymentListLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentListLoaded&&const DeepCollectionEquality().equals(other._payments, _payments)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_payments),currentPage,totalPages,hasNextPage);

@override
String toString() {
  return 'PaymentState.listLoaded(payments: $payments, currentPage: $currentPage, totalPages: $totalPages, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class $PaymentListLoadedCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory $PaymentListLoadedCopyWith(PaymentListLoaded value, $Res Function(PaymentListLoaded) _then) = _$PaymentListLoadedCopyWithImpl;
@useResult
$Res call({
 List<PaymentEntity> payments, int currentPage, int totalPages, bool hasNextPage
});




}
/// @nodoc
class _$PaymentListLoadedCopyWithImpl<$Res>
    implements $PaymentListLoadedCopyWith<$Res> {
  _$PaymentListLoadedCopyWithImpl(this._self, this._then);

  final PaymentListLoaded _self;
  final $Res Function(PaymentListLoaded) _then;

/// Create a copy of PaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? payments = null,Object? currentPage = null,Object? totalPages = null,Object? hasNextPage = null,}) {
  return _then(PaymentListLoaded(
payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<PaymentEntity>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
