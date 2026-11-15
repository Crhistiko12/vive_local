import 'package:flutter_test/flutter_test.dart';
import 'package:vive_local/routes/app_router.dart';
import 'package:vive_local/routes/app_routes.dart';

void main() {
  group('resolveAuthRedirect', () {
    test('sends unauthenticated users from protected routes to welcome', () {
      for (final location in [
        AppRoutes.map,
        '/map/place/plaza-14-de-septiembre',
        AppRoutes.profile,
      ]) {
        expect(
          resolveAuthRedirect(isAuthenticated: false, location: location),
          AppRoutes.welcome,
        );
      }
    });

    test('keeps unauthenticated users on auth routes', () {
      expect(
        resolveAuthRedirect(
          isAuthenticated: false,
          location: AppRoutes.welcome,
        ),
        isNull,
      );
      expect(
        resolveAuthRedirect(
          isAuthenticated: false,
          location: AppRoutes.login,
        ),
        isNull,
      );
    });

    test('sends authenticated users from auth routes to the map', () {
      for (final location in [AppRoutes.welcome, AppRoutes.login]) {
        expect(
          resolveAuthRedirect(isAuthenticated: true, location: location),
          AppRoutes.map,
        );
      }
    });

    test('keeps authenticated users on protected routes', () {
      for (final location in [
        AppRoutes.map,
        '/map/place/plaza-14-de-septiembre',
        AppRoutes.profile,
      ]) {
        expect(
          resolveAuthRedirect(isAuthenticated: true, location: location),
          isNull,
        );
      }
    });
  });
}
