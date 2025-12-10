import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbiq/features/upgrader/domain/entities/version_info_entity.dart';

part 'update_state.freezed.dart';

@freezed
class UpdateState with _$UpdateState {
  const factory UpdateState.initial() = UpdateInitial;
  const factory UpdateState.checking() = UpdateChecking;
  const factory UpdateState.available(VersionInfoEntity versionInfo) =
      UpdateAvailable;
  const factory UpdateState.notAvailable() = UpdateNotAvailable;
  const factory UpdateState.downloading() = UpdateDownloading;
  const factory UpdateState.installed() = UpdateInstalled;
  const factory UpdateState.error(String message) = UpdateError;
}
