class PaymentEntity {
  final int? id;
  final double totalPrice;
  final List<Map<String, String>> productDetails;
  final int userId;
  final String userNickname;
  final DateTime paymentDateTime;

  PaymentEntity({
    this.id,
    required this.totalPrice,
    required this.productDetails,
    required this.userId,
    required this.userNickname,
    required this.paymentDateTime,
  });
}
