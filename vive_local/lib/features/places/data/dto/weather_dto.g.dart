// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDto _$WeatherDtoFromJson(Map<String, dynamic> json) => WeatherDto(
  weather: (json['weather'] as List<dynamic>)
      .map((e) => WeatherConditionDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  main: MainWeatherDto.fromJson(json['main'] as Map<String, dynamic>),
  wind: json['wind'] == null
      ? null
      : WindDto.fromJson(json['wind'] as Map<String, dynamic>),
  name: json['name'] as String?,
);

WeatherConditionDto _$WeatherConditionDtoFromJson(Map<String, dynamic> json) =>
    WeatherConditionDto(
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

MainWeatherDto _$MainWeatherDtoFromJson(Map<String, dynamic> json) =>
    MainWeatherDto(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
    );

WindDto _$WindDtoFromJson(Map<String, dynamic> json) =>
    WindDto(speed: (json['speed'] as num).toDouble());
