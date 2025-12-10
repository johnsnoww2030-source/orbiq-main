import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'update_strategy.dart';
import 'linux_update_strategy.dart';
// import 'windows_update_strategy.dart';
// import 'android_update_strategy.dart';

@lazySingleton
class UpdateService {
  final Dio _dio;
  late UpdateStrategy _strategy;

  UpdateService(this._dio) {
    if (Platform.isLinux) {
      _strategy = LinuxUpdateStrategy(_dio);
    } else if (Platform.isWindows) {
      // _strategy = WindowsUpdateStrategy(_dio);
    } else if (Platform.isAndroid) {
      // _strategy = AndroidUpdateStrategy(_dio);
    } else {
      throw UnsupportedError('پلتفرم فعلی پشتیبانی نمی‌شود');
    }
  }

  Future<void> downloadAndInstall(String url) async {
    await _strategy.downloadAndInstall(url);
  }
}
