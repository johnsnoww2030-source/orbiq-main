import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/core/adaptor/bloc_provider.dart';
import 'package:orbiq/core/adaptor/routes.dart';
import 'package:orbiq/core/adaptor/routes_constants.dart';
import 'package:orbiq/core/adaptor/theme.dart';
import 'package:orbiq/core/database/app_database.dart';
import 'package:orbiq/core/shared/localization/domain/entities/language_entity.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';

import 'package:orbiq/core/shared/localization/presentation/controller/language_bloc.dart';
import 'package:orbiq/core/shared/localization/presentation/controller/language_state.dart';
import 'package:orbiq/core/shared/theme/domain/entities/theme_entity.dart';
import 'package:orbiq/core/shared/theme/presentation/controller/theme_bloc.dart';
import 'package:orbiq/core/shared/theme/presentation/controller/theme_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders(database),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          // تم پیش‌فرض روشن است
          ThemeData appTheme = AppTheme.lightTheme;

          // اگر تم بارگذاری شده باشد، از آن استفاده می‌کنیم
          if (themeState is ThemeLoaded) {
            appTheme = themeState.theme.type == ThemeType.dark
                ? AppTheme.darkTheme
                : AppTheme.lightTheme;
          }

          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              // زبان پیش‌فرض فارسی است
              Locale locale = const Locale('fa');

              // اگر زبان بارگذاری شده باشد، از آن استفاده می‌کنیم
              if (languageState is LanguageLoaded) {
                switch (languageState.language.code) {
                  case LanguageCode.en:
                    locale = const Locale('en');
                    break;
                  case LanguageCode.ar:
                    locale = const Locale('ar');
                    break;
                  case LanguageCode.fa:
                    locale = const Locale('fa');
                    break;
                }
              }

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Orbiq',
                theme: appTheme,
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('fa'),
                  Locale('ar'),
                ],
                builder: (context, child) {
                  // تنظیم جهت متن بر اساس زبان (RTL برای فارسی و عربی)
                  final textDirection =
                      (locale.languageCode == 'fa' ||
                          locale.languageCode == 'ar')
                      ? TextDirection.rtl
                      : TextDirection.ltr;

                  return Directionality(
                    textDirection: textDirection,
                    child: child!,
                  );
                },
                initialRoute: Routes.login,
                routes: appRoutes,
              );
            },
          );
        },
      ),
    );
  }
}
