abstract final class AppRoutes {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String map = '/map';
  static const String profile = '/profile';

  static String placeDetails(String placeId) => '/map/place/$placeId';
}
