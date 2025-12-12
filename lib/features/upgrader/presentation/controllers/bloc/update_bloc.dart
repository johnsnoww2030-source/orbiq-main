import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/features/upgrader/domain/usecases/check_for_update.dart';
import 'package:orbiq/features/upgrader/domain/usecases/download_and_install_update.dart';

import 'update_event.dart';
import 'update_state.dart';

@injectable
class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final CheckForUpdate checkForUpdate;
  final DownloadAndInstallUpdate downloadAndInstallUpdate;

  UpdateBloc({
    required this.checkForUpdate,
    required this.downloadAndInstallUpdate,
  }) : super(const UpdateInitial()) {
    on<CheckForUpdateEvent>(_onCheckForUpdate);
    on<DownloadAndInstallUpdateEvent>(_onDownloadAndInstallUpdate);
  }

  Future<void> _onCheckForUpdate(
    CheckForUpdateEvent event,
    Emitter<UpdateState> emit,
  ) async {
    emit(const UpdateChecking());
    try {
      final versionInfo = await checkForUpdate();
      if (versionInfo != null) {
        emit(UpdateAvailable(versionInfo));
      } else {
        emit(const UpdateNotAvailable());
      }
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }

  Future<void> _onDownloadAndInstallUpdate(
    DownloadAndInstallUpdateEvent event,
    Emitter<UpdateState> emit,
  ) async {
    emit(const UpdateDownloading());
    try {
      await downloadAndInstallUpdate(
        event.versionInfo.getUrlForCurrentPlatform(),
      );
      emit(const UpdateInstalled());
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }
}
