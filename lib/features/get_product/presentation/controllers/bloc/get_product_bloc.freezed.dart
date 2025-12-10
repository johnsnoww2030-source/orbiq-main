// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetProductEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetProductEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetProductEvent()';
}


}

/// @nodoc
class $GetProductEventCopyWith<$Res>  {
$GetProductEventCopyWith(GetProductEvent _, $Res Function(GetProductEvent) __);
}


/// Adds pattern-matching-related methods to [GetProductEvent].
extension GetProductEventPatterns on GetProductEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadProducts value)?  loadProducts,TResult Function( LoadProductPageEvent value)?  loadProductPage,TResult Function( SearchProductBySerial value)?  searchBySerial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadProducts() when loadProducts != null:
return loadProducts(_that);case LoadProductPageEvent() when loadProductPage != null:
return loadProductPage(_that);case SearchProductBySerial() when searchBySerial != null:
return searchBySerial(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadProducts value)  loadProducts,required TResult Function( LoadProductPageEvent value)  loadProductPage,required TResult Function( SearchProductBySerial value)  searchBySerial,}){
final _that = this;
switch (_that) {
case LoadProducts():
return loadProducts(_that);case LoadProductPageEvent():
return loadProductPage(_that);case SearchProductBySerial():
return searchBySerial(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadProducts value)?  loadProducts,TResult? Function( LoadProductPageEvent value)?  loadProductPage,TResult? Function( SearchProductBySerial value)?  searchBySerial,}){
final _that = this;
switch (_that) {
case LoadProducts() when loadProducts != null:
return loadProducts(_that);case LoadProductPageEvent() when loadProductPage != null:
return loadProductPage(_that);case SearchProductBySerial() when searchBySerial != null:
return searchBySerial(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  int limit)?  loadProducts,TResult Function( int page)?  loadProductPage,TResult Function( String serialNumber)?  searchBySerial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadProducts() when loadProducts != null:
return loadProducts(_that.page,_that.limit);case LoadProductPageEvent() when loadProductPage != null:
return loadProductPage(_that.page);case SearchProductBySerial() when searchBySerial != null:
return searchBySerial(_that.serialNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  int limit)  loadProducts,required TResult Function( int page)  loadProductPage,required TResult Function( String serialNumber)  searchBySerial,}) {final _that = this;
switch (_that) {
case LoadProducts():
return loadProducts(_that.page,_that.limit);case LoadProductPageEvent():
return loadProductPage(_that.page);case SearchProductBySerial():
return searchBySerial(_that.serialNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  int limit)?  loadProducts,TResult? Function( int page)?  loadProductPage,TResult? Function( String serialNumber)?  searchBySerial,}) {final _that = this;
switch (_that) {
case LoadProducts() when loadProducts != null:
return loadProducts(_that.page,_that.limit);case LoadProductPageEvent() when loadProductPage != null:
return loadProductPage(_that.page);case SearchProductBySerial() when searchBySerial != null:
return searchBySerial(_that.serialNumber);case _:
  return null;

}
}

}

/// @nodoc


class LoadProducts implements GetProductEvent {
  const LoadProducts({this.page = 1, this.limit = 20});
  

@JsonKey() final  int page;
@JsonKey() final  int limit;

/// Create a copy of GetProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadProductsCopyWith<LoadProducts> get copyWith => _$LoadProductsCopyWithImpl<LoadProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadProducts&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,page,limit);

@override
String toString() {
  return 'GetProductEvent.loadProducts(page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $LoadProductsCopyWith<$Res> implements $GetProductEventCopyWith<$Res> {
  factory $LoadProductsCopyWith(LoadProducts value, $Res Function(LoadProducts) _then) = _$LoadProductsCopyWithImpl;
@useResult
$Res call({
 int page, int limit
});




}
/// @nodoc
class _$LoadProductsCopyWithImpl<$Res>
    implements $LoadProductsCopyWith<$Res> {
  _$LoadProductsCopyWithImpl(this._self, this._then);

  final LoadProducts _self;
  final $Res Function(LoadProducts) _then;

/// Create a copy of GetProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? limit = null,}) {
  return _then(LoadProducts(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class LoadProductPageEvent implements GetProductEvent {
  const LoadProductPageEvent(this.page);
  

 final  int page;

/// Create a copy of GetProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadProductPageEventCopyWith<LoadProductPageEvent> get copyWith => _$LoadProductPageEventCopyWithImpl<LoadProductPageEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadProductPageEvent&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,page);

@override
String toString() {
  return 'GetProductEvent.loadProductPage(page: $page)';
}


}

/// @nodoc
abstract mixin class $LoadProductPageEventCopyWith<$Res> implements $GetProductEventCopyWith<$Res> {
  factory $LoadProductPageEventCopyWith(LoadProductPageEvent value, $Res Function(LoadProductPageEvent) _then) = _$LoadProductPageEventCopyWithImpl;
@useResult
$Res call({
 int page
});




}
/// @nodoc
class _$LoadProductPageEventCopyWithImpl<$Res>
    implements $LoadProductPageEventCopyWith<$Res> {
  _$LoadProductPageEventCopyWithImpl(this._self, this._then);

  final LoadProductPageEvent _self;
  final $Res Function(LoadProductPageEvent) _then;

/// Create a copy of GetProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,}) {
  return _then(LoadProductPageEvent(
null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SearchProductBySerial implements GetProductEvent {
  const SearchProductBySerial(this.serialNumber);
  

 final  String serialNumber;

/// Create a copy of GetProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchProductBySerialCopyWith<SearchProductBySerial> get copyWith => _$SearchProductBySerialCopyWithImpl<SearchProductBySerial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchProductBySerial&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber));
}


@override
int get hashCode => Object.hash(runtimeType,serialNumber);

@override
String toString() {
  return 'GetProductEvent.searchBySerial(serialNumber: $serialNumber)';
}


}

/// @nodoc
abstract mixin class $SearchProductBySerialCopyWith<$Res> implements $GetProductEventCopyWith<$Res> {
  factory $SearchProductBySerialCopyWith(SearchProductBySerial value, $Res Function(SearchProductBySerial) _then) = _$SearchProductBySerialCopyWithImpl;
@useResult
$Res call({
 String serialNumber
});




}
/// @nodoc
class _$SearchProductBySerialCopyWithImpl<$Res>
    implements $SearchProductBySerialCopyWith<$Res> {
  _$SearchProductBySerialCopyWithImpl(this._self, this._then);

  final SearchProductBySerial _self;
  final $Res Function(SearchProductBySerial) _then;

/// Create a copy of GetProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serialNumber = null,}) {
  return _then(SearchProductBySerial(
null == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$GetProductState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetProductState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetProductState()';
}


}

/// @nodoc
class $GetProductStateCopyWith<$Res>  {
$GetProductStateCopyWith(GetProductState _, $Res Function(GetProductState) __);
}


/// Adds pattern-matching-related methods to [GetProductState].
extension GetProductStatePatterns on GetProductState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GetProductInitial value)?  initial,TResult Function( ProductLoading value)?  loading,TResult Function( ProductLoadingPage value)?  loadingPage,TResult Function( ProductLoaded value)?  loaded,TResult Function( ProductFound value)?  found,TResult Function( ProductNotFound value)?  notFound,TResult Function( ProductError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GetProductInitial() when initial != null:
return initial(_that);case ProductLoading() when loading != null:
return loading(_that);case ProductLoadingPage() when loadingPage != null:
return loadingPage(_that);case ProductLoaded() when loaded != null:
return loaded(_that);case ProductFound() when found != null:
return found(_that);case ProductNotFound() when notFound != null:
return notFound(_that);case ProductError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GetProductInitial value)  initial,required TResult Function( ProductLoading value)  loading,required TResult Function( ProductLoadingPage value)  loadingPage,required TResult Function( ProductLoaded value)  loaded,required TResult Function( ProductFound value)  found,required TResult Function( ProductNotFound value)  notFound,required TResult Function( ProductError value)  error,}){
final _that = this;
switch (_that) {
case GetProductInitial():
return initial(_that);case ProductLoading():
return loading(_that);case ProductLoadingPage():
return loadingPage(_that);case ProductLoaded():
return loaded(_that);case ProductFound():
return found(_that);case ProductNotFound():
return notFound(_that);case ProductError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GetProductInitial value)?  initial,TResult? Function( ProductLoading value)?  loading,TResult? Function( ProductLoadingPage value)?  loadingPage,TResult? Function( ProductLoaded value)?  loaded,TResult? Function( ProductFound value)?  found,TResult? Function( ProductNotFound value)?  notFound,TResult? Function( ProductError value)?  error,}){
final _that = this;
switch (_that) {
case GetProductInitial() when initial != null:
return initial(_that);case ProductLoading() when loading != null:
return loading(_that);case ProductLoadingPage() when loadingPage != null:
return loadingPage(_that);case ProductLoaded() when loaded != null:
return loaded(_that);case ProductFound() when found != null:
return found(_that);case ProductNotFound() when notFound != null:
return notFound(_that);case ProductError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  loadingPage,TResult Function( List<ProductModel> products,  int currentPage,  int totalPages,  bool hasNextPage)?  loaded,TResult Function( ProductModel product)?  found,TResult Function()?  notFound,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GetProductInitial() when initial != null:
return initial();case ProductLoading() when loading != null:
return loading();case ProductLoadingPage() when loadingPage != null:
return loadingPage();case ProductLoaded() when loaded != null:
return loaded(_that.products,_that.currentPage,_that.totalPages,_that.hasNextPage);case ProductFound() when found != null:
return found(_that.product);case ProductNotFound() when notFound != null:
return notFound();case ProductError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  loadingPage,required TResult Function( List<ProductModel> products,  int currentPage,  int totalPages,  bool hasNextPage)  loaded,required TResult Function( ProductModel product)  found,required TResult Function()  notFound,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case GetProductInitial():
return initial();case ProductLoading():
return loading();case ProductLoadingPage():
return loadingPage();case ProductLoaded():
return loaded(_that.products,_that.currentPage,_that.totalPages,_that.hasNextPage);case ProductFound():
return found(_that.product);case ProductNotFound():
return notFound();case ProductError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  loadingPage,TResult? Function( List<ProductModel> products,  int currentPage,  int totalPages,  bool hasNextPage)?  loaded,TResult? Function( ProductModel product)?  found,TResult? Function()?  notFound,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case GetProductInitial() when initial != null:
return initial();case ProductLoading() when loading != null:
return loading();case ProductLoadingPage() when loadingPage != null:
return loadingPage();case ProductLoaded() when loaded != null:
return loaded(_that.products,_that.currentPage,_that.totalPages,_that.hasNextPage);case ProductFound() when found != null:
return found(_that.product);case ProductNotFound() when notFound != null:
return notFound();case ProductError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class GetProductInitial implements GetProductState {
  const GetProductInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetProductInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetProductState.initial()';
}


}




/// @nodoc


class ProductLoading implements GetProductState {
  const ProductLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetProductState.loading()';
}


}




/// @nodoc


class ProductLoadingPage implements GetProductState {
  const ProductLoadingPage();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductLoadingPage);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetProductState.loadingPage()';
}


}




/// @nodoc


class ProductLoaded implements GetProductState {
  const ProductLoaded({required final  List<ProductModel> products, required this.currentPage, required this.totalPages, required this.hasNextPage}): _products = products;
  

 final  List<ProductModel> _products;
 List<ProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  int currentPage;
 final  int totalPages;
 final  bool hasNextPage;

/// Create a copy of GetProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductLoadedCopyWith<ProductLoaded> get copyWith => _$ProductLoadedCopyWithImpl<ProductLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductLoaded&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),currentPage,totalPages,hasNextPage);

@override
String toString() {
  return 'GetProductState.loaded(products: $products, currentPage: $currentPage, totalPages: $totalPages, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class $ProductLoadedCopyWith<$Res> implements $GetProductStateCopyWith<$Res> {
  factory $ProductLoadedCopyWith(ProductLoaded value, $Res Function(ProductLoaded) _then) = _$ProductLoadedCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> products, int currentPage, int totalPages, bool hasNextPage
});




}
/// @nodoc
class _$ProductLoadedCopyWithImpl<$Res>
    implements $ProductLoadedCopyWith<$Res> {
  _$ProductLoadedCopyWithImpl(this._self, this._then);

  final ProductLoaded _self;
  final $Res Function(ProductLoaded) _then;

/// Create a copy of GetProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? currentPage = null,Object? totalPages = null,Object? hasNextPage = null,}) {
  return _then(ProductLoaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ProductFound implements GetProductState {
  const ProductFound(this.product);
  

 final  ProductModel product;

/// Create a copy of GetProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFoundCopyWith<ProductFound> get copyWith => _$ProductFoundCopyWithImpl<ProductFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFound&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'GetProductState.found(product: $product)';
}


}

/// @nodoc
abstract mixin class $ProductFoundCopyWith<$Res> implements $GetProductStateCopyWith<$Res> {
  factory $ProductFoundCopyWith(ProductFound value, $Res Function(ProductFound) _then) = _$ProductFoundCopyWithImpl;
@useResult
$Res call({
 ProductModel product
});




}
/// @nodoc
class _$ProductFoundCopyWithImpl<$Res>
    implements $ProductFoundCopyWith<$Res> {
  _$ProductFoundCopyWithImpl(this._self, this._then);

  final ProductFound _self;
  final $Res Function(ProductFound) _then;

/// Create a copy of GetProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(ProductFound(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductModel,
  ));
}


}

/// @nodoc


class ProductNotFound implements GetProductState {
  const ProductNotFound();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductNotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetProductState.notFound()';
}


}




/// @nodoc


class ProductError implements GetProductState {
  const ProductError(this.message);
  

 final  String message;

/// Create a copy of GetProductState
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
  return 'GetProductState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ProductErrorCopyWith<$Res> implements $GetProductStateCopyWith<$Res> {
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

/// Create a copy of GetProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ProductError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
