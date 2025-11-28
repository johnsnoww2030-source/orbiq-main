import 'package:equatable/equatable.dart';
import 'package:orbiq/features/upgrader/domain/entities/version_info_entity.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class CheckForUpdateEvent extends UpdateEvent {}

class DownloadAndInstallUpdateEvent extends UpdateEvent {
  final VersionInfoEntity versionInfo;

  const DownloadAndInstallUpdateEvent(this.versionInfo);

  @override
  List<Object> get props => [versionInfo];
}
