import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vive_local/core/l10n/app_localizations.dart';
import 'package:vive_local/features/onboarding/presentation/welcome_screen.dart';
import 'package:vive_local/routes/app_routes.dart';

void main() {
  testWidgets('welcome screen navigates to login without a back stack', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: AppRoutes.welcome,
      routes: [
        GoRoute(
          path: AppRoutes.welcome,
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) =>
              const Scaffold(body: Text('login-screen')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          locale: const Locale('es'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Bienvenido a ViveLocal'), findsOneWidget);
    expect(
      find.text(
        'Descubre los mejores lugares de Cochabamba, compártelos con la '
        'comunidad y guárdalos para visitarlos cuando quieras.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Comenzar'));
    await tester.pumpAndSettle();

    expect(find.text('login-screen'), findsOneWidget);
    expect(router.canPop(), isFalse);
  });
}
