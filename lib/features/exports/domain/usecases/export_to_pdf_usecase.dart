import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/exports/domain/failures/export_failure.dart';
import 'package:orbiq/features/exports/domain/repositories/export_repository.dart';

@injectable
class ExportToPDFUseCase {
  final ExportRepository repository;

  ExportToPDFUseCase(this.repository);

  Future<Either<ExportFailure, String>> call(
    List<List<dynamic>> data,
    String fileName,
  ) async {
    return await repository.exportToPDF(data, fileName);
  }
}
