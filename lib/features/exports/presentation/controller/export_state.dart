import 'package:equatable/equatable.dart';

/// Base sealed class for Export states
sealed class ExportState extends Equatable {
  const ExportState();
}

/// Initial state before any export operation
class ExportInitial extends ExportState {
  const ExportInitial();

  @override
  List<Object?> get props => [];
}

/// State while export is in progress
class Exporting extends ExportState {
  const Exporting();

  @override
  List<Object?> get props => [];
}

/// State when export completed successfully
class ExportSuccess extends ExportState {
  final String filePath;

  const ExportSuccess({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

/// State when export failed
class ExportError extends ExportState {
  final String message;

  const ExportError(this.message);

  @override
  List<Object?> get props => [message];
}
