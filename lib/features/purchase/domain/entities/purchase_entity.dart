import 'package:equatable/equatable.dart';

/// Purchase Invoice Entity - represents a purchase from supplier
class PurchaseEntity extends Equatable {
  final String purchaseUuid;
  final String? supplierName;
  final DateTime purchaseDate;
  final double totalCost;
  final double additionalCosts;
  final double finalTotal;
  final String? notes;
  final int syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PurchaseItemEntity> items;

  const PurchaseEntity({
    required this.purchaseUuid,
    this.supplierName,
    required this.purchaseDate,
    this.totalCost = 0.0,
    this.additionalCosts = 0.0,
    this.finalTotal = 0.0,
    this.notes,
    this.syncStatus = 0,
    required this.createdAt,
    required this.updatedAt,
    this.items = const [],
  });

  PurchaseEntity copyWith({
    String? purchaseUuid,
    String? supplierName,
    DateTime? purchaseDate,
    double? totalCost,
    double? additionalCosts,
    double? finalTotal,
    String? notes,
    int? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<PurchaseItemEntity>? items,
  }) {
    return PurchaseEntity(
      purchaseUuid: purchaseUuid ?? this.purchaseUuid,
      supplierName: supplierName ?? this.supplierName,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      totalCost: totalCost ?? this.totalCost,
      additionalCosts: additionalCosts ?? this.additionalCosts,
      finalTotal: finalTotal ?? this.finalTotal,
      notes: notes ?? this.notes,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [
    purchaseUuid,
    supplierName,
    purchaseDate,
    totalCost,
    additionalCosts,
    finalTotal,
    notes,
    syncStatus,
    createdAt,
    updatedAt,
    items,
  ];
}

/// Purchase Item Entity - represents a single item in a purchase
class PurchaseItemEntity extends Equatable {
  final String itemUuid;
  final String purchaseUuid;
  final String productUuid;
  final String? productName; // For display purposes
  final int quantity;
  final double unitBuyPrice;
  final double totalPrice;

  const PurchaseItemEntity({
    required this.itemUuid,
    required this.purchaseUuid,
    required this.productUuid,
    this.productName,
    required this.quantity,
    required this.unitBuyPrice,
    required this.totalPrice,
  });

  PurchaseItemEntity copyWith({
    String? itemUuid,
    String? purchaseUuid,
    String? productUuid,
    String? productName,
    int? quantity,
    double? unitBuyPrice,
    double? totalPrice,
  }) {
    return PurchaseItemEntity(
      itemUuid: itemUuid ?? this.itemUuid,
      purchaseUuid: purchaseUuid ?? this.purchaseUuid,
      productUuid: productUuid ?? this.productUuid,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitBuyPrice: unitBuyPrice ?? this.unitBuyPrice,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [
    itemUuid,
    purchaseUuid,
    productUuid,
    productName,
    quantity,
    unitBuyPrice,
    totalPrice,
  ];
}
