import 'package:equatable/equatable.dart';

sealed class ExportState extends Equatable {
  const ExportState();
}

class ExportInitial extends ExportState {
  const ExportInitial();

  @override
  List<Object?> get props => [];
}

class Exporting extends ExportState {
  const Exporting();

  @override
  List<Object?> get props => [];
}

class ExportSuccess extends ExportState {
  const ExportSuccess();

  @override
  List<Object?> get props => [];
}

class ExportFailure extends ExportState {
  final String message;

  const ExportFailure(this.message);

  @override
  List<Object?> get props => [message];
}
