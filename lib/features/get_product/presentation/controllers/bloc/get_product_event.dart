part of 'get_product_bloc.dart';

@freezed
class GetProductEvent with _$GetProductEvent {
  const factory GetProductEvent.loadProducts({
    @Default(1) int page,
    @Default(20) int limit,
  }) = LoadProducts;

  const factory GetProductEvent.loadProductPage(int page) =
      LoadProductPageEvent;

  const factory GetProductEvent.searchBySerial(String serialNumber) =
      SearchProductBySerial;
}
