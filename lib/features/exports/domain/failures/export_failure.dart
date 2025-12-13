import 'package:equatable/equatable.dart';

/// Base failure class for Export feature
/// Follows the pattern from PurchaseFailure
abstract class ExportFailure extends Equatable {
  final String message;

  const ExportFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when PDF export fails
class PdfExportFailure extends ExportFailure {
  const PdfExportFailure([super.message = 'خطا در تولید PDF']);
}

/// Failure when Excel export fails
class ExcelExportFailure extends ExportFailure {
  const ExcelExportFailure([super.message = 'خطا در تولید Excel']);
}

/// Failure when file system operation fails
class FileSystemFailure extends ExportFailure {
  const FileSystemFailure([super.message = 'خطا در ذخیره فایل']);
}

/// Failure when font loading fails
class FontLoadFailure extends ExportFailure {
  const FontLoadFailure([super.message = 'خطا در بارگذاری فونت']);
}
