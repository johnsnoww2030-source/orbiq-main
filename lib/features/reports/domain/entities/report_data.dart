import 'package:equatable/equatable.dart';

/// Data class for daily sales chart
class DailySalesData extends Equatable {
  final DateTime date;
  final double revenue;

  const DailySalesData({required this.date, required this.revenue});

  @override
  List<Object?> get props => [date, revenue];
}

/// Data class for top selling products
class TopProductData extends Equatable {
  final String productUuid;
  final String productName;
  final int quantity;
  final double revenue;

  const TopProductData({
    required this.productUuid,
    required this.productName,
    required this.quantity,
    required this.revenue,
  });

  @override
  List<Object?> get props => [productUuid, productName, quantity, revenue];
}
