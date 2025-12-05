class AppSettings {
  final bool useCelsius;
  final String language;

  AppSettings({
    this.useCelsius = true,
    this.language = 'en',
  });


  String getTemperatureUnit() => useCelsius ? '°C' : '°F';

  double convertTemperature(double celsius) {
    if (useCelsius) {
      return celsius;
    } else {
      return (celsius * 9 / 5) + 32;
    }
  }

  double convertWindSpeed(double metersPerSecond) {
    if (useCelsius) {
      return metersPerSecond;
    } else {
      return metersPerSecond * 2.237; // m/s to mph
    }
  }


  String getWindSpeedUnit() => useCelsius ? 'm/s' : 'mph';

  Map<String, dynamic> toJson() {
    return {
      'useCelsius': useCelsius,
      'language': language,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      useCelsius: json['useCelsius'] ?? true,
      language: json['language'] ?? 'en',
    );
  }
}
