import 'package:flutter/material.dart';
import '../models/city.dart';
import '../models/app_settings.dart';
import '../services/storage_service.dart';

/// Provider for managing favorites and settings
class AppDataProvider extends ChangeNotifier {
  List<City> _favoriteCities = [];
  AppSettings _settings = AppSettings();
  bool _isLoading = false;

  // Getters
  List<City> get favoriteCities => _favoriteCities;
  AppSettings get settings => _settings;
  bool get isLoading => _isLoading;

  /// Initialize data from storage
  Future<void> initializeData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _favoriteCities = await StorageService.getFavoriteCities();
      _settings = await StorageService.getSettings();
    } catch (e) {
      print('Error initializing data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add city to favorites
  Future<void> addFavorite(City city) async {
    final added = await StorageService.addFavoriteCity(city);
    if (added) {
      _favoriteCities.add(city);
      notifyListeners();
    }
  }

  /// Remove city from favorites
  Future<void> removeFavorite(String cityName, String country) async {
    await StorageService.removeFavoriteCity(cityName, country);
    _favoriteCities.removeWhere((c) => c.name == cityName && c.country == country);
    notifyListeners();
  }

  /// Check if city is favorite
  bool isFavorite(String cityName, String country) {
    return _favoriteCities
        .any((c) => c.name == cityName && c.country == country);
  }

  /// Update settings
  Future<void> updateSettings(AppSettings settings) async {
    _settings = settings;
    await StorageService.saveSettings(settings);
    notifyListeners();
  }

  /// Toggle temperature unit
  Future<void> toggleTemperatureUnit() async {
    final newSettings = AppSettings(
      useCelsius: !_settings.useCelsius,
      language: _settings.language,
    );
    await updateSettings(newSettings);
  }
}
