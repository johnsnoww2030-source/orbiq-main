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
  }) : super(const UpdateState.initial()) {
    on<CheckForUpdateEvent>(_onCheckForUpdate);
    on<DownloadAndInstallUpdateEvent>(_onDownloadAndInstallUpdate);
  }

  Future<void> _onCheckForUpdate(
    CheckForUpdateEvent event,
    Emitter<UpdateState> emit,
  ) async {
    emit(const UpdateState.checking());
    try {
      final versionInfo = await checkForUpdate();
      if (versionInfo != null) {
        emit(UpdateState.available(versionInfo));
      } else {
        emit(const UpdateState.notAvailable());
      }
    } catch (e) {
      emit(UpdateState.error(e.toString()));
    }
  }

  Future<void> _onDownloadAndInstallUpdate(
    DownloadAndInstallUpdateEvent event,
    Emitter<UpdateState> emit,
  ) async {
    emit(const UpdateState.downloading());
    try {
      await downloadAndInstallUpdate(
        event.versionInfo.getUrlForCurrentPlatform(),
      );
      emit(const UpdateState.installed());
    } catch (e) {
      emit(UpdateState.error(e.toString()));
    }
  }
}
