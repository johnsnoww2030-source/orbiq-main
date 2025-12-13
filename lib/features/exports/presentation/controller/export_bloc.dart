import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/exports/domain/usecases/export_to_excel_usecase.dart';
import 'package:orbiq/features/exports/domain/usecases/export_to_pdf_usecase.dart';
import 'package:orbiq/features/exports/presentation/controller/export_event.dart';
import 'package:orbiq/features/exports/presentation/controller/export_state.dart';

@injectable
class ExportBloc extends Bloc<ExportEvent, ExportState> {
  final ExportToPDFUseCase _exportToPDFUseCase;
  final ExportToExcelUseCase _exportToExcelUseCase;

  ExportBloc(this._exportToPDFUseCase, this._exportToExcelUseCase)
    : super(const ExportInitial()) {
    on<PdfExportRequested>(_onPdfExportRequested);
    on<ExcelExportRequested>(_onExcelExportRequested);
  }

  Future<void> _onPdfExportRequested(
    PdfExportRequested event,
    Emitter<ExportState> emit,
  ) async {
    emit(const Exporting());

    final result = await _exportToPDFUseCase(event.data, event.fileName);

    result.fold(
      (failure) => emit(ExportError(failure.message)),
      (filePath) => emit(ExportSuccess(filePath: filePath)),
    );
  }

  Future<void> _onExcelExportRequested(
    ExcelExportRequested event,
    Emitter<ExportState> emit,
  ) async {
    emit(const Exporting());

    final result = await _exportToExcelUseCase(event.data, event.fileName);

    result.fold(
      (failure) => emit(ExportError(failure.message)),
      (filePath) => emit(ExportSuccess(filePath: filePath)),
    );
  }
}
