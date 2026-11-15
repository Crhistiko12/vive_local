import 'package:json_annotation/json_annotation.dart';

part 'weather_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class WeatherDto {
  const WeatherDto({
    required this.weather,
    required this.main,
    this.wind,
    this.name,
  });

  factory WeatherDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherDtoFromJson(json);

  final List<WeatherConditionDto> weather;
  final MainWeatherDto main;
  final WindDto? wind;
  final String? name;
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class WeatherConditionDto {
  const WeatherConditionDto({
    required this.description,
    required this.icon,
  });

  factory WeatherConditionDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionDtoFromJson(json);

  final String description;
  final String icon;
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class MainWeatherDto {
  const MainWeatherDto({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
  });

  factory MainWeatherDto.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherDtoFromJson(json);

  final double temp;
  final double feelsLike;
  final int humidity;
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class WindDto {
  const WindDto({required this.speed});

  factory WindDto.fromJson(Map<String, dynamic> json) =>
      _$WindDtoFromJson(json);

  final double speed;
}
