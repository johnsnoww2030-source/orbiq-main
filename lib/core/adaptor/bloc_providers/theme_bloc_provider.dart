import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/shared/database/database.dart';
import 'package:orbiq/core/shared/theme/data/data_sources/local/theme_local_data_source.dart';
import 'package:orbiq/core/shared/theme/data/repositories/theme_repository_impl.dart';
import 'package:orbiq/core/shared/theme/domain/usecases/get_theme_usecase.dart';
import 'package:orbiq/core/shared/theme/domain/usecases/save_theme_usecase.dart';
import 'package:orbiq/core/shared/theme/presentation/controller/theme_bloc.dart';
import 'package:orbiq/core/shared/theme/presentation/controller/theme_event.dart';

List<BlocProvider> themeBlocProviders(AppDatabase database) {
  // ایجاد ThemeDao
  final themeDao = database.themeDao;

  // ایجاد DataSource و Repository برای مدیریت تم
  final themeLocalDataSource = ThemeLocalDataSource(themeDao);
  final themeRepository = ThemeRepositoryImpl(themeLocalDataSource);

  // ایجاد UseCase ها برای تم
  final getThemeUseCase = GetThemeUseCase(themeRepository);
  final saveThemeUseCase = SaveThemeUseCase(themeRepository);

  return [
    // اضافه کردن ThemeBloc
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(
        getThemeUseCase: getThemeUseCase,
        saveThemeUseCase: saveThemeUseCase,
      )..add(GetThemeEvent()),
    ),
  ];
}
