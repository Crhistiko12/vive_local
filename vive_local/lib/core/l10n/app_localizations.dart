import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'ViveLocal'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In es, this message translates to:
  /// **'Descubre tu ciudad, vive tu barrio'**
  String get appTagline;

  /// No description provided for @mapTitle.
  ///
  /// In es, this message translates to:
  /// **'Mapa'**
  String get mapTitle;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profileTitle;

  /// No description provided for @loginTitle.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Guarda favoritos, publica lugares y recibe avisos de eventos cercanos.'**
  String get loginSubtitle;

  /// No description provided for @orDivider.
  ///
  /// In es, this message translates to:
  /// **'o'**
  String get orDivider;

  /// No description provided for @signInWithGoogle.
  ///
  /// In es, this message translates to:
  /// **'Continuar con Google'**
  String get signInWithGoogle;

  /// No description provided for @signInWithEmail.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión con correo'**
  String get signInWithEmail;

  /// No description provided for @registerWithEmail.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get registerWithEmail;

  /// No description provided for @createAccountTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear una cuenta'**
  String get createAccountTitle;

  /// No description provided for @emailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get passwordLabel;

  /// No description provided for @nameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get nameLabel;

  /// No description provided for @signOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get signOut;

  /// No description provided for @guest.
  ///
  /// In es, this message translates to:
  /// **'Invitado'**
  String get guest;

  /// No description provided for @notSignedIn.
  ///
  /// In es, this message translates to:
  /// **'No has iniciado sesión'**
  String get notSignedIn;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando…'**
  String get loading;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get close;

  /// No description provided for @errorGeneric.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error inesperado'**
  String get errorGeneric;

  /// No description provided for @errorFirebaseNotConfigured.
  ///
  /// In es, this message translates to:
  /// **'Firebase no está configurado. Ejecuta flutterfire configure.'**
  String get errorFirebaseNotConfigured;

  /// No description provided for @errorAuthCancelled.
  ///
  /// In es, this message translates to:
  /// **'Inicio de sesión cancelado'**
  String get errorAuthCancelled;

  /// No description provided for @errorAuthFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo iniciar sesión'**
  String get errorAuthFailed;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In es, this message translates to:
  /// **'Correo o contraseña incorrectos'**
  String get errorInvalidCredentials;

  /// No description provided for @errorLocationPermission.
  ///
  /// In es, this message translates to:
  /// **'Permiso de ubicación denegado'**
  String get errorLocationPermission;

  /// No description provided for @errorLocationDisabled.
  ///
  /// In es, this message translates to:
  /// **'La ubicación del dispositivo está desactivada'**
  String get errorLocationDisabled;

  /// No description provided for @errorLocationUnavailable.
  ///
  /// In es, this message translates to:
  /// **'No se pudo obtener tu ubicación'**
  String get errorLocationUnavailable;

  /// No description provided for @errorWeatherNotConfigured.
  ///
  /// In es, this message translates to:
  /// **'Falta la API key de OpenWeather'**
  String get errorWeatherNotConfigured;

  /// No description provided for @errorWeatherUnavailable.
  ///
  /// In es, this message translates to:
  /// **'El clima no está disponible'**
  String get errorWeatherUnavailable;

  /// No description provided for @errorNetwork.
  ///
  /// In es, this message translates to:
  /// **'Revisa tu conexión a internet'**
  String get errorNetwork;

  /// No description provided for @errorPlaceNotFound.
  ///
  /// In es, this message translates to:
  /// **'No encontramos este lugar'**
  String get errorPlaceNotFound;

  /// No description provided for @myLocation.
  ///
  /// In es, this message translates to:
  /// **'Mi ubicación'**
  String get myLocation;

  /// No description provided for @openInGoogleMaps.
  ///
  /// In es, this message translates to:
  /// **'Abrir en Google Maps'**
  String get openInGoogleMaps;

  /// No description provided for @googleMapsNotAvailable.
  ///
  /// In es, this message translates to:
  /// **'No se pudo abrir Google Maps'**
  String get googleMapsNotAvailable;

  /// No description provided for @placeDetailsTitle.
  ///
  /// In es, this message translates to:
  /// **'Detalles del lugar'**
  String get placeDetailsTitle;

  /// No description provided for @weatherTitle.
  ///
  /// In es, this message translates to:
  /// **'Clima'**
  String get weatherTitle;

  /// No description provided for @weatherFeelsLike.
  ///
  /// In es, this message translates to:
  /// **'Sensación {temp}°'**
  String weatherFeelsLike(String temp);

  /// No description provided for @weatherHumidity.
  ///
  /// In es, this message translates to:
  /// **'Humedad {value}%'**
  String weatherHumidity(String value);

  /// No description provided for @weatherWind.
  ///
  /// In es, this message translates to:
  /// **'Viento {value} m/s'**
  String weatherWind(String value);

  /// No description provided for @noPlaces.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay lugares cerca'**
  String get noPlaces;

  /// No description provided for @placesLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron cargar los lugares'**
  String get placesLoadError;

  /// No description provided for @demoModeBanner.
  ///
  /// In es, this message translates to:
  /// **'Modo demo: Firebase aún no está conectado'**
  String get demoModeBanner;

  /// No description provided for @viewDetails.
  ///
  /// In es, this message translates to:
  /// **'Ver detalles'**
  String get viewDetails;

  /// No description provided for @language.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @systemLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma del sistema'**
  String get systemLanguage;

  /// No description provided for @spanish.
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In es, this message translates to:
  /// **'Inglés'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In es, this message translates to:
  /// **'Árabe'**
  String get arabic;

  /// No description provided for @emailRequired.
  ///
  /// In es, this message translates to:
  /// **'El correo es obligatorio'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In es, this message translates to:
  /// **'La contraseña es obligatoria'**
  String get passwordRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo no válido'**
  String get invalidEmail;

  /// No description provided for @noAccountRegister.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta? Crear una'**
  String get noAccountRegister;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta? Inicia sesión'**
  String get alreadyHaveAccount;

  /// No description provided for @unlockWithBiometrics.
  ///
  /// In es, this message translates to:
  /// **'Desbloquear con huella'**
  String get unlockWithBiometrics;

  /// No description provided for @favoritesTitle.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get favoritesTitle;

  /// No description provided for @publishTitle.
  ///
  /// In es, this message translates to:
  /// **'Publicar'**
  String get publishTitle;

  /// No description provided for @notificationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notificationsTitle;

  /// No description provided for @coordinatesLabel.
  ///
  /// In es, this message translates to:
  /// **'{lat}, {lng}'**
  String coordinatesLabel(String lat, String lng);

  /// No description provided for @addPlace.
  ///
  /// In es, this message translates to:
  /// **'Añadir lugar'**
  String get addPlace;

  /// No description provided for @createPlaceTitle.
  ///
  /// In es, this message translates to:
  /// **'Nuevo lugar'**
  String get createPlaceTitle;

  /// No description provided for @placeNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre del lugar'**
  String get placeNameLabel;

  /// No description provided for @placeCategoryLabel.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get placeCategoryLabel;

  /// No description provided for @placeLocationHint.
  ///
  /// In es, this message translates to:
  /// **'Ubicación: {lat}, {lng}'**
  String placeLocationHint(String lat, String lng);

  /// No description provided for @usingMapCenter.
  ///
  /// In es, this message translates to:
  /// **'Sin ubicación actual: se usará el centro del mapa'**
  String get usingMapCenter;

  /// No description provided for @savePlace.
  ///
  /// In es, this message translates to:
  /// **'Guardar lugar'**
  String get savePlace;

  /// No description provided for @placeCreated.
  ///
  /// In es, this message translates to:
  /// **'Lugar creado correctamente'**
  String get placeCreated;

  /// No description provided for @errorCreatePlace.
  ///
  /// In es, this message translates to:
  /// **'No se pudo crear el lugar'**
  String get errorCreatePlace;

  /// No description provided for @placeNameRequired.
  ///
  /// In es, this message translates to:
  /// **'El nombre es obligatorio'**
  String get placeNameRequired;

  /// No description provided for @placeCategoryRequired.
  ///
  /// In es, this message translates to:
  /// **'La categoría es obligatoria'**
  String get placeCategoryRequired;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
