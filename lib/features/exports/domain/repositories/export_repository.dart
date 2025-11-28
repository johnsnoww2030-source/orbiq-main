abstract class ExportRepository {
  Future<void> exportToPDF(List<List<dynamic>> data, String fileName);
  Future<void> exportToExcel(List<dynamic> data, String fileName);
}