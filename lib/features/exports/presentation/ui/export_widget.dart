import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/features/exports/presentation/controller/export_bloc.dart';
import 'package:orbiq/features/exports/presentation/controller/export_event.dart';

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
    return PopupMenuButton<String>(
      tooltip: 'خروجی گرفتن',
      icon: const Icon(Icons.download_outlined),
      onSelected: (value) {
        if (value == 'pdf') {
          BlocProvider.of<ExportBloc>(context)
              .add(ExportPDFEvent(data, '${fileNamePrefix}_fast'));
        } else if (value == 'excel') {
          BlocProvider.of<ExportBloc>(context)
              .add(ExportExcelEvent(data, '${fileNamePrefix}_fast'));
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'pdf',
          child: Row(
            children: [
              Icon(Icons.picture_as_pdf_outlined, size: 20),
              SizedBox(width: 8),
              Text(' PDF'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'excel',
          child: Row(
            children: [
              Icon(Icons.grid_on_outlined, size: 20),
              SizedBox(width: 8),
              Text(' Excel'),
            ],
          ),
        ),
      ],
    );
  }
}
