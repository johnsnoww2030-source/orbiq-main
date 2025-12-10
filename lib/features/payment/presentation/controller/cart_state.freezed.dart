// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartState()';
}


}

/// @nodoc
class $CartStateCopyWith<$Res>  {
$CartStateCopyWith(CartState _, $Res Function(CartState) __);
}


/// Adds pattern-matching-related methods to [CartState].
extension CartStatePatterns on CartState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CartInitial value)?  initial,TResult Function( CartUpdated value)?  updated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CartInitial() when initial != null:
return initial(_that);case CartUpdated() when updated != null:
return updated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CartInitial value)  initial,required TResult Function( CartUpdated value)  updated,}){
final _that = this;
switch (_that) {
case CartInitial():
return initial(_that);case CartUpdated():
return updated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CartInitial value)?  initial,TResult? Function( CartUpdated value)?  updated,}){
final _that = this;
switch (_that) {
case CartInitial() when initial != null:
return initial(_that);case CartUpdated() when updated != null:
return updated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<ProductEntity> items)?  updated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CartInitial() when initial != null:
return initial();case CartUpdated() when updated != null:
return updated(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<ProductEntity> items)  updated,}) {final _that = this;
switch (_that) {
case CartInitial():
return initial();case CartUpdated():
return updated(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<ProductEntity> items)?  updated,}) {final _that = this;
switch (_that) {
case CartInitial() when initial != null:
return initial();case CartUpdated() when updated != null:
return updated(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class CartInitial implements CartState {
  const CartInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartState.initial()';
}


}




/// @nodoc


class CartUpdated implements CartState {
  const CartUpdated(final  List<ProductEntity> items): _items = items;
  

 final  List<ProductEntity> _items;
 List<ProductEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartUpdatedCopyWith<CartUpdated> get copyWith => _$CartUpdatedCopyWithImpl<CartUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartUpdated&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'CartState.updated(items: $items)';
}


}

/// @nodoc
abstract mixin class $CartUpdatedCopyWith<$Res> implements $CartStateCopyWith<$Res> {
  factory $CartUpdatedCopyWith(CartUpdated value, $Res Function(CartUpdated) _then) = _$CartUpdatedCopyWithImpl;
@useResult
$Res call({
 List<ProductEntity> items
});




}
/// @nodoc
class _$CartUpdatedCopyWithImpl<$Res>
    implements $CartUpdatedCopyWith<$Res> {
  _$CartUpdatedCopyWithImpl(this._self, this._then);

  final CartUpdated _self;
  final $Res Function(CartUpdated) _then;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(CartUpdated(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,
  ));
}


}

// dart format on
