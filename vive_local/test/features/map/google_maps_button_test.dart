import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vive_local/core/l10n/app_localizations.dart';
import 'package:vive_local/core/services/maps_launcher_service.dart';
import 'package:vive_local/features/map/presentation/widgets/google_maps_button.dart';

class _FakeGoogleMapsLauncher {
  _FakeGoogleMapsLauncher({this.error});

  final Object? error;
  int calls = 0;
  double? lat;
  double? lng;
  String? nombre;

  Future<void> call({
    required double lat,
    required double lng,
    required String nombre,
  }) async {
    calls++;
    this.lat = lat;
    this.lng = lng;
    this.nombre = nombre;
    if (error != null) {
      throw error!;
    }
  }
}

Widget _app({
  required _FakeGoogleMapsLauncher launcher,
  required Widget child,
}) {
  return ProviderScope(
    overrides: [googleMapsLauncherProvider.overrideWithValue(launcher.call)],
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  testWidgets('GoogleMapsButton opens the route with the place data', (
    tester,
  ) async {
    final launcher = _FakeGoogleMapsLauncher();

    await tester.pumpWidget(
      _app(
        launcher: launcher,
        child: const GoogleMapsButton(
          latitude: -17.3938,
          longitude: -66.1569,
          placeName: 'Plaza 14 de Septiembre',
        ),
      ),
    );

    expect(find.text('Abrir en Google Maps'), findsOneWidget);
    await tester.tap(find.text('Abrir en Google Maps'));
    await tester.pumpAndSettle();

    expect(launcher.calls, 1);
    expect(launcher.lat, -17.3938);
    expect(launcher.lng, -66.1569);
    expect(launcher.nombre, 'Plaza 14 de Septiembre');
  });

  testWidgets('GoogleMapsButton shows an error when Maps cannot open', (
    tester,
  ) async {
    final launcher = _FakeGoogleMapsLauncher(
      error: const GoogleMapsLaunchException('boom'),
    );

    await tester.pumpWidget(
      _app(
        launcher: launcher,
        child: const GoogleMapsButton(
          latitude: -17.3938,
          longitude: -66.1569,
          placeName: 'Plaza 14 de Septiembre',
        ),
      ),
    );

    await tester.tap(find.text('Abrir en Google Maps'));
    await tester.pumpAndSettle();

    expect(find.text('No se pudo abrir Google Maps'), findsOneWidget);
  });
}
