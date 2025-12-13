import 'package:equatable/equatable.dart';

/// Base class for Export events
abstract class ExportEvent extends Equatable {
  const ExportEvent();

  @override
  List<Object?> get props => [];
}

/// Event when PDF export is requested
class PdfExportRequested extends ExportEvent {
  final List<List<dynamic>> data;
  final String fileName;

  const PdfExportRequested({required this.data, required this.fileName});

  @override
  List<Object?> get props => [data, fileName];
}

/// Event when Excel export is requested
class ExcelExportRequested extends ExportEvent {
  final List<dynamic> data;
  final String fileName;

  const ExcelExportRequested({required this.data, required this.fileName});

  @override
  List<Object?> get props => [data, fileName];
}
