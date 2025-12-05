import 'package:flutter/material.dart';
import '../models/city.dart';
import '../models/app_settings.dart';
import '../services/storage_service.dart';

class AppDataProvider extends ChangeNotifier {
  List<City> _favoriteCities = [];
  AppSettings _settings = AppSettings();
  bool _isLoading = false;

  List<City> get favoriteCities => _favoriteCities;
  AppSettings get settings => _settings;
  bool get isLoading => _isLoading;

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
  Future<void> addFavorite(City city) async {
    final added = await StorageService.addFavoriteCity(city);
    if (added) {
      _favoriteCities.add(city);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String cityName, String country) async {
    await StorageService.removeFavoriteCity(cityName, country);
    _favoriteCities.removeWhere((c) => c.name == cityName && c.country == country);
    notifyListeners();
  }
  bool isFavorite(String cityName, String country) {
    return _favoriteCities
        .any((c) => c.name == cityName && c.country == country);
  }
  Future<void> updateSettings(AppSettings settings) async {
    _settings = settings;
    await StorageService.saveSettings(settings);
    notifyListeners();
  }
  Future<void> toggleTemperatureUnit() async {
    final newSettings = AppSettings(
      useCelsius: !_settings.useCelsius,
      language: _settings.language,
    );
    await updateSettings(newSettings);
  }
}
