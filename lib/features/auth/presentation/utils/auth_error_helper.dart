import 'package:orbiq/core/shared/localization/l10n/app_localizations.dart';
import 'package:orbiq/features/auth/domain/failures/failure.dart';

/// Helper function to get localized error message from AuthFailureType
String getLocalizedErrorMessage(
  AppLocalizations l10n,
  AuthFailureType failureType, {
  String? extraMessage,
}) {
  switch (failureType) {
    case AuthFailureType.invalidCredentials:
      return l10n.invalidCredentials;
    case AuthFailureType.firstLogin:
      return l10n.firstLoginMessage;
    case AuthFailureType.userNotFound:
      return l10n.userNotFound;
    case AuthFailureType.logoutFailed:
      return l10n.logoutFailed;
    case AuthFailureType.addUserFailed:
      return l10n.addUserFailed(extraMessage ?? '');
    case AuthFailureType.general:
      return extraMessage ?? l10n.errorOccurred;
  }
}
