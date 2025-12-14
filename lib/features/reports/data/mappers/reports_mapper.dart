import 'package:orbiq/features/reports/domain/entities/report_data.dart';

/// Mapper for converting Reports data between DAO and Entity
class ReportsMapper {
  /// Convert Map from DAO to DailySalesEntity
  static DailySalesEntity mapToDailySalesEntity(Map<String, dynamic> map) {
    return DailySalesEntity(
      date: map['date'] as DateTime,
      revenue: (map['revenue'] as double?) ?? 0.0,
    );
  }

  /// Convert Map from DAO to TopProductEntity
  static TopProductEntity mapToTopProductEntity(
    Map<String, dynamic> map,
    String productName,
  ) {
    return TopProductEntity(
      productUuid: map['productUuid'] as String,
      productName: productName,
      quantity: map['quantity'] as int,
      revenue: (map['revenue'] as double?) ?? 0.0,
    );
  }
}
