import 'package:orbiq/features/upgrader/domain/entities/version_info_entity.dart';

abstract class VersionRepository {
  Future<VersionInfoEntity?> getVersionInfo();
  Future<void> downloadAndInstallUpdate(String url);
}
