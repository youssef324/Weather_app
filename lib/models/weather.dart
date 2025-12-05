
class Weather {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;
  final int timezone;
  final double pressure;
  final int visibility;

  Weather({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.timezone,
    required this.pressure,
    required this.visibility,
  });


  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? 'Unknown',
      country: json['sys']['country'] ?? 'Unknown',
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      description: json['weather'][0]['main'] ?? 'Unknown',
      icon: json['weather'][0]['icon'] ?? '01d',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      sunrise: json['sys']['sunrise'] ?? 0,
      sunset: json['sys']['sunset'] ?? 0,
      timezone: json['timezone'] ?? 0,
      pressure: (json['main']['pressure'] as num).toDouble(),
      visibility: json['visibility'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'country': country,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'description': description,
      'icon': icon,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'sunrise': sunrise,
      'sunset': sunset,
      'timezone': timezone,
      'pressure': pressure,
      'visibility': visibility,
    };
  }
}
