import 'package:floor/floor.dart';
import '../../domain/entities/product_entity.dart';

@entity
class ProductModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final String serialNumber;
  final String description;
  final String brand;
  final String model;
  final String color;
  final String material;
  final int purchaseDate; // به int تغییر می‌دهد
  final double originalPrice;
  final double discountedPrice;
  final int? discountStartDate; // به int؟
  final int? discountEndDate; // به int؟
  final int currentStock;
  final int reorderPoint;
  final int lastStockUpdate; // به int تغییر می‌دهد
  // final String salesDates; // به String تغییر می‌دهد

  ProductModel({
    this.id, // id به عنوان پارامتر اختیاری
    required this.name,
    required this.serialNumber,
    required this.description,
    required this.brand,
    required this.model,
    required this.color,
    required this.material,
    required this.purchaseDate,
    required this.originalPrice,
    required this.discountedPrice,
    this.discountStartDate,
    this.discountEndDate,
    required this.currentStock,
    required this.reorderPoint,
    required this.lastStockUpdate,
    // required this.salesDates,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? serialNumber,
    String? description,
    String? brand,
    String? model,
    String? color,
    String? material,
    int? purchaseDate,
    double? originalPrice,
    double? discountedPrice,
    int? discountStartDate,
    int? discountEndDate,
    int? currentStock,
    int? reorderPoint,
    int? lastStockUpdate,
    // String? salesDates,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      serialNumber: serialNumber ?? this.serialNumber,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      color: color ?? this.color,
      material: material ?? this.material,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      originalPrice: originalPrice ?? this.originalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      discountStartDate: discountStartDate ?? this.discountStartDate,
      discountEndDate: discountEndDate ?? this.discountEndDate,
      currentStock: currentStock ?? this.currentStock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      lastStockUpdate: lastStockUpdate ?? this.lastStockUpdate,
      // salesDates: salesDates ?? this.salesDates,
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id, // دریافت id از entity
      name: entity.name,
      serialNumber: entity.serialNumber,
      description: entity.description,
      brand: entity.brand,
      model: entity.model,
      color: entity.color,
      material: entity.material,
      purchaseDate: entity.purchaseDate.millisecondsSinceEpoch,
      originalPrice: entity.originalPrice,
      discountedPrice: entity.discountedPrice,
      discountStartDate: entity.discountStartDate?.millisecondsSinceEpoch,
      discountEndDate: entity.discountEndDate?.millisecondsSinceEpoch,
      currentStock: entity.currentStock,
      reorderPoint: entity.reorderPoint,
      lastStockUpdate: entity.lastStockUpdate.millisecondsSinceEpoch,
      // salesDates: entity.salesDates.map((date) => date.millisecondsSinceEpoch.toString()).join(','),
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id, // اگر id خالی بود، می‌توانید مقدار 0 یا مقدار پیش‌فرض دیگری قرار دهید
      name: name,
      serialNumber: serialNumber,
      description: description,
      brand: brand,
      model: model,
      color: color,
      material: material,
      purchaseDate: DateTime.fromMillisecondsSinceEpoch(purchaseDate),
      originalPrice: originalPrice,
      discountedPrice: discountedPrice,
      discountStartDate: discountStartDate != null ? DateTime.fromMillisecondsSinceEpoch(discountStartDate!) : null,
      discountEndDate: discountEndDate != null ? DateTime.fromMillisecondsSinceEpoch(discountEndDate!) : null,
      currentStock: currentStock,
      reorderPoint: reorderPoint,
      lastStockUpdate: DateTime.fromMillisecondsSinceEpoch(lastStockUpdate),
      // salesDates: salesDates.split(',').map((dateString) => DateTime.fromMillisecondsSinceEpoch(int.parse(dateString))).toList(),
    );
  }
}
