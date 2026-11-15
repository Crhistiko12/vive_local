abstract final class AppEnv {
  static const double defaultLatitude = -17.3938227;
  static const double defaultLongitude = -66.1569255;
  static const double defaultZoom = 13;
  static const double focusedZoom = 16;

  static const String osmTileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String osmUserAgent = 'com.vivelocal.vive_local';
}
