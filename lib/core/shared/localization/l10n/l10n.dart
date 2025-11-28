import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('fa'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'fa':
        return '🇮🇷';
      case 'en':
      default:
        return '🇺🇸';
    }
  }

  static List<LocalizationsDelegate<dynamic>> getLocalizationsDelegates() {
    return const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }

  static bool isRtl(BuildContext context) {
    return Directionality.of(context) == TextDirection.rtl;
  }

  static TextDirection getTextDirection(String languageCode) {
    return languageCode == 'fa' ? TextDirection.rtl : TextDirection.ltr;
  }
}
