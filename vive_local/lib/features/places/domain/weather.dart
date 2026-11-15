class Weather {
  const Weather({
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
    required this.cityName,
  });

  final double temperature;
  final double feelsLike;
  final String description;
  final String iconCode;
  final int humidity;
  final double windSpeed;
  final String cityName;

  String get temperatureLabel => '${temperature.round()}°';

  String get feelsLikeLabel => '${feelsLike.round()}°';
}
