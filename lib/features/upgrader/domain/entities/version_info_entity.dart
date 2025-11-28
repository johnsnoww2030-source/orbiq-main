import 'dart:io';

class VersionInfoEntity {
  final String version;
  final String linuxUrl;
  final String windowsUrl;
  final String androidUrl;

  VersionInfoEntity({
    required this.version,
    required this.linuxUrl,
    required this.windowsUrl,
    required this.androidUrl,
  });
  String getUrlForCurrentPlatform() {
    if (Platform.isLinux) return linuxUrl;
    if (Platform.isWindows) return windowsUrl;
    if (Platform.isAndroid) return androidUrl;
    throw UnsupportedError('پلتفرم فعلی پشتیبانی نمی‌شود');
  }
}
