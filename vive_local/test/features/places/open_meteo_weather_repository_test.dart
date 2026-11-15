import 'package:flutter_test/flutter_test.dart';
import 'package:vive_local/core/errors/app_failure.dart';
import 'package:vive_local/core/services/weather_service.dart';
import 'package:vive_local/features/places/data/open_meteo_weather_repository.dart';

class _FakeWeatherService extends WeatherService {
  _FakeWeatherService({this.responseData});

  final Map<String, dynamic>? responseData;

  @override
  Future<Map<String, dynamic>?> getCurrentWeather(
    double lat,
    double lon,
  ) async {
    return responseData;
  }
}

void main() {
  group('OpenMeteoWeatherRepository', () {
    test('maps Open-Meteo response into Weather domain model', () async {
      final service = _FakeWeatherService(
        responseData: {
          'temperature': 21.4,
          'windspeed': 5.2,
          'weathercode': 0,
        },
      );
      final repository = OpenMeteoWeatherRepository(service);

      final weather = await repository.currentWeather(
        latitude: -17.38,
        longitude: -66.15,
        languageCode: 'es',
      );

      expect(weather.temperature, 21.4);
      expect(weather.description, 'Despejado');
      expect(weather.windSpeed, 5.2);
      expect(weather.temperatureLabel, '21°');
    });

    test('throws weatherUnavailable when response is null', () async {
      final service = _FakeWeatherService(responseData: null);
      final repository = OpenMeteoWeatherRepository(service);

      await expectLater(
        repository.currentWeather(
          latitude: 0,
          longitude: 0,
          languageCode: 'es',
        ),
        throwsA(
          isA<AppFailure>().having(
            (f) => f.code,
            'code',
            FailureCode.weatherUnavailable,
          ),
        ),
      );
    });
  });
}
