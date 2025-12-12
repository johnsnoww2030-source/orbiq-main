import 'package:equatable/equatable.dart';

sealed class GetProductEvent extends Equatable {
  const GetProductEvent();
}

class LoadProducts extends GetProductEvent {
  final int page;
  final int limit;

  const LoadProducts({this.page = 1, this.limit = 20});

  @override
  List<Object?> get props => [page, limit];
}

class LoadProductPageEvent extends GetProductEvent {
  final int page;

  const LoadProductPageEvent(this.page);

  @override
  List<Object?> get props => [page];
}

class SearchProductBySerial extends GetProductEvent {
  final String serialNumber;

  const SearchProductBySerial(this.serialNumber);

  @override
  List<Object?> get props => [serialNumber];
}
