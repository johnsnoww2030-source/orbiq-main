import 'package:dartz/dartz.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';
import 'package:orbiq/features/payment/data/repositories/payment_repositroy_impl.dart'; // Import PaginatedPayments
import 'package:orbiq/features/payment/domain/entities/payment_entity.dart';

abstract class PaymentRepository {
  Future<Either<Failure, void>> savePayment(PaymentEntity payment);
  Future<Either<Failure, List<PaymentEntity>>> getPaymentsByUserId(int userId);
  Future<Either<Failure, PaginatedPayments>> getAllPayments( // Updated method
      {required int page, required int limit});
  Future<Either<Failure, List<PaymentEntity>>> getPaymentsByUserIdAndNickname(int userId, String nickname);
}
