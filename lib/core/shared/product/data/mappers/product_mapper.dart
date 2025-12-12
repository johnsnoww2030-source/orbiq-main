import 'package:drift/drift.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';
import 'package:uuid/uuid.dart';

/// Mapper for converting between Drift Product and domain ProductEntity
class ProductMapper {
  static const _uuid = Uuid();

  /// Convert domain ProductEntity to Drift ProductsCompanion for insert
  static ProductsCompanion toCompanion(
    ProductEntity entity, {
    String? existingUuid,
  }) {
    final now = DateTime.now();
    return ProductsCompanion(
      productUuid: Value(existingUuid ?? _uuid.v4()),
      name: Value(entity.name),
      serialNumber: Value(entity.serialNumber),
      description: Value(entity.description),
      brand: Value(entity.brand),
      model: Value(entity.model),
      color: Value(entity.color),
      material: Value(entity.material),
      purchaseDate: Value(entity.purchaseDate),
      originalPrice: Value(entity.originalPrice),
      discountedPrice: Value(entity.discountedPrice),
      discountStartDate: Value(entity.discountStartDate),
      discountEndDate: Value(entity.discountEndDate),
      currentStock: Value(entity.currentStock),
      reorderPoint: Value(entity.reorderPoint),
      lastStockUpdate: Value(entity.lastStockUpdate),
      avgBuyPrice: const Value(0.0),
      minMarginPercent: const Value(20),
      syncStatus: const Value(0),
      createdAt: Value(now),
      updatedAt: Value(now),
    );
  }

  /// Convert Drift Product to domain ProductEntity
  static ProductEntity toEntity(Product product) {
    return ProductEntity(
      id: null, // UUID is used instead of int id
      uuid: product.productUuid,
      name: product.name,
      serialNumber: product.serialNumber,
      description: product.description,
      brand: product.brand,
      model: product.model,
      color: product.color,
      material: product.material,
      purchaseDate: product.purchaseDate,
      originalPrice: product.originalPrice,
      discountedPrice: product.discountedPrice,
      discountStartDate: product.discountStartDate,
      discountEndDate: product.discountEndDate,
      currentStock: product.currentStock,
      reorderPoint: product.reorderPoint,
      lastStockUpdate: product.lastStockUpdate,
    );
  }

  /// Convert list of Drift Products to list of ProductEntities
  static List<ProductEntity> toEntityList(List<Product> products) {
    return products.map((p) => toEntity(p)).toList();
  }
}
