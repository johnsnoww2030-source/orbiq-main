import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int? id; // id را به صورت اختیاری تعریف کنید
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
  // final List<DateTime> salesDates;

  const ProductEntity({
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

  @override
  List<Object?> get props => [
        id,
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
        // salesDates,
      ];
}
