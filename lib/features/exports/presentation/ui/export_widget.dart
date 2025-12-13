import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/exports/presentation/controller/export_bloc.dart';
import 'package:orbiq/features/exports/presentation/controller/export_event.dart';
import 'package:orbiq/features/exports/presentation/controller/export_state.dart';

/// Widget for exporting data to PDF or Excel
/// Uses BlocListener to show success/error feedback
class ExportWidget extends StatelessWidget {
  final List<List<dynamic>> data;
  final String fileNamePrefix;

  const ExportWidget({
    super.key,
    required this.data,
    required this.fileNamePrefix,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<ExportBloc, ExportState>(
      listener: (context, state) {
        if (state is ExportSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.exportSuccessful),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ExportError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${l10n.exportFailed}: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<ExportBloc, ExportState>(
        builder: (context, state) {
          final isExporting = state is Exporting;

          return PopupMenuButton<String>(
            tooltip: l10n.export,
            enabled: !isExporting,
            icon: isExporting
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.download_outlined),
            onSelected: (value) {
              if (value == 'pdf') {
                context.read<ExportBloc>().add(
                  PdfExportRequested(
                    data: data,
                    fileName: '${fileNamePrefix}_export',
                  ),
                );
              } else if (value == 'excel') {
                context.read<ExportBloc>().add(
                  ExcelExportRequested(
                    data: data,
                    fileName: '${fileNamePrefix}_export',
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'pdf',
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text(l10n.exportToPdf),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'excel',
                child: Row(
                  children: [
                    const Icon(Icons.grid_on_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text(l10n.exportToExcel),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
