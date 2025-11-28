//
// // ignore: unused_import
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:excel/excel.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:orbiq/features/exports/domain/repositories/export_repository.dart';
//
// class ExportRepositoryImpl implements ExportRepository {
//   ExportRepositoryImpl();
//
//   @override
//   Future<void> exportToPDF(List<List<dynamic>> data, String fileName) async {
//     final pdf = pw.Document();
//
//     final fontData = await rootBundle.load('lib/core/assets/fonts/IRANYekanMedium.ttf');
//     final font = pw.Font.ttf(fontData);
//
//
//     pdf.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         theme: pw.ThemeData.withFont(base: font),
//         build: (pw.Context context) => [
//           pw.Directionality(
//             textDirection: pw.TextDirection.rtl,
//             child: pw.TableHelper.fromTextArray(
//               context: context,
//               headerCount: 0,
//               headers: null,
//               data: data,
//              columnWidths:{ 0: const pw.FixedColumnWidth(45)},
//             ),
//           ),
//         ],
//       ),
//     );
//
//     final directory = await getApplicationDocumentsDirectory();
//     final output = File('${directory.path}/$fileName.pdf');
//     await output.writeAsBytes(await pdf.save());
//   }
//
//   @override
//   Future<void> exportToExcel(List<dynamic> data, String fileName) async {
//     final excel = Excel.createExcel();
//     final sheet = excel['Sheet1'];
//
//     for (int i = 0; i < data.length; i++) {
//       sheet.appendRow(data[i]);
//     }
//
//     final directory = await getApplicationDocumentsDirectory();
//     final output = File('${directory.path}/$fileName.xlsx');
//     await output.writeAsBytes(excel.encode()!);
//   }
//
//
//
//
// }
//

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:orbiq/features/exports/domain/repositories/export_repository.dart';

class ExportRepositoryImpl implements ExportRepository {
  ExportRepositoryImpl();

  @override
  Future<void> exportToPDF(List<List<dynamic>> data, String fileName) async {
    final pdf = pw.Document();

    final fontData =
        await rootBundle.load('lib/core/assets/fonts/IRANYekanMedium.ttf');
    final font = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: font),
        build: (pw.Context context) => [
          pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.TableHelper.fromTextArray(
              context: context,
              headerCount: 0,
              headers: null,
              data: data,
            ),
          ),
        ],
      ),
    );
    final directory = await getApplicationDocumentsDirectory();
    // final directory = Directory("/storage/emulated/0/Download");
    final output = File('${directory.path}/$fileName.pdf');
    await output.writeAsBytes(await pdf.save());
  }

  @override
  Future<void> exportToExcel(List<dynamic> data, String fileName) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    for (int i = 0; i < data.length; i++) {
      sheet.appendRow(data[i]);
    }

    final directory = await getApplicationDocumentsDirectory();
    final output = File('${directory.path}/$fileName.xlsx');
    await output.writeAsBytes(excel.encode()!);
  }
}
