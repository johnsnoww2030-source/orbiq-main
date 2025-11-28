import 'package:dartz/dartz.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';
import 'package:orbiq/features/payment/domain/entities/payment_entity.dart';
import 'package:orbiq/features/payment/domain/repositories/payment_repositroy.dart';

class SavePayment {
  final PaymentRepository repository;

  SavePayment(this.repository);

  Future<Either<Failure, void>> call(PaymentEntity payment) async {
    return await repository.savePayment(payment);
  }
}
