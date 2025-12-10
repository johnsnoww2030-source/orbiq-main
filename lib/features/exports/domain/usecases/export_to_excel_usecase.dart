import 'package:injectable/injectable.dart';
import 'package:orbiq/features/exports/domain/repositories/export_repository.dart';

@injectable
class ExportToExcelUseCase {
  final ExportRepository repository;

  ExportToExcelUseCase(this.repository);

  Future<void> call(List<dynamic> data, String fileName) async {
    await repository.exportToExcel(data, fileName);
  }
}
