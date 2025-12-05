import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather.dart';
import '../constants/api_config.dart';

class WeatherApiService {
  static String get apiKey {
    
    if (isApiKeyConfigured() &&
        openWeatherMapApiKey.isNotEmpty &&
        openWeatherMapApiKey != 'YOUR_API_KEY_HERE') {
      return openWeatherMapApiKey;
    }

    final envKey = dotenv.env['OPENWEATHERMAP_API_KEY'];
    if (envKey != null && envKey.isNotEmpty && envKey != 'null') {
      return envKey;
    }


    throw Exception(
      'OpenWeatherMap API key not found. Provide it via --dart-define (OPENWEATHERMAP_API_KEY) or a .env file.\n'
      'Examples:\n'
      '  flutter run --dart-define=OPENWEATHERMAP_API_KEY=your_key_here\n'
      '  OR add OPENWEATHERMAP_API_KEY=your_key_here to a local .env and ensure main() calls dotenv.load()',
    );
  }

  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  static Future<Weather> getWeatherByCity(
    String cityName, {
    String units = 'metric',
  }) async {
    try {
   
      if (apiKey.isEmpty || apiKey == 'null') {
        throw Exception('API Key not found. Please check your .env file');
      }

      final String url = '$baseUrl?q=$cityName&appid=$apiKey&units=$units';
      print('API URL: ${url.replaceAll(apiKey, '***')}');
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

  static String getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@4x.png';
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  @override
  String toString() => message;
}

class SocketException implements Exception {
  final String message;
  SocketException(this.message);
  @override
  String toString() => message;
}
