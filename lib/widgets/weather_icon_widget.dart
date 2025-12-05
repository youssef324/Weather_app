import 'package:flutter/material.dart';
import '../services/weather_api_service.dart';

/// Widget to display weather icon from OpenWeatherMap
class WeatherIconWidget extends StatelessWidget {
  final String iconCode;
  final double size;

  const WeatherIconWidget({Key? key, required this.iconCode, this.size = 100})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      WeatherApiService.getWeatherIconUrl(iconCode),
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.cloud, size: size, color: Colors.grey);
      },
    );
  }
}
