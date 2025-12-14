import 'package:equatable/equatable.dart';

/// Data class for daily sales chart
class DailySalesEntity extends Equatable {
  final DateTime date;
  final double revenue;

  const DailySalesEntity({required this.date, required this.revenue});

  @override
  List<Object?> get props => [date, revenue];
}

/// Data class for top selling products
class TopProductEntity extends Equatable {
  final String productUuid;
  final String productName;
  final int quantity;
  final double revenue;

  const TopProductEntity({
    required this.productUuid,
    required this.productName,
    required this.quantity,
    required this.revenue,
  });

  @override
  List<Object?> get props => [productUuid, productName, quantity, revenue];
}
