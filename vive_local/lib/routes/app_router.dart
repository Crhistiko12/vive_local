import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/presentation/login_screen.dart';
import '../features/map/domain/place.dart';
import '../features/map/presentation/map_screen.dart';
import '../features/places/presentation/place_detail_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.map,
    routes: [
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
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
