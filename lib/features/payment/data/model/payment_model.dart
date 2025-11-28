import 'dart:convert';
import 'package:floor/floor.dart';

@Entity(tableName: 'payments')
class PaymentModel {
  @PrimaryKey(autoGenerate: true)
  final int? id; // فیلد id به عنوان کلید اصلی
  final double totalPrice;
  final String productDetails; // ذخیره به صورت JSON
  final int userId;
  final String userNickname;
  final int paymentDateTime;

  PaymentModel({
    this.id,
    required this.totalPrice,
    required this.productDetails, // این رشته JSON است
    required this.userId,
    required this.userNickname,
    required this.paymentDateTime,
  });

  // تابعی برای تنظیم productDetails با استفاده از لیست نقشه‌ها
  static String setProductDetails(List<Map<String, String>> details) {
    return jsonEncode(details);
  }

  List<Map<String, String>> getProductDetails() {
    return (jsonDecode(productDetails) as List<dynamic>).map((item) => Map<String, String>.from(item)).toList();
  }
}
