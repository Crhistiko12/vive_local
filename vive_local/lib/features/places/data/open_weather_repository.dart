import 'package:dio/dio.dart';

import '../../../core/errors/app_failure.dart';
import '../domain/weather.dart';
import '../domain/weather_repository.dart';
import 'dto/weather_dto.dart';
import 'weather_api.dart';

class OpenWeatherRepository implements WeatherRepository {
  OpenWeatherRepository(this._api, this._apiKey);

  final WeatherApi _api;
  final String _apiKey;

  @override
  Future<Weather> currentWeather({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    if (_apiKey.trim().isEmpty) {
      throw const AppFailure(FailureCode.weatherNotConfigured);
    }

    try {
      final dto = await _api.currentWeather(
        latitude: latitude,
        longitude: longitude,
        appId: _apiKey,
        units: 'metric',
        lang: languageCode,
      );
      return _toDomain(dto);
    } on DioException catch (error, stackTrace) {
      if (error.response?.statusCode == 401) {
        throw AppFailure(
          FailureCode.weatherNotConfigured,
          cause: error,
          stackTrace: stackTrace,
        );
      }
      throw AppFailure(
        FailureCode.weatherUnavailable,
        cause: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw AppFailure(
        FailureCode.weatherUnavailable,
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  Weather _toDomain(WeatherDto dto) {
    final condition = dto.weather.isEmpty ? null : dto.weather.first;
    return Weather(
      temperature: dto.main.temp,
      feelsLike: dto.main.feelsLike,
      description: condition?.description ?? '',
      iconCode: condition?.icon ?? '01d',
      humidity: dto.main.humidity,
      windSpeed: dto.wind?.speed ?? 0,
      cityName: dto.name ?? '',
    );
  }
}
