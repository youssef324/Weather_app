/// Settings model for storing user preferences
class AppSettings {
  final bool useCelsius;
  final String language;

  AppSettings({
    this.useCelsius = true,
    this.language = 'en',
  });

  /// Get temperature unit symbol (°C or °F)
  String getTemperatureUnit() => useCelsius ? '°C' : '°F';

  /// Convert temperature between Celsius and Fahrenheit
  double convertTemperature(double celsius) {
    if (useCelsius) {
      return celsius;
    } else {
      return (celsius * 9 / 5) + 32;
    }
  }

  /// Convert wind speed (m/s to m/s or mph)
  double convertWindSpeed(double metersPerSecond) {
    if (useCelsius) {
      return metersPerSecond;
    } else {
      return metersPerSecond * 2.237; // m/s to mph
    }
  }

  /// Get wind speed unit
  String getWindSpeedUnit() => useCelsius ? 'm/s' : 'mph';

  /// Convert AppSettings to JSON
  Map<String, dynamic> toJson() {
    return {
      'useCelsius': useCelsius,
      'language': language,
    };
  }

  /// Factory constructor to create AppSettings from JSON
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      useCelsius: json['useCelsius'] ?? true,
      language: json['language'] ?? 'en',
    );
  }
}
