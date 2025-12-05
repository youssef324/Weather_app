import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_api_service.dart';

/// Provider for managing weather data
class WeatherProvider extends ChangeNotifier {
  Weather? _currentWeather;
  bool _isLoading = false;
  String? _error;
  String _unit = 'metric';

  // Getters
  Weather? get currentWeather => _currentWeather;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get unit => _unit;

  /// Set temperature unit (metric or imperial)
  void setUnit(String unit) {
    _unit = unit;
    notifyListeners();
  }

  /// Fetch weather by city name
  Future<void> fetchWeatherByCity(String cityName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentWeather = await WeatherApiService.getWeatherByCity(
        cityName,
        units: _unit,
      );
      _error = null;
    } catch (e) {
      _error = e.toString();
      _currentWeather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Fetch weather by coordinates
  Future<void> fetchWeatherByCoordinates(
      double latitude, double longitude) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentWeather = await WeatherApiService.getWeatherByCoordinates(
        latitude,
        longitude,
        units: _unit,
      );
      _error = null;
    } catch (e) {
      _error = e.toString();
      _currentWeather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear current weather
  void clearWeather() {
    _currentWeather = null;
    _error = null;
    notifyListeners();
  }
}
