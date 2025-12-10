import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_state.freezed.dart';

@freezed
class ExportState with _$ExportState {
  const factory ExportState.initial() = ExportInitial;
  const factory ExportState.exporting() = Exporting;
  const factory ExportState.success() = ExportSuccess;
  const factory ExportState.failure(String message) = ExportFailure;
}
