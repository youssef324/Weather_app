import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/city.dart';
import '../models/app_settings.dart';

/// Service for managing local storage using SharedPreferences
class StorageService {
  static const String _favoritesKey = 'favorites';
  static const String _settingsKey = 'settings';

  /// Get list of favorite cities
  static Future<List<City>> getFavoriteCities() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);

    if (jsonString == null) {
      return [];
    }

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((item) => City.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading favorites: $e');
      return [];
    }
  }

  /// Add a city to favorites
  static Future<bool> addFavoriteCity(City city) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteCities();

    // Check if city already exists
    if (favorites.any((c) => c.name == city.name && c.country == city.country)) {
      return false;
    }

    favorites.add(city);
    final jsonString = json.encode(favorites.map((c) => c.toJson()).toList());
    return await prefs.setString(_favoritesKey, jsonString);
  }

  /// Remove a city from favorites
  static Future<bool> removeFavoriteCity(String cityName, String country) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteCities();

    favorites.removeWhere((c) => c.name == cityName && c.country == country);
    final jsonString = json.encode(favorites.map((c) => c.toJson()).toList());
    return await prefs.setString(_favoritesKey, jsonString);
  }

  /// Check if a city is in favorites
  static Future<bool> isFavorite(String cityName, String country) async {
    final favorites = await getFavoriteCities();
    return favorites.any((c) => c.name == cityName && c.country == country);
  }

  /// Get user settings
  static Future<AppSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_settingsKey);

    if (jsonString == null) {
      return AppSettings();
    }

    try {
      final jsonData = json.decode(jsonString);
      return AppSettings.fromJson(jsonData);
    } catch (e) {
      print('Error loading settings: $e');
      return AppSettings();
    }
  }

  /// Save user settings
  static Future<bool> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(settings.toJson());
    return await prefs.setString(_settingsKey, jsonString);
  }

  /// Clear all data
  static Future<bool> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
