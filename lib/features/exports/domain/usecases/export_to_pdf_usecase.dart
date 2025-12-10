import 'package:injectable/injectable.dart';
import 'package:orbiq/features/exports/domain/repositories/export_repository.dart';

@injectable
class ExportToPDFUseCase {
  final ExportRepository repository;

  ExportToPDFUseCase(this.repository);

  Future<void> call(List<List<dynamic>> data, String fileName) async {
    await repository.exportToPDF(data, fileName);
  }
}
