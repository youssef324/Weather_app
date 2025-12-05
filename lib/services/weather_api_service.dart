import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather.dart';
import '../constants/api_config.dart';

/// API service for interacting with OpenWeatherMap API
class WeatherApiService {
  // API key from config
  static const String apiKey = openWeatherMapApiKey;
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  /// Fetch weather data by city name
  ///
  /// Parameters:
  ///   - cityName: Name of the city to fetch weather for
  ///   - units: Temperature unit ('metric' for Celsius, 'imperial' for Fahrenheit)
  ///
  /// Returns: Weather object containing weather data
  ///
  /// Throws: Exception with descriptive error message
  static Future<Weather> getWeatherByCity(
    String cityName, {
    String units = 'metric',
  }) async {
    try {
      final String url = '$baseUrl?q=$cityName&appid=$apiKey&units=$units';

      final response = await http
          .get(Uri.parse(url))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException(
                'Request timeout. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Weather.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('City not found. Please check the spelling.');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your API key.');
      } else {
        throw Exception(
          'Failed to fetch weather. Error code: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception(
        'No internet connection. Please check your network connection.',
      );
    } on TimeoutException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  /// Fetch weather data by coordinates
  ///
  /// Parameters:
  ///   - latitude: Latitude of the location
  ///   - longitude: Longitude of the location
  ///   - units: Temperature unit ('metric' for Celsius, 'imperial' for Fahrenheit)
  ///
  /// Returns: Weather object containing weather data
  static Future<Weather> getWeatherByCoordinates(
    double latitude,
    double longitude, {
    String units = 'metric',
  }) async {
    try {
      final String url =
          '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=$units';

      final response = await http
          .get(Uri.parse(url))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException(
                'Request timeout. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Weather.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your API key.');
      } else {
        throw Exception(
          'Failed to fetch weather. Error code: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw Exception(
        'No internet connection. Please check your network connection.',
      );
    } on TimeoutException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  /// Get URL for weather icon from OpenWeatherMap
  static String getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@4x.png';
  }
}

/// Custom exception for timeout errors
class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  @override
  String toString() => message;
}

/// Custom exception for socket errors
class SocketException implements Exception {
  final String message;
  SocketException(this.message);
  @override
  String toString() => message;
}
