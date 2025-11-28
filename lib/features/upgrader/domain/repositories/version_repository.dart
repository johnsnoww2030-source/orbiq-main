import 'package:orbiq/features/upgrader/data/model/version_info_model.dart';

abstract class VersionRepository {
  Future<VersionInfoModel?> getVersionInfo();
  Future<void> downloadAndInstallUpdate(String url);
}
