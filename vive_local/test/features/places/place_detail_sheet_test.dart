import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vive_local/core/l10n/app_localizations.dart';
import 'package:vive_local/core/services/weather_service.dart';
import 'package:vive_local/features/map/domain/place.dart';
import 'package:vive_local/features/places/domain/lugar_foto.dart';
import 'package:vive_local/features/places/presentation/providers/place_photos_providers.dart';
import 'package:vive_local/features/places/presentation/widgets/place_detail_sheet.dart';

class _FakeWeatherService extends WeatherService {
  _FakeWeatherService({this.data});

  final Map<String, dynamic>? data;

  @override
  Future<Map<String, dynamic>?> getCurrentWeather(
    double lat,
    double lon,
  ) async {
    return data;
  }
}

void main() {
  const place = Place(
    id: 'cristo-de-la-concordia',
    name: 'Cristo de la Concordia',
    latitude: -17.3843,
    longitude: -66.1349,
    category: 'Monumento',
    address: 'Cerro San Pedro',
    description: 'Gran monumento con vista panorámica',
    rating: 4.8,
  );

  Widget buildTestWidget({WeatherService? weatherService}) {
    return ProviderScope(
      overrides: [
        placePhotosProvider('cristo-de-la-concordia').overrideWith(
          (ref) async => <LugarFoto>[
            const LugarFoto(
              id: 1,
              lugarId: 'cristo-de-la-concordia',
              imagePath: 'https://example.com/cristo.jpg',
              esLocal: false,
            ),
          ],
        ),
      ],
      child: MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: PlaceDetailSheet(
            place: place,
            weatherService: weatherService,
          ),
        ),
      ),
    );
  }

  testWidgets('PlaceDetailSheet renders place info, weather row, and gallery',
      (tester) async {
    final fakeWeather = _FakeWeatherService(
      data: {
        'temperature': 21.0,
        'windspeed': 4.0,
        'weathercode': 0,
      },
    );

    await tester.pumpWidget(buildTestWidget(weatherService: fakeWeather));
    await tester.pumpAndSettle();

    expect(find.text('Cristo de la Concordia'), findsOneWidget);
    expect(find.text('Monumento'), findsOneWidget);
    expect(find.text('4.8'), findsOneWidget);
    expect(find.text('Cerro San Pedro'), findsOneWidget);
    expect(find.text('Gran monumento con vista panorámica'), findsOneWidget);
    expect(find.text('21°C'), findsOneWidget);
    expect(find.text('Despejado'), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    expect(find.text('Ver detalles'), findsOneWidget);
    expect(find.text('Abrir en Google Maps'), findsOneWidget);
  });

  testWidgets('PlaceDetailSheet renders Clima no disponible when weather fails',
      (tester) async {
    final fakeWeather = _FakeWeatherService(data: null);

    await tester.pumpWidget(buildTestWidget(weatherService: fakeWeather));
    await tester.pumpAndSettle();

    expect(find.text('Clima no disponible'), findsOneWidget);
  });
}
