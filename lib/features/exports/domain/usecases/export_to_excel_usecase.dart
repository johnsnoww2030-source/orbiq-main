import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/exports/domain/failures/export_failure.dart';
import 'package:orbiq/features/exports/domain/repositories/export_repository.dart';

@injectable
class ExportToExcelUseCase {
  final ExportRepository repository;

  ExportToExcelUseCase(this.repository);

  Future<Either<ExportFailure, String>> call(
    List<dynamic> data,
    String fileName,
  ) async {
    return await repository.exportToExcel(data, fileName);
  }
}
