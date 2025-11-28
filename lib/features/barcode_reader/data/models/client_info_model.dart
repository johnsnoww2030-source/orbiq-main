// data/models/client_info_model.dart
import 'dart:io';

class ClientInfoModel {
  final Socket socket; // اضافه کردن این خط
  final String address;
  final DateTime connectedAt;

  ClientInfoModel({
    required this.socket, // اضافه کردن این خط
    required this.address,
    required this.connectedAt,
  });

  // نیازی به متدهای fromJson و toJson در اینجا نیست مگر اینکه بخواهید سریال‌سازی کنید
}
