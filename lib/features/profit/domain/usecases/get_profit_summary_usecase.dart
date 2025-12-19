import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/profit_summary.dart';
import '../repositories/profit_repository.dart';
import '../../../auth/domain/failures/failure.dart';

/// Parameters for GetProfitSummaryUseCase
class GetProfitSummaryParams extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const GetProfitSummaryParams({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}

/// Use Case: Get Profit Summary for a period
/// Retrieves comprehensive profit data including historical and current value
class GetProfitSummaryUseCase {
  final ProfitRepository repository;

  GetProfitSummaryUseCase(this.repository);

  Future<Either<Failure, ProfitSummary>> call(
    GetProfitSummaryParams params,
  ) async {
    // Validate dates
    if (params.startDate.isAfter(params.endDate)) {
      return const Left(
        ValidationFailure('Start date must be before end date'),
      );
    }

    return repository.getProfitSummary(
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

/// Validation Failure
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
