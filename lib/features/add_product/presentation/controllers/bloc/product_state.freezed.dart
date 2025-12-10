// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState()';
}


}

/// @nodoc
class $ProductStateCopyWith<$Res>  {
$ProductStateCopyWith(ProductState _, $Res Function(ProductState) __);
}


/// Adds pattern-matching-related methods to [ProductState].
extension ProductStatePatterns on ProductState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductInitial value)?  initial,TResult Function( ProductLoading value)?  loading,TResult Function( ProductAdded value)?  added,TResult Function( ProductError value)?  error,TResult Function( ProductUpdated value)?  updated,TResult Function( ProductUpdatedSuccess value)?  updatedSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductInitial() when initial != null:
return initial(_that);case ProductLoading() when loading != null:
return loading(_that);case ProductAdded() when added != null:
return added(_that);case ProductError() when error != null:
return error(_that);case ProductUpdated() when updated != null:
return updated(_that);case ProductUpdatedSuccess() when updatedSuccess != null:
return updatedSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductInitial value)  initial,required TResult Function( ProductLoading value)  loading,required TResult Function( ProductAdded value)  added,required TResult Function( ProductError value)  error,required TResult Function( ProductUpdated value)  updated,required TResult Function( ProductUpdatedSuccess value)  updatedSuccess,}){
final _that = this;
switch (_that) {
case ProductInitial():
return initial(_that);case ProductLoading():
return loading(_that);case ProductAdded():
return added(_that);case ProductError():
return error(_that);case ProductUpdated():
return updated(_that);case ProductUpdatedSuccess():
return updatedSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductInitial value)?  initial,TResult? Function( ProductLoading value)?  loading,TResult? Function( ProductAdded value)?  added,TResult? Function( ProductError value)?  error,TResult? Function( ProductUpdated value)?  updated,TResult? Function( ProductUpdatedSuccess value)?  updatedSuccess,}){
final _that = this;
switch (_that) {
case ProductInitial() when initial != null:
return initial(_that);case ProductLoading() when loading != null:
return loading(_that);case ProductAdded() when added != null:
return added(_that);case ProductError() when error != null:
return error(_that);case ProductUpdated() when updated != null:
return updated(_that);case ProductUpdatedSuccess() when updatedSuccess != null:
return updatedSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  added,TResult Function( String message)?  error,TResult Function( ProductEntity updatedProduct)?  updated,TResult Function( ProductEntity updatedProduct)?  updatedSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductInitial() when initial != null:
return initial();case ProductLoading() when loading != null:
return loading();case ProductAdded() when added != null:
return added();case ProductError() when error != null:
return error(_that.message);case ProductUpdated() when updated != null:
return updated(_that.updatedProduct);case ProductUpdatedSuccess() when updatedSuccess != null:
return updatedSuccess(_that.updatedProduct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  added,required TResult Function( String message)  error,required TResult Function( ProductEntity updatedProduct)  updated,required TResult Function( ProductEntity updatedProduct)  updatedSuccess,}) {final _that = this;
switch (_that) {
case ProductInitial():
return initial();case ProductLoading():
return loading();case ProductAdded():
return added();case ProductError():
return error(_that.message);case ProductUpdated():
return updated(_that.updatedProduct);case ProductUpdatedSuccess():
return updatedSuccess(_that.updatedProduct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  added,TResult? Function( String message)?  error,TResult? Function( ProductEntity updatedProduct)?  updated,TResult? Function( ProductEntity updatedProduct)?  updatedSuccess,}) {final _that = this;
switch (_that) {
case ProductInitial() when initial != null:
return initial();case ProductLoading() when loading != null:
return loading();case ProductAdded() when added != null:
return added();case ProductError() when error != null:
return error(_that.message);case ProductUpdated() when updated != null:
return updated(_that.updatedProduct);case ProductUpdatedSuccess() when updatedSuccess != null:
return updatedSuccess(_that.updatedProduct);case _:
  return null;

}
}

}

/// @nodoc


class ProductInitial implements ProductState {
  const ProductInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState.initial()';
}


}




/// @nodoc


class ProductLoading implements ProductState {
  const ProductLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState.loading()';
}


}




/// @nodoc


class ProductAdded implements ProductState {
  const ProductAdded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductAdded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState.added()';
}


}




/// @nodoc


class ProductError implements ProductState {
  const ProductError(this.message);
  

 final  String message;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductErrorCopyWith<ProductError> get copyWith => _$ProductErrorCopyWithImpl<ProductError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProductState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ProductErrorCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductErrorCopyWith(ProductError value, $Res Function(ProductError) _then) = _$ProductErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ProductErrorCopyWithImpl<$Res>
    implements $ProductErrorCopyWith<$Res> {
  _$ProductErrorCopyWithImpl(this._self, this._then);

  final ProductError _self;
  final $Res Function(ProductError) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ProductError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProductUpdated implements ProductState {
  const ProductUpdated(this.updatedProduct);
  

 final  ProductEntity updatedProduct;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductUpdatedCopyWith<ProductUpdated> get copyWith => _$ProductUpdatedCopyWithImpl<ProductUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductUpdated&&(identical(other.updatedProduct, updatedProduct) || other.updatedProduct == updatedProduct));
}


@override
int get hashCode => Object.hash(runtimeType,updatedProduct);

@override
String toString() {
  return 'ProductState.updated(updatedProduct: $updatedProduct)';
}


}

/// @nodoc
abstract mixin class $ProductUpdatedCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductUpdatedCopyWith(ProductUpdated value, $Res Function(ProductUpdated) _then) = _$ProductUpdatedCopyWithImpl;
@useResult
$Res call({
 ProductEntity updatedProduct
});




}
/// @nodoc
class _$ProductUpdatedCopyWithImpl<$Res>
    implements $ProductUpdatedCopyWith<$Res> {
  _$ProductUpdatedCopyWithImpl(this._self, this._then);

  final ProductUpdated _self;
  final $Res Function(ProductUpdated) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? updatedProduct = null,}) {
  return _then(ProductUpdated(
null == updatedProduct ? _self.updatedProduct : updatedProduct // ignore: cast_nullable_to_non_nullable
as ProductEntity,
  ));
}


}

/// @nodoc


class ProductUpdatedSuccess implements ProductState {
  const ProductUpdatedSuccess(this.updatedProduct);
  

 final  ProductEntity updatedProduct;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductUpdatedSuccessCopyWith<ProductUpdatedSuccess> get copyWith => _$ProductUpdatedSuccessCopyWithImpl<ProductUpdatedSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductUpdatedSuccess&&(identical(other.updatedProduct, updatedProduct) || other.updatedProduct == updatedProduct));
}


@override
int get hashCode => Object.hash(runtimeType,updatedProduct);

@override
String toString() {
  return 'ProductState.updatedSuccess(updatedProduct: $updatedProduct)';
}


}

/// @nodoc
abstract mixin class $ProductUpdatedSuccessCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductUpdatedSuccessCopyWith(ProductUpdatedSuccess value, $Res Function(ProductUpdatedSuccess) _then) = _$ProductUpdatedSuccessCopyWithImpl;
@useResult
$Res call({
 ProductEntity updatedProduct
});




}
/// @nodoc
class _$ProductUpdatedSuccessCopyWithImpl<$Res>
    implements $ProductUpdatedSuccessCopyWith<$Res> {
  _$ProductUpdatedSuccessCopyWithImpl(this._self, this._then);

  final ProductUpdatedSuccess _self;
  final $Res Function(ProductUpdatedSuccess) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? updatedProduct = null,}) {
  return _then(ProductUpdatedSuccess(
null == updatedProduct ? _self.updatedProduct : updatedProduct // ignore: cast_nullable_to_non_nullable
as ProductEntity,
  ));
}


}

// dart format on
