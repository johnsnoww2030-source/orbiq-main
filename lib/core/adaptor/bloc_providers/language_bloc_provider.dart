import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'package:orbiq/core/shared/localization/data/data_sources/local/language_local_data_source.dart';
import 'package:orbiq/core/shared/localization/data/repositories/language_repository_impl.dart';
import 'package:orbiq/core/shared/localization/domain/usecases/get_language_usecase.dart';
import 'package:orbiq/core/shared/localization/domain/usecases/save_language_usecase.dart';
import 'package:orbiq/core/shared/localization/presentation/controller/language_bloc.dart';
import 'package:orbiq/core/shared/localization/presentation/controller/language_event.dart';

List<BlocProvider> languageBlocProviders(AppDatabase database) {
  // اضافه کردن LanguageBloc
  final languageDao = database.languageDao;
  final languageLocalDataSource = LanguageLocalDataSource(languageDao);
  final languageRepository = LanguageRepositoryImpl(languageLocalDataSource);
  final getLanguageUseCase = GetLanguageUseCase(languageRepository);
  final saveLanguageUseCase = SaveLanguageUseCase(languageRepository);

  return [
    // Add LanguageBloc
    BlocProvider<LanguageBloc>(
      create: (context) => LanguageBloc(
        getLanguageUseCase: getLanguageUseCase,
        saveLanguageUseCase: saveLanguageUseCase,
      )..add(GetLanguageEvent()),
    ),
  ];
}
