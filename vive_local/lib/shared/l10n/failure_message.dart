import 'package:flutter/widgets.dart';

import '../../core/errors/app_failure.dart';
import '../../core/l10n/app_localizations.dart';

extension AppFailureMessage on AppFailure {
  String message(AppLocalizations l10n) => switch (code) {
    FailureCode.firebaseNotConfigured => l10n.errorFirebaseNotConfigured,
    FailureCode.authCancelled => l10n.errorAuthCancelled,
    FailureCode.authFailed => l10n.errorAuthFailed,
    FailureCode.invalidCredentials => l10n.errorInvalidCredentials,
    FailureCode.locationPermissionDenied => l10n.errorLocationPermission,
    FailureCode.locationServicesDisabled => l10n.errorLocationDisabled,
    FailureCode.locationUnavailable => l10n.errorLocationUnavailable,
    FailureCode.network => l10n.errorNetwork,
    FailureCode.weatherNotConfigured => l10n.errorWeatherNotConfigured,
    FailureCode.weatherUnavailable => l10n.errorWeatherUnavailable,
    FailureCode.placeNotFound => l10n.errorPlaceNotFound,
    FailureCode.unknown => l10n.errorGeneric,
  };
}

String failureMessage(BuildContext context, Object error) {
  final l10n = AppLocalizations.of(context);
  if (error is AppFailure) {
    return error.message(l10n);
  }
  return l10n.errorGeneric;
}
