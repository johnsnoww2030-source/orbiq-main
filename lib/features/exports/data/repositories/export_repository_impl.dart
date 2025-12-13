import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:orbiq/features/exports/domain/failures/export_failure.dart';
import 'package:orbiq/features/exports/domain/repositories/export_repository.dart';

/// Repository implementation for Export operations
/// Returns Either with file path on success or ExportFailure on error
@LazySingleton(as: ExportRepository)
class ExportRepositoryImpl implements ExportRepository {
  ExportRepositoryImpl();

  @override
  Future<Either<ExportFailure, String>> exportToPDF(
    List<List<dynamic>> data,
    String fileName,
  ) async {
    try {
      final pdf = pw.Document();

      // Load Persian font
      final fontData = await rootBundle.load(
        'lib/core/assets/fonts/IRANYekanMedium.ttf',
      );
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
      final filePath = '${directory.path}/$fileName.pdf';
      final output = File(filePath);
      await output.writeAsBytes(await pdf.save());

      return Right(filePath);
    } on PlatformException catch (e) {
      return Left(FontLoadFailure('خطا در بارگذاری فونت: ${e.message}'));
    } on FileSystemException catch (e) {
      return Left(FileSystemFailure('خطا در ذخیره فایل: ${e.message}'));
    } catch (e) {
      return Left(PdfExportFailure('خطا در تولید PDF: $e'));
    }
  }

  @override
  Future<Either<ExportFailure, String>> exportToExcel(
    List<dynamic> data,
    String fileName,
  ) async {
    try {
      final excel = Excel.createExcel();
      final sheet = excel['Sheet1'];

      for (int i = 0; i < data.length; i++) {
        sheet.appendRow(data[i]);
      }

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName.xlsx';
      final output = File(filePath);
      final bytes = excel.encode();

      if (bytes == null) {
        return const Left(ExcelExportFailure('خطا در رمزگذاری فایل Excel'));
      }

      await output.writeAsBytes(bytes);

      return Right(filePath);
    } on FileSystemException catch (e) {
      return Left(FileSystemFailure('خطا در ذخیره فایل: ${e.message}'));
    } catch (e) {
      return Left(ExcelExportFailure('خطا در تولید Excel: $e'));
    }
  }
}
