import 'package:orbiq/features/payment/data/model/payment_model.dart';
import 'package:orbiq/features/payment/domain/entities/payment_entity.dart';

class PaymentMapper {
  // تبدیل PaymentModel به PaymentEntity
  static PaymentEntity toEntity(PaymentModel model) {
    return PaymentEntity(
      id: model.id,
      totalPrice: model.totalPrice,
      productDetails: model.getProductDetails(), // تبدیل JSON به لیست نقشه‌ها

      userId: model.userId,
      userNickname: model.userNickname,
      paymentDateTime: DateTime.fromMillisecondsSinceEpoch(model.paymentDateTime),
    );
  }

  // تبدیل PaymentEntity به PaymentModel
  static PaymentModel toModel(PaymentEntity entity) {
    return PaymentModel(
      id: entity.id,
      totalPrice: entity.totalPrice,
      productDetails: PaymentModel.setProductDetails(entity.productDetails), // تبدیل لیست نقشه‌ها به JSON
      userId: entity.userId,
      userNickname: entity.userNickname, paymentDateTime: entity.paymentDateTime.millisecondsSinceEpoch,
    );
  }
}
