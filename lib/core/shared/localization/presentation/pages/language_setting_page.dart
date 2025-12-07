// lib/core/presentation/pages/language_settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:orbiq/core/shared/localization/domain/entities/language_entity.dart';
import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/core/shared/localization/presentation/controller/language_bloc.dart';
import 'package:orbiq/core/shared/localization/presentation/controller/language_event.dart';
import 'package:orbiq/core/shared/localization/presentation/controller/language_state.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.language)),
      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LanguageLoaded) {
            final currentLanguage = state.language;

            return ListView(
              children: [
                _buildLanguageItem(
                  context,
                  LanguageEntity.persian(),
                  currentLanguage,
                  l10n.persian,
                ),
                _buildLanguageItem(
                  context,
                  LanguageEntity.english(),
                  currentLanguage,
                  l10n.english,
                ),
                _buildLanguageItem(
                  context,
                  LanguageEntity.arabic(),
                  currentLanguage,
                  l10n.arabic,
                ),
              ],
            );
          } else {
            // در صورت عدم بارگذاری زبان یا خطا، فقط لیست زبان‌ها را نمایش می‌دهیم
            return ListView(
              children: [
                _buildLanguageItem(
                  context,
                  LanguageEntity.persian(),
                  LanguageEntity.persian(),
                  'فارسی',
                ),
                _buildLanguageItem(
                  context,
                  LanguageEntity.english(),
                  LanguageEntity.persian(),
                  'English',
                ),
                _buildLanguageItem(
                  context,
                  LanguageEntity.arabic(),
                  LanguageEntity.persian(),
                  'العربية',
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildLanguageItem(
    BuildContext context,
    LanguageEntity language,
    LanguageEntity currentLanguage,
    String localizedName,
  ) {
    final isSelected = language.code == currentLanguage.code;

    return ListTile(
      title: Text(localizedName),
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: () {
        if (!isSelected) {
          context.read<LanguageBloc>().add(ChangeLanguageEvent(language));
        }
      },
    );
  }
}
