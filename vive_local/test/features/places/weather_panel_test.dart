import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vive_local/core/l10n/app_localizations.dart';
import 'package:vive_local/features/places/domain/weather.dart';
import 'package:vive_local/features/places/presentation/widgets/weather_panel.dart';

const _weather = Weather(
  temperature: 18.4,
  feelsLike: 17.9,
  description: 'cielo claro',
  iconCode: '01d',
  humidity: 55,
  windSpeed: 3.2,
  cityName: 'La Paz',
);

Widget _app(Widget child) {
  return MaterialApp(
    locale: const Locale('es'),
    localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

void main() {
  testWidgets('WeatherPanel renders the temperature in the data state', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(const WeatherPanel(weather: AsyncData(_weather))),
    );
    await tester.pump();

    expect(find.text('18° · cielo claro'), findsOneWidget);
    expect(find.text('Sensación 18°'), findsOneWidget);
  });

  testWidgets('WeatherPanel renders a retry action in the error state', (
    tester,
  ) async {
    var retried = false;

    await tester.pumpWidget(
      _app(
        WeatherPanel(
          weather: AsyncError(Exception('fail'), StackTrace.empty),
          onRetry: () => retried = true,
        ),
      ),
    );

    await tester.tap(find.text('Reintentar'));
    await tester.pump();

    expect(retried, isTrue);
  });

  testWidgets('WeatherPanel renders a progress indicator while loading', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(const WeatherPanel(weather: AsyncLoading())),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
