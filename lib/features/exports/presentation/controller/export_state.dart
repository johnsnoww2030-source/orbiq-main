abstract class ExportState {}

class ExportInitial extends ExportState {}

class Exporting extends ExportState {}

class ExportSuccess extends ExportState {}

class ExportFailure extends ExportState {
  final String message;

  ExportFailure(this.message);
}
