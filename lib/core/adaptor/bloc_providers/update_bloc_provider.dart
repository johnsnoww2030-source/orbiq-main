import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/features/upgrader/data/datasource/version_remote_data_source.dart';
import 'package:orbiq/features/upgrader/data/repositories/version_repository_impl.dart';
import 'package:orbiq/features/upgrader/data/services/update_service.dart';
import 'package:orbiq/features/upgrader/domain/repositories/version_repository.dart';
import 'package:orbiq/features/upgrader/domain/usecases/check_for_update.dart';
import 'package:orbiq/features/upgrader/domain/usecases/download_and_install_update.dart';
import 'package:orbiq/features/upgrader/presentation/controllers/bloc/update_bloc.dart';

List<BlocProvider> updateBlocProviders(Dio dio) {
  final updateService = UpdateService(dio);
  final versionRemoteDataSource = VersionRemoteDataSourceImpl(dio);

  final VersionRepository versionRepository = VersionRepositoryImpl(
    versionRemoteDataSource,
    updateService,
  );

  final checkForUpdate = CheckForUpdate(versionRepository);
  final downloadAndInstallUpdate = DownloadAndInstallUpdate(versionRepository);

  return [
    BlocProvider<UpdateBloc>(
      create: (context) => UpdateBloc(
        checkForUpdate: checkForUpdate,
        downloadAndInstallUpdate: downloadAndInstallUpdate,
      ),
    ),
  ];
}
