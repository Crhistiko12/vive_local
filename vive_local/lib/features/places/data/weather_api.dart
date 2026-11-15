import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'dto/weather_dto.dart';

part 'weather_api.g.dart';

@RestApi(baseUrl: 'https://api.openweathermap.org')
abstract class WeatherApi {
  factory WeatherApi(Dio dio, {String? baseUrl}) = _WeatherApi;

  @GET('/data/2.5/weather')
  Future<WeatherDto> currentWeather({
    @Query('lat') required double latitude,
    @Query('lon') required double longitude,
    @Query('appid') required String appId,
    @Query('units') required String units,
    @Query('lang') required String lang,
  });
}
