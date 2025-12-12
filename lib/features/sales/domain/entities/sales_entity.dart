import 'package:equatable/equatable.dart';

/// Sales Entity - represents a sales invoice
class SalesEntity extends Equatable {
  final String invoiceUuid;
  final String? customerInfo;
  final DateTime invoiceDate;
  final double totalAmount;
  final String salesSource; // LOCAL, ONLINE
  final String status; // PENDING, COMPLETED, CANCELLED
  final String userUuid;
  final String? notes;
  final int syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SalesItemEntity> items;

  const SalesEntity({
    required this.invoiceUuid,
    this.customerInfo,
    required this.invoiceDate,
    this.totalAmount = 0.0,
    this.salesSource = 'LOCAL',
    this.status = 'COMPLETED',
    required this.userUuid,
    this.notes,
    this.syncStatus = 0,
    required this.createdAt,
    required this.updatedAt,
    this.items = const [],
  });

  double get totalProfit {
    return items.fold<double>(0.0, (sum, item) => sum + item.profit);
  }

  @override
  List<Object?> get props => [
    invoiceUuid,
    customerInfo,
    invoiceDate,
    totalAmount,
    salesSource,
    status,
    userUuid,
    notes,
    syncStatus,
    createdAt,
    updatedAt,
    items,
  ];

  SalesEntity copyWith({
    String? invoiceUuid,
    String? customerInfo,
    DateTime? invoiceDate,
    double? totalAmount,
    String? salesSource,
    String? status,
    String? userUuid,
    String? notes,
    int? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<SalesItemEntity>? items,
  }) {
    return SalesEntity(
      invoiceUuid: invoiceUuid ?? this.invoiceUuid,
      customerInfo: customerInfo ?? this.customerInfo,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      totalAmount: totalAmount ?? this.totalAmount,
      salesSource: salesSource ?? this.salesSource,
      status: status ?? this.status,
      userUuid: userUuid ?? this.userUuid,
      notes: notes ?? this.notes,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }
}

/// Sales Item Entity - represents a single product line in a sale
class SalesItemEntity extends Equatable {
  final String itemUuid;
  final String invoiceUuid;
  final String productUuid;
  final String? productName; // For display purposes
  final int quantity;
  final double unitSellPrice;
  final double costAtSale; // avgBuyPrice at time of sale
  final double totalPrice;
  final double profit; // (unitSellPrice - costAtSale) × quantity

  const SalesItemEntity({
    required this.itemUuid,
    required this.invoiceUuid,
    required this.productUuid,
    this.productName,
    required this.quantity,
    required this.unitSellPrice,
    required this.costAtSale,
    this.totalPrice = 0.0,
    this.profit = 0.0,
  });

  /// Calculate profit
  double get calculatedProfit => (unitSellPrice - costAtSale) * quantity;

  /// Calculate total price
  double get calculatedTotalPrice => unitSellPrice * quantity;

  @override
  List<Object?> get props => [
    itemUuid,
    invoiceUuid,
    productUuid,
    productName,
    quantity,
    unitSellPrice,
    costAtSale,
    totalPrice,
    profit,
  ];

  SalesItemEntity copyWith({
    String? itemUuid,
    String? invoiceUuid,
    String? productUuid,
    String? productName,
    int? quantity,
    double? unitSellPrice,
    double? costAtSale,
    double? totalPrice,
    double? profit,
  }) {
    return SalesItemEntity(
      itemUuid: itemUuid ?? this.itemUuid,
      invoiceUuid: invoiceUuid ?? this.invoiceUuid,
      productUuid: productUuid ?? this.productUuid,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitSellPrice: unitSellPrice ?? this.unitSellPrice,
      costAtSale: costAtSale ?? this.costAtSale,
      totalPrice: totalPrice ?? this.totalPrice,
      profit: profit ?? this.profit,
    );
  }
}
