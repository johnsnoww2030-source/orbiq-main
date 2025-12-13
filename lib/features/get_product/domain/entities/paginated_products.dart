import 'package:equatable/equatable.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

/// Paginated products value object for Domain layer
class PaginatedProducts extends Equatable {
  final List<ProductEntity> products;
  final int totalProducts;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  PaginatedProducts({
    required this.products,
    required this.totalProducts,
    required this.currentPage,
    required int limit,
  }) : totalPages = limit > 0 ? (totalProducts / limit).ceil() : 0,
       hasNextPage = currentPage * limit < totalProducts,
       hasPreviousPage = currentPage > 1;

  @override
  List<Object?> get props => [
    products,
    totalProducts,
    currentPage,
    totalPages,
    hasNextPage,
    hasPreviousPage,
  ];
}
