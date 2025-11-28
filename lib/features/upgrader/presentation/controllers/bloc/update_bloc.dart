import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/features/upgrader/domain/usecases/check_for_update.dart';
import 'package:orbiq/features/upgrader/domain/usecases/download_and_install_update.dart';


import 'update_event.dart';
import 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final CheckForUpdate checkForUpdate;
  final DownloadAndInstallUpdate downloadAndInstallUpdate;

  UpdateBloc({
    required this.checkForUpdate,
    required this.downloadAndInstallUpdate,
  }) : super(UpdateInitial()) {
    on<CheckForUpdateEvent>(_onCheckForUpdate);
    on<DownloadAndInstallUpdateEvent>(_onDownloadAndInstallUpdate);
  }

  Future<void> _onCheckForUpdate(
    CheckForUpdateEvent event,
    Emitter<UpdateState> emit,
  ) async {
    emit(UpdateChecking());
    try {
      final versionInfo = await checkForUpdate();
      if (versionInfo != null) {
        emit(UpdateAvailable(versionInfo));
      } else {
        emit(UpdateNotAvailable());
      }
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }

  Future<void> _onDownloadAndInstallUpdate(
    DownloadAndInstallUpdateEvent event,
    Emitter<UpdateState> emit,
  ) async {
    emit(UpdateDownloading());
    try {
      await downloadAndInstallUpdate(event.versionInfo.getUrlForCurrentPlatform());
      emit(UpdateInstalled());
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }
}