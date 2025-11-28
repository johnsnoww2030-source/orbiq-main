// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:orbiq/features/upgrader/data/services/update_strategy.dart';

class LinuxUpdateStrategy implements UpdateStrategy {
  final Dio _dio;

  LinuxUpdateStrategy(this._dio);
  @override
  Future<void> downloadAndInstall(String url) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String debPath = '${appDocDir.path}/new_version.deb';

      await _dio.download(url, debPath, onReceiveProgress: (received, total) {
        if (total != -1) {
          print('دانلود: ${(received / total * 100).toStringAsFixed(0)}% تکمیل شده');
        }
      });

      File downloadedFile = File(debPath);
      if (await downloadedFile.exists()) {
        await _createInstallScript(debPath);
        await _createRestartScript();
        await _restartApp();
      } else {
        throw Exception('خطا: فایل دانلود شده یافت نشد.');
      }
    } catch (e) {
      throw Exception('خطا در دانلود یا نصب: $e');
    }
  }

  Future<void> _createInstallScript(String debPath) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String scriptPath = '${appDocDir.path}/install.sh';
      String logPath = '${appDocDir.path}/install_log.txt';

      String script = '''
#!/bin/bash
LOG_PATH="$logPath"
DEB_PATH="$debPath"

exec > \$LOG_PATH 2>&1  # Redirect output to log file
set -x  # Enable command tracing

echo "Starting installation process"
sleep 1

xhost +SI:localuser:root

sudo dpkg -i "\$DEB_PATH"
sudo dpkg --configure -a
sudo systemctl daemon-reload
sudo update-desktop-database
sudo gtk-update-icon-cache -f /usr/share/icons/hicolor

echo "Installation process completed"

rm "\$DEB_PATH"
''';

      await File(scriptPath).writeAsString(script);
      await Process.run('chmod', [
        '+x',
        scriptPath
      ]);

      if (await File(scriptPath).exists()) {
        print('اسکریپت نصب با موفقیت ایجاد شد: $scriptPath');
      } else {
        print('خطا در ایجاد اسکریپت نصب: $scriptPath');
      }
    } catch (e) {
      print('خطا در ایجاد اسکریپت نصب: $e');
    }
  }

  Future<void> _createRestartScript() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String scriptPath = '${appDocDir.path}/restart.sh';
      String currentExecutable = Platform.resolvedExecutable;
      String appName = currentExecutable.split('/').last;
      String logPath = '${appDocDir.path}/restart_log.txt';

      // گرفتن مقدار متغیر DISPLAY
      String? display = Platform.environment['DISPLAY'];

      String script = '''
#!/bin/bash
APP_NAME="$appName"
LOG_PATH="$logPath"
DISPLAY="$display"

exec > \$LOG_PATH 2>&1  # Redirect output to log file
set -x  # Enable command tracing

echo "Starting restart process"
sleep 1

# کشتن فرآیند قبلی
pkill -f "\$APP_NAME"
echo "Current instance killed"

# تنظیم DISPLAY و اجرای برنامه
export DISPLAY=\$DISPLAY
"$currentExecutable" &

echo "New version started"
''';

      await File(scriptPath).writeAsString(script);
      await Process.run('chmod', [
        '+x',
        scriptPath
      ]);

      if (await File(scriptPath).exists()) {
        print('اسکریپت راه‌اندازی مجدد با موفقیت ایجاد شد: $scriptPath');
      } else {
        print('خطا در ایجاد اسکریپت راه‌اندازی مجدد: $scriptPath');
      }
    } catch (e) {
      print('خطا در ایجاد اسکریپت راه‌اندازی مجدد: $e');
    }
  }

  Future<void> _restartApp() async {
    if (Platform.isLinux) {
      try {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String installScriptPath = '${appDocDir.path}/install.sh';
        String restartScriptPath = '${appDocDir.path}/restart.sh';
        String installLogPath = '${appDocDir.path}/install_log.txt';
        String restartLogPath = '${appDocDir.path}/restart_log.txt';

        // اجرای اسکریپت نصب با pkexec
        ProcessResult installResult = await Process.run('pkexec', [
          installScriptPath
        ]);
        if (installResult.exitCode != 0) {
          print('خطا در اجرای اسکریپت نصب: ${installResult.stderr}');
          String installLogContent = await File(installLogPath).readAsString();
          print('محتویات فایل لاگ نصب:\n$installLogContent');
          return;
        }

        // اجرای اسکریپت راه‌اندازی مجدد بدون pkexec
        ProcessResult restartResult = await Process.run('bash', [
          restartScriptPath
        ]);
        if (restartResult.exitCode != 0) {
          print('خطا در اجرای اسکریپت راه‌اندازی مجدد: ${restartResult.stderr}');
          String restartLogContent = await File(restartLogPath).readAsString();
          print('محتویات فایل لاگ راه‌اندازی مجدد:\n$restartLogContent');
          return;
        }

        // افزودن تأخیر قبل از بستن برنامه
        await Future.delayed(const Duration(seconds: 2));

        // بستن برنامه فعلی
        exit(0);
      } catch (e) {
        print('خطا در راه‌اندازی مجدد برنامه: $e');
      }
    }
  }
}
