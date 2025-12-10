import 'package:injectable/injectable.dart';
import '../repositories/version_repository.dart';

@injectable
class DownloadAndInstallUpdate {
  final VersionRepository repository;

  DownloadAndInstallUpdate(this.repository);

  Future<void> call(String url) async {
    await repository.downloadAndInstallUpdate(url);
  }
}
