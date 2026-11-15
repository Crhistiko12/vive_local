import '../../../core/errors/app_failure.dart';
import '../../../core/services/weather_service.dart';
import '../domain/weather.dart';
import '../domain/weather_repository.dart';

class OpenMeteoWeatherRepository implements WeatherRepository {
  OpenMeteoWeatherRepository([WeatherService? service])
      : _service = service ?? WeatherService();

  final WeatherService _service;

  @override
  Future<Weather> currentWeather({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    final data = await _service.getCurrentWeather(latitude, longitude);
    if (data == null) {
      throw const AppFailure(FailureCode.weatherUnavailable);
    }

    final temp = (data['temperature'] as num?)?.toDouble() ?? 0.0;
    final wind = (data['windspeed'] as num?)?.toDouble() ?? 0.0;
    final code = (data['weathercode'] as num?)?.toInt() ?? -1;
    final condition = WeatherService.getWeatherCondition(code);

    return Weather(
      temperature: temp,
      feelsLike: temp,
      description: condition.text,
      iconCode: code.toString(),
      humidity: 50,
      windSpeed: wind,
      cityName: '',
    );
  }
}
