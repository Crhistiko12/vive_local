abstract final class AppEnv {
  static const String openWeatherApiKey = String.fromEnvironment(
    'OPENWEATHER_API_KEY',
  );

  static const double defaultLatitude = -17.3938227;
  static const double defaultLongitude = -66.1569255;
  static const double defaultZoom = 13;
  static const double focusedZoom = 16;

  static const String osmTileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String osmUserAgent = 'com.vivelocal.vive_local';
  static const String openWeatherIconUrl =
      'https://openweathermap.org/img/wn';
}
