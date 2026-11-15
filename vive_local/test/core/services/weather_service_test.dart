import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vive_local/core/services/weather_service.dart';

void main() {
  group('WeatherService WMO codes mapping', () {
    test('code 0 maps to Despejado and wb_sunny icon', () {
      final condition = WeatherService.getWeatherCondition(0);
      expect(condition.text, 'Despejado');
      expect(condition.icon, Icons.wb_sunny);
    });

    test('codes 1, 2, 3 map to Parcialmente nublado and cloud icon', () {
      for (final code in [1, 2, 3]) {
        final condition = WeatherService.getWeatherCondition(code);
        expect(condition.text, 'Parcialmente nublado');
        expect(condition.icon, Icons.cloud);
      }
    });

    test('codes 45, 48 map to Niebla and foggy icon', () {
      for (final code in [45, 48]) {
        final condition = WeatherService.getWeatherCondition(code);
        expect(condition.text, 'Niebla');
        expect(condition.icon, Icons.foggy);
      }
    });

    test('codes 51, 53, 55, 61, 63, 65 map to Lluvia and water_drop icon', () {
      for (final code in [51, 53, 55, 61, 63, 65]) {
        final condition = WeatherService.getWeatherCondition(code);
        expect(condition.text, 'Lluvia');
        expect(condition.icon, Icons.water_drop);
      }
    });

    test('codes 71, 73, 75 map to Nieve and ac_unit icon', () {
      for (final code in [71, 73, 75]) {
        final condition = WeatherService.getWeatherCondition(code);
        expect(condition.text, 'Nieve');
        expect(condition.icon, Icons.ac_unit);
      }
    });

    test('codes 95, 96, 99 map to Tormenta and thunderstorm icon', () {
      for (final code in [95, 96, 99]) {
        final condition = WeatherService.getWeatherCondition(code);
        expect(condition.text, 'Tormenta');
        expect(condition.icon, Icons.thunderstorm);
      }
    });

    test('any other code or null maps to Desconocido and help_outline icon', () {
      for (final code in [-1, 4, 100, null]) {
        final condition = WeatherService.getWeatherCondition(code);
        expect(condition.text, 'Desconocido');
        expect(condition.icon, Icons.help_outline);
      }
    });
  });
}
