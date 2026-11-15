// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'ViveLocal';

  @override
  String get appTagline => 'Descubre tu ciudad, vive tu barrio';

  @override
  String get mapTitle => 'Mapa';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get loginTitle => 'Inicia sesión';

  @override
  String get loginSubtitle =>
      'Guarda favoritos, publica lugares y recibe avisos de eventos cercanos.';

  @override
  String get welcomeTitle => 'Bienvenido a ViveLocal';

  @override
  String get welcomeSubtitle =>
      'Descubre los mejores lugares de Cochabamba, compártelos con la comunidad y guárdalos para visitarlos cuando quieras.';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get signOutConfirmation => '¿Seguro que quieres cerrar sesión?';

  @override
  String get orDivider => 'o';

  @override
  String get signInWithGoogle => 'Continuar con Google';

  @override
  String get signInWithEmail => 'Iniciar sesión con correo';

  @override
  String get registerWithEmail => 'Crear cuenta';

  @override
  String get createAccountTitle => 'Crear una cuenta';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get guest => 'Invitado';

  @override
  String get notSignedIn => 'No has iniciado sesión';

  @override
  String get loading => 'Cargando…';

  @override
  String get retry => 'Reintentar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Cerrar';

  @override
  String get errorGeneric => 'Ocurrió un error inesperado';

  @override
  String get errorFirebaseNotConfigured =>
      'Firebase no está configurado. Ejecuta flutterfire configure.';

  @override
  String get errorAuthCancelled => 'Inicio de sesión cancelado';

  @override
  String get errorAuthFailed => 'No se pudo iniciar sesión';

  @override
  String get errorInvalidCredentials => 'Correo o contraseña incorrectos';

  @override
  String get errorLocationPermission => 'Permiso de ubicación denegado';

  @override
  String get errorLocationDisabled =>
      'La ubicación del dispositivo está desactivada';

  @override
  String get errorLocationUnavailable => 'No se pudo obtener tu ubicación';

  @override
  String get errorWeatherNotConfigured => 'Falta la API key de OpenWeather';

  @override
  String get errorWeatherUnavailable => 'El clima no está disponible';

  @override
  String get errorNetwork => 'Revisa tu conexión a internet';

  @override
  String get errorPlaceNotFound => 'No encontramos este lugar';

  @override
  String get myLocation => 'Mi ubicación';

  @override
  String get openInGoogleMaps => 'Abrir en Google Maps';

  @override
  String get googleMapsNotAvailable => 'No se pudo abrir Google Maps';

  @override
  String get placeDetailsTitle => 'Detalles del lugar';

  @override
  String get weatherTitle => 'Clima';

  @override
  String weatherFeelsLike(String temp) {
    return 'Sensación $temp°';
  }

  @override
  String weatherHumidity(String value) {
    return 'Humedad $value%';
  }

  @override
  String weatherWind(String value) {
    return 'Viento $value m/s';
  }

  @override
  String get noPlaces => 'Aún no hay lugares cerca';

  @override
  String get placesLoadError => 'No se pudieron cargar los lugares';

  @override
  String get demoModeBanner => 'Modo demo: Firebase aún no está conectado';

  @override
  String get viewDetails => 'Ver detalles';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Idioma del sistema';

  @override
  String get spanish => 'Español';

  @override
  String get english => 'Inglés';

  @override
  String get arabic => 'Árabe';

  @override
  String get emailRequired => 'El correo es obligatorio';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get invalidEmail => 'Correo no válido';

  @override
  String get noAccountRegister => '¿No tienes cuenta? Crear una';

  @override
  String get alreadyHaveAccount => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get unlockWithBiometrics => 'Desbloquear con huella';

  @override
  String get favoritesTitle => 'Favoritos';

  @override
  String get publishTitle => 'Publicar';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String coordinatesLabel(String lat, String lng) {
    return '$lat, $lng';
  }

  @override
  String get addPlace => 'Añadir lugar';

  @override
  String get createPlaceTitle => 'Nuevo lugar';

  @override
  String get placeNameLabel => 'Nombre del lugar';

  @override
  String get placeCategoryLabel => 'Categoría';

  @override
  String placeLocationHint(String lat, String lng) {
    return 'Ubicación: $lat, $lng';
  }

  @override
  String get usingMapCenter =>
      'Sin ubicación actual: se usará el centro del mapa';

  @override
  String get savePlace => 'Guardar lugar';

  @override
  String get placeCreated => 'Lugar creado correctamente';

  @override
  String get errorCreatePlace => 'No se pudo crear el lugar';

  @override
  String get placeNameRequired => 'El nombre es obligatorio';

  @override
  String get placeCategoryRequired => 'La categoría es obligatoria';

  @override
  String get placePhotoLabel => 'Foto del lugar (opcional)';

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get chooseFromGallery => 'Elegir de galería';

  @override
  String get removePhoto => 'Quitar foto';

  @override
  String get errorPhotoPick =>
      'No se pudo obtener la foto. Inténtalo de nuevo.';

  @override
  String get errorPhotoUpload =>
      'No se pudo subir la foto. Inténtalo de nuevo.';
}
