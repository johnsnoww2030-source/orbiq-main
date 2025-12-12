import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int? id; // Legacy id (optional)
  final String? uuid; // UUID for Drift
  final String name;
  final String serialNumber;
  final String description;
  final String brand;
  final String model;
  final String color;
  final String material;
  final DateTime purchaseDate;
  final double originalPrice;
  final double discountedPrice;
  final DateTime? discountStartDate;
  final DateTime? discountEndDate;
  final int currentStock;
  final int reorderPoint;
  final DateTime lastStockUpdate;

  const ProductEntity({
    this.id,
    this.uuid,
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
  });

  @override
  List<Object?> get props => [
    id,
    uuid,
    name,
    serialNumber,
    description,
    brand,
    model,
    color,
    material,
    purchaseDate,
    originalPrice,
    discountedPrice,
    discountStartDate,
    discountEndDate,
    currentStock,
    reorderPoint,
    lastStockUpdate,
  ];

  ProductEntity copyWith({
    int? id,
    String? uuid,
    String? name,
    String? serialNumber,
    String? description,
    String? brand,
    String? model,
    String? color,
    String? material,
    DateTime? purchaseDate,
    double? originalPrice,
    double? discountedPrice,
    DateTime? discountStartDate,
    DateTime? discountEndDate,
    int? currentStock,
    int? reorderPoint,
    DateTime? lastStockUpdate,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
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
    );
  }
}
