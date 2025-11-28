abstract class ExportEvent {}

class ExportPDFEvent extends ExportEvent {
  final List<List<dynamic>> data;
  final String fileName;

  ExportPDFEvent(this.data, this.fileName);
}

class ExportExcelEvent extends ExportEvent {
  final List<dynamic> data;
  final String fileName;

  ExportExcelEvent(this.data, this.fileName);
}