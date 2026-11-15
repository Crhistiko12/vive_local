import 'package:flutter_test/flutter_test.dart';
import 'package:vive_local/core/errors/app_failure.dart';
import 'package:vive_local/features/places/data/dto/weather_dto.dart';
import 'package:vive_local/features/places/data/open_weather_repository.dart';
import 'package:vive_local/features/places/data/weather_api.dart';

class _FakeWeatherApi implements WeatherApi {
  @override
  Future<WeatherDto> currentWeather({
    required double latitude,
    required double longitude,
    required String appId,
    required String units,
    required String lang,
  }) async {
    return const WeatherDto(
      weather: [
        WeatherConditionDto(description: 'lluvia ligera', icon: '10d'),
      ],
      main: MainWeatherDto(temp: 12.5, feelsLike: 11.0, humidity: 80),
      wind: WindDto(speed: 4.5),
      name: 'La Paz',
    );
  }
}

void main() {
  group('OpenWeatherRepository', () {
    test('throws weatherNotConfigured when the api key is empty', () async {
      final repository = OpenWeatherRepository(_FakeWeatherApi(), '');

      await expectLater(
        repository.currentWeather(
          latitude: 0,
          longitude: 0,
          languageCode: 'es',
        ),
        throwsA(
          isA<AppFailure>().having(
            (failure) => failure.code,
            'code',
            FailureCode.weatherNotConfigured,
          ),
        ),
      );
    });

    test('maps the API response into the domain model', () async {
      final repository = OpenWeatherRepository(_FakeWeatherApi(), 'test-key');

      final weather = await repository.currentWeather(
        latitude: -16.5,
        longitude: -68.1,
        languageCode: 'es',
      );

      expect(weather.temperature, 12.5);
      expect(weather.feelsLike, 11.0);
      expect(weather.description, 'lluvia ligera');
      expect(weather.humidity, 80);
      expect(weather.windSpeed, 4.5);
      expect(weather.cityName, 'La Paz');
    });
  });
}
