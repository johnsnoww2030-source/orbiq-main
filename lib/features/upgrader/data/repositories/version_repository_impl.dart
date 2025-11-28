import 'package:orbiq/features/upgrader/data/datasource/version_remote_data_source.dart';
import 'package:orbiq/features/upgrader/data/model/version_info_model.dart';
import 'package:orbiq/features/upgrader/data/services/update_service.dart';
import 'package:orbiq/features/upgrader/domain/repositories/version_repository.dart';

class VersionRepositoryImpl implements VersionRepository {
  final VersionRemoteDataSource remoteDataSource;
  final UpdateService updateService;

  VersionRepositoryImpl(this.remoteDataSource, this.updateService);

  @override
  Future<VersionInfoModel?> getVersionInfo() async {
    return await remoteDataSource.getVersionInfo();
  }

  @override
  Future<void> downloadAndInstallUpdate(String url) async {
    await updateService.downloadAndInstall(url);
  }
}
