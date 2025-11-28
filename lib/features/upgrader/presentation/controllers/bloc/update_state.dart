import 'package:equatable/equatable.dart';
import 'package:orbiq/features/upgrader/domain/entities/version_info_entity.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object> get props => [];
}

class UpdateInitial extends UpdateState {}

class UpdateChecking extends UpdateState {}

class UpdateAvailable extends UpdateState {
  final VersionInfoEntity versionInfo;

  const UpdateAvailable(this.versionInfo);

  @override
  List<Object> get props => [versionInfo];
}

class UpdateNotAvailable extends UpdateState {}

class UpdateDownloading extends UpdateState {}

class UpdateInstalled extends UpdateState {}

class UpdateError extends UpdateState {
  final String message;

  const UpdateError(this.message);

  @override
  List<Object> get props => [message];
}
