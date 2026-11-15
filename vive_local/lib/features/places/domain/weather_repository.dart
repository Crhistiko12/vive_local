import 'weather.dart';

abstract interface class WeatherRepository {
  Future<Weather> currentWeather({
    required double latitude,
    required double longitude,
    required String languageCode,
  });
}
