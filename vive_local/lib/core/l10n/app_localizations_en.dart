// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ViveLocal';

  @override
  String get appTagline => 'Discover your city, live your neighborhood';

  @override
  String get mapTitle => 'Map';

  @override
  String get profileTitle => 'Profile';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle =>
      'Save favorites, publish places and get alerts about nearby events.';

  @override
  String get orDivider => 'or';

  @override
  String get signInWithGoogle => 'Continue with Google';

  @override
  String get signInWithEmail => 'Sign in with email';

  @override
  String get registerWithEmail => 'Create account';

  @override
  String get createAccountTitle => 'Create an account';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get nameLabel => 'Name';

  @override
  String get signOut => 'Sign out';

  @override
  String get guest => 'Guest';

  @override
  String get notSignedIn => 'You are not signed in';

  @override
  String get loading => 'Loading…';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get errorGeneric => 'An unexpected error occurred';

  @override
  String get errorFirebaseNotConfigured =>
      'Firebase is not configured. Run flutterfire configure.';

  @override
  String get errorAuthCancelled => 'Sign in cancelled';

  @override
  String get errorAuthFailed => 'Could not sign in';

  @override
  String get errorInvalidCredentials => 'Wrong email or password';

  @override
  String get errorLocationPermission => 'Location permission denied';

  @override
  String get errorLocationDisabled => 'Device location is disabled';

  @override
  String get errorLocationUnavailable => 'Could not get your location';

  @override
  String get errorWeatherNotConfigured => 'OpenWeather API key is missing';

  @override
  String get errorWeatherUnavailable => 'Weather is not available';

  @override
  String get errorNetwork => 'Check your internet connection';

  @override
  String get errorPlaceNotFound => 'We could not find this place';

  @override
  String get myLocation => 'My location';

  @override
  String get openInGoogleMaps => 'Open in Google Maps';

  @override
  String get googleMapsNotAvailable => 'Could not open Google Maps';

  @override
  String get placeDetailsTitle => 'Place details';

  @override
  String get weatherTitle => 'Weather';

  @override
  String weatherFeelsLike(String temp) {
    return 'Feels like $temp°';
  }

  @override
  String weatherHumidity(String value) {
    return 'Humidity $value%';
  }

  @override
  String weatherWind(String value) {
    return 'Wind $value m/s';
  }

  @override
  String get noPlaces => 'No places nearby yet';

  @override
  String get placesLoadError => 'Could not load places';

  @override
  String get demoModeBanner => 'Demo mode: Firebase is not connected yet';

  @override
  String get viewDetails => 'View details';

  @override
  String get language => 'Language';

  @override
  String get systemLanguage => 'System language';

  @override
  String get spanish => 'Spanish';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get noAccountRegister => 'No account? Create one';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign in';

  @override
  String get unlockWithBiometrics => 'Unlock with fingerprint';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get publishTitle => 'Publish';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String coordinatesLabel(String lat, String lng) {
    return '$lat, $lng';
  }

  @override
  String get addPlace => 'Add place';

  @override
  String get createPlaceTitle => 'New place';

  @override
  String get placeNameLabel => 'Place name';

  @override
  String get placeCategoryLabel => 'Category';

  @override
  String placeLocationHint(String lat, String lng) {
    return 'Location: $lat, $lng';
  }

  @override
  String get usingMapCenter => 'No current location: using the map center';

  @override
  String get savePlace => 'Save place';

  @override
  String get placeCreated => 'Place created successfully';

  @override
  String get errorCreatePlace => 'Could not create the place';

  @override
  String get placeNameRequired => 'Name is required';

  @override
  String get placeCategoryRequired => 'Category is required';
}
