import 'package:equatable/equatable.dart';

sealed class GetProductEvent extends Equatable {
  const GetProductEvent();
}

class ProductsLoadRequested extends GetProductEvent {
  final int page;
  final int limit;

  const ProductsLoadRequested({this.page = 1, this.limit = 20});

  @override
  List<Object?> get props => [page, limit];
}

class ProductPageLoadRequested extends GetProductEvent {
  final int page;

  const ProductPageLoadRequested(this.page);

  @override
  List<Object?> get props => [page];
}

class ProductBySerialSearchRequested extends GetProductEvent {
  final String serialNumber;

  const ProductBySerialSearchRequested(this.serialNumber);

  @override
  List<Object?> get props => [serialNumber];
}
