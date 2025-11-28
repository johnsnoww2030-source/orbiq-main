import 'package:orbiq/core/shared/product/domain/entities/product_entity.dart';

/// Factory class for creating mock data for testing
class MockFactory {
  /// Create a mock product entity
  static ProductEntity createProduct({
    int? id,
    String name = 'Test Product',
    String serialNumber = 'SN123456',
    String description = 'A test product for unit testing',
    String brand = 'Test Brand',
    String model = 'Test Model',
    String color = 'Red',
    String material = 'Plastic',
    DateTime? purchaseDate,
    double originalPrice = 100.0,
    double discountedPrice = 90.0,
    DateTime? discountStartDate,
    DateTime? discountEndDate,
    int currentStock = 10,
    int reorderPoint = 5,
    DateTime? lastStockUpdate,
  }) {
    return ProductEntity(
      id: id,
      name: name,
      serialNumber: serialNumber,
      description: description,
      brand: brand,
      model: model,
      color: color,
      material: material,
      purchaseDate: purchaseDate ?? DateTime.now(),
      originalPrice: originalPrice,
      discountedPrice: discountedPrice,
      discountStartDate: discountStartDate,
      discountEndDate: discountEndDate,
      currentStock: currentStock,
      reorderPoint: reorderPoint,
      lastStockUpdate: lastStockUpdate ?? DateTime.now(),
    );
  }
}
