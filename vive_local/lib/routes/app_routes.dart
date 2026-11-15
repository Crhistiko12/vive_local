abstract final class AppRoutes {
  static const String map = '/';
  static const String login = '/login';
  static const String profile = '/profile';

  static String placeDetails(String placeId) => '/place/$placeId';
}
