import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/features/exports/data/repositories/export_repository_impl.dart';
import 'package:orbiq/features/exports/domain/usecases/export_to_excel_usecase.dart';
import 'package:orbiq/features/exports/domain/usecases/export_to_pdf_usecase.dart';
import 'package:orbiq/features/exports/presentation/controller/export_bloc.dart';

List<BlocProvider> exportBlocProviders() {
  return [
    BlocProvider<ExportBloc>(
      create: (context) => ExportBloc(
        ExportToPDFUseCase(ExportRepositoryImpl()),
        ExportToExcelUseCase(ExportRepositoryImpl()),
      ),
    ),
  ];
}
