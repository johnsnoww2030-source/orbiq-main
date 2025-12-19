import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/daily_profit.dart';
import '../repositories/profit_repository.dart';
import '../../../auth/domain/failures/failure.dart';

/// Parameters for GetDailyProfitsUseCase
class GetDailyProfitsParams extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const GetDailyProfitsParams({required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

/// Use Case: Get Daily Profits
/// Retrieves profit data grouped by day
class GetDailyProfitsUseCase {
  final ProfitRepository repository;

  GetDailyProfitsUseCase(this.repository);

  Future<Either<Failure, List<DailyProfit>>> call(
    GetDailyProfitsParams params,
  ) async {
    return repository.getDailyProfits(
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}
