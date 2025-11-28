import 'package:orbiq/features/upgrader/domain/entities/version_info_entity.dart';

class VersionInfoModel extends VersionInfoEntity {
  VersionInfoModel({
    required super.version,
    required super.linuxUrl,
    required super.windowsUrl,
    required super.androidUrl,
  });

  factory VersionInfoModel.fromJson(Map<String, dynamic> json) {
    return VersionInfoModel(
      version: json['version'],
      linuxUrl: json['linux_deb_url'],
      windowsUrl: json['windows_url'],
      androidUrl: json['android_url'],
    );
  }
}
