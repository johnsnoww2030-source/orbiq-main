import 'package:dartz/dartz.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';
import 'package:orbiq/features/payment/domain/entities/payment_entity.dart';
import 'package:orbiq/features/payment/domain/repositories/payment_repositroy.dart';

class GetPaymentsByUserIdAndNickname {
  final PaymentRepository repository;

  GetPaymentsByUserIdAndNickname(this.repository);

  Future<Either<Failure, List<PaymentEntity>>> call(int userId, String nickname) async {
    return await repository.getPaymentsByUserIdAndNickname(userId, nickname);
  }
}
