import 'package:floor/floor.dart';
import 'package:orbiq/features/payment/data/model/payment_model.dart';

@dao
abstract class PaymentDao {
  @insert
  Future<void> insertPayment(PaymentModel payment);

  @Query('SELECT * FROM payments WHERE userId = :userId AND userNickname = :nickname')
  Future<List<PaymentModel>> findPaymentsByUserIdAndNickname(int userId, String nickname);

  @Query('SELECT * FROM payments WHERE userId = :userId')
  Future<List<PaymentModel>> findPaymentsByUserId(int userId);

  @Query('SELECT * FROM payments')
  Future<List<PaymentModel>> findAllPayments();
}
