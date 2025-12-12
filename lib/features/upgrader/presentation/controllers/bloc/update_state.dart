import 'package:equatable/equatable.dart';
import 'package:orbiq/features/upgrader/domain/entities/version_info_entity.dart';

sealed class UpdateState extends Equatable {
  const UpdateState();
}

class UpdateInitial extends UpdateState {
  const UpdateInitial();

  @override
  List<Object?> get props => [];
}

class UpdateChecking extends UpdateState {
  const UpdateChecking();

  @override
  List<Object?> get props => [];
}

class UpdateAvailable extends UpdateState {
  final VersionInfoEntity versionInfo;

  const UpdateAvailable(this.versionInfo);

  @override
  List<Object?> get props => [versionInfo];
}

class UpdateNotAvailable extends UpdateState {
  const UpdateNotAvailable();

  @override
  List<Object?> get props => [];
}

class UpdateDownloading extends UpdateState {
  const UpdateDownloading();

  @override
  List<Object?> get props => [];
}

class UpdateInstalled extends UpdateState {
  const UpdateInstalled();

  @override
  List<Object?> get props => [];
}

class UpdateError extends UpdateState {
  final String message;

  const UpdateError(this.message);

  @override
  List<Object?> get props => [message];
}
