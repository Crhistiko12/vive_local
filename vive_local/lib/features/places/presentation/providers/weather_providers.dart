import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/l10n/locale_controller.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/weather_service.dart';
import '../../data/open_meteo_weather_repository.dart';
import '../../domain/weather.dart';
import '../../domain/weather_repository.dart';

part 'weather_providers.g.dart';

final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService(dio: ref.watch(dioProvider));
});

@Riverpod(keepAlive: true)
WeatherRepository weatherRepository(Ref ref) => OpenMeteoWeatherRepository(
      ref.watch(weatherServiceProvider),
    );

@riverpod
Future<Weather> placeWeather(
  Ref ref, {
  required double latitude,
  required double longitude,
}) {
  final languageCode =
      ref.watch(localeControllerProvider)?.languageCode ?? 'es';
  return ref
      .watch(weatherRepositoryProvider)
      .currentWeather(
        latitude: latitude,
        longitude: longitude,
        languageCode: languageCode,
      );
}
