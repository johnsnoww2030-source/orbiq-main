import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/exports/domain/usecases/export_to_excel_usecase.dart';
import 'package:orbiq/features/exports/domain/usecases/export_to_pdf_usecase.dart';
import 'package:orbiq/features/exports/presentation/controller/export_event.dart';
import 'package:orbiq/features/exports/presentation/controller/export_state.dart';

@injectable
class ExportBloc extends Bloc<ExportEvent, ExportState> {
  final ExportToPDFUseCase exportToPDFUseCase;
  final ExportToExcelUseCase exportToExcelUseCase;

  ExportBloc(this.exportToPDFUseCase, this.exportToExcelUseCase)
    : super(const ExportState.initial()) {
    on<ExportPDFEvent>(_onExportPDFEvent);
    on<ExportExcelEvent>(_onExportExcelEvent);
  }

  Future<void> _onExportPDFEvent(
    ExportPDFEvent event,
    Emitter<ExportState> emit,
  ) async {
    emit(const ExportState.exporting());
    try {
      await exportToPDFUseCase(event.data, event.fileName);
      emit(const ExportState.success());
    } catch (e) {
      emit(ExportState.failure(e.toString()));
    }
  }

  Future<void> _onExportExcelEvent(
    ExportExcelEvent event,
    Emitter<ExportState> emit,
  ) async {
    emit(const ExportState.exporting());
    try {
      await exportToExcelUseCase(event.data, event.fileName);
      emit(const ExportState.success());
    } catch (e) {
      emit(ExportState.failure(e.toString()));
    }
  }
}
