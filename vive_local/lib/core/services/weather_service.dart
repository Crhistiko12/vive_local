import 'package:dio/dio.dart';
import 'package:material_ui/material_ui.dart';

class WeatherConditionInfo {
  const WeatherConditionInfo({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

class WeatherService {
  WeatherService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast';

  /// Fetches current weather from Open-Meteo without requiring any API key.
  ///
  /// Returns a Map containing:
  /// - 'temperature' (in °C)
  /// - 'windspeed' (in km/h)
  /// - 'weathercode' (WMO code integer)
  Future<Map<String, dynamic>?> getCurrentWeather(
    double lat,
    double lon,
  ) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        baseUrl,
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'current_weather': true,
        },
      );

      final data = response.data;
      if (data == null) {
        return null;
      }

      final currentWeather = data['current_weather'];
      if (currentWeather is Map<String, dynamic>) {
        return {
          ...data,
          ...currentWeather,
          'current_weather': currentWeather,
        };
      } else if (currentWeather is Map) {
        final mapped = Map<String, dynamic>.from(currentWeather);
        return {
          ...data,
          ...mapped,
          'current_weather': mapped,
        };
      }

      return data;
    } catch (_) {
      return null;
    }
  }

  /// Maps WMO weather code to human-readable text and Flutter IconData.
  static WeatherConditionInfo getWeatherCondition(int? code) {
    if (code == null) {
      return const WeatherConditionInfo(
        text: 'Desconocido',
        icon: Icons.help_outline,
      );
    }

    switch (code) {
      case 0:
        return const WeatherConditionInfo(
          text: 'Despejado',
          icon: Icons.wb_sunny,
        );
      case 1:
      case 2:
      case 3:
        return const WeatherConditionInfo(
          text: 'Parcialmente nublado',
          icon: Icons.cloud,
        );
      case 45:
      case 48:
        return const WeatherConditionInfo(
          text: 'Niebla',
          icon: Icons.foggy,
        );
      case 51:
      case 53:
      case 55:
      case 61:
      case 63:
      case 65:
        return const WeatherConditionInfo(
          text: 'Lluvia',
          icon: Icons.water_drop,
        );
      case 71:
      case 73:
      case 75:
        return const WeatherConditionInfo(
          text: 'Nieve',
          icon: Icons.ac_unit,
        );
      case 95:
      case 96:
      case 99:
        return const WeatherConditionInfo(
          text: 'Tormenta',
          icon: Icons.thunderstorm,
        );
      default:
        return const WeatherConditionInfo(
          text: 'Desconocido',
          icon: Icons.help_outline,
        );
    }
  }

  static String getWeatherDescription(int? code) =>
      getWeatherCondition(code).text;

  static IconData getWeatherIcon(int? code) =>
      getWeatherCondition(code).icon;
}

WeatherConditionInfo getWeatherCondition(int? code) =>
    WeatherService.getWeatherCondition(code);
