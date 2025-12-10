import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';
// Assuming PaginatedPayments will be defined here, similar to PaginatedProducts
import 'package:orbiq/features/payment/data/repositories/payment_repositroy_impl.dart';
import 'package:orbiq/features/payment/domain/repositories/payment_repositroy.dart';

@injectable
class GetAllPaymentsUseCase {
  final PaymentRepository repository;

  GetAllPaymentsUseCase(this.repository);

  Future<Either<Failure, PaginatedPayments>> call(
    GetAllPaymentsUseCaseParams params,
  ) async {
    try {
      final result = await repository.getAllPayments(
        page: params.page,
        limit: params.limit,
      );

      return result.fold(
        (failure) {
          return Left(
            GeneralFailure('Failed to retrieve payments: ${failure.message}'),
          );
        },
        (paginatedPayments) {
          return Right(paginatedPayments);
        },
      );
    } catch (e) {
      return Left(GeneralFailure('Unexpected error: $e'));
    }
  }
}

class GetAllPaymentsUseCaseParams extends Equatable {
  final int page;
  final int limit;

  const GetAllPaymentsUseCaseParams({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
