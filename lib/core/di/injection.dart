import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies() async {
  // Prevent re-registration on hot reload
  if (getIt.isRegistered<AppDatabase>()) {
    return;
  }
  await getIt.init();
}
