// ignore_for_file: avoid_print

import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:orbiq/core/utils/version_utils.dart';
import 'package:orbiq/features/upgrader/data/model/version_info_model.dart';
import 'package:orbiq/features/upgrader/domain/repositories/version_repository.dart';

@injectable
class CheckForUpdate {
  final VersionRepository repository;

  CheckForUpdate(this.repository);

  Future<VersionInfoModel?> call() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      VersionInfoModel? versionInfo = await repository.getVersionInfo();

      int currentVersionNumber = versionToNumber(currentVersion);
      int newVersionNumber = versionToNumber(versionInfo!.version);
      print('newVersionNumber: $newVersionNumber');
      if (newVersionNumber > currentVersionNumber) {
        return versionInfo;
      }
      return null;
    } catch (e) {
      print('Error checking for update: $e');
      return null;
    }
  }
}
