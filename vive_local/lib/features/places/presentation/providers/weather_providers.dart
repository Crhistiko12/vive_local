import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/env.dart';
import '../../../../core/l10n/locale_controller.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/open_weather_repository.dart';
import '../../data/weather_api.dart';
import '../../domain/weather.dart';
import '../../domain/weather_repository.dart';

part 'weather_providers.g.dart';

final openWeatherApiKeyProvider = Provider<String>(
  (ref) => AppEnv.openWeatherApiKey,
);

@Riverpod(keepAlive: true)
WeatherApi weatherApi(Ref ref) => WeatherApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
WeatherRepository weatherRepository(Ref ref) => OpenWeatherRepository(
  ref.watch(weatherApiProvider),
  ref.watch(openWeatherApiKeyProvider),
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
