import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_api_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _currentWeather;
  bool _isLoading = false;
  String? _error;
  String _unit = 'metric';

  Weather? get currentWeather => _currentWeather;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get unit => _unit;

  void setUnit(String unit) {
    _unit = unit;
    notifyListeners();
  }

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

  void clearWeather() {
    _currentWeather = null;
    _error = null;
    notifyListeners();
  }
}
