import 'package:dartz/dartz.dart';
import '../failures/export_failure.dart';

/// Abstract repository interface for Export operations.
/// Returns [Either] with [ExportFailure] on failure or file path [String] on success.
abstract class ExportRepository {
  /// Export data to PDF format
  /// Returns the file path on success
  Future<Either<ExportFailure, String>> exportToPDF(
    List<List<dynamic>> data,
    String fileName,
  );

  /// Export data to Excel format
  /// Returns the file path on success
  Future<Either<ExportFailure, String>> exportToExcel(
    List<dynamic> data,
    String fileName,
  );
}
