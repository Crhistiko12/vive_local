import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/presentation/providers/auth_providers.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/map/domain/place.dart';
import '../features/map/presentation/map_screen.dart';
import '../features/onboarding/presentation/welcome_screen.dart';
import '../features/places/presentation/place_detail_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

bool _isAuthRoute(String location) =>
    location == AppRoutes.welcome || location == AppRoutes.login;

String? resolveAuthRedirect({
  required bool isAuthenticated,
  required String location,
}) {
  if (!isAuthenticated) {
    return _isAuthRoute(location) ? null : AppRoutes.welcome;
  }
  return _isAuthRoute(location) ? AppRoutes.map : null;
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);
  ref.listen(authStateChangesProvider, (_, _) => refresh.value++);

  return GoRouter(
    initialLocation: AppRoutes.welcome,
    refreshListenable: refresh,
    redirect: (context, state) {
      final isAuthenticated =
          ref.read(authRepositoryProvider).currentUser != null;
      return resolveAuthRedirect(
        isAuthenticated: isAuthenticated,
        location: state.matchedLocation,
      );
    },
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.map,
        builder: (context, state) => const MapScreen(),
        routes: [
          GoRoute(
            path: 'place/:id',
            builder: (context, state) {
              final extra = state.extra;
              return PlaceDetailScreen(
                placeId: state.pathParameters['id']!,
                initialPlace: extra is Place ? extra : null,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
