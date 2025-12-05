import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../models/app_settings.dart';
import 'weather_icon_widget.dart';

/// Widget to display detailed weather information
class WeatherDetailsCard extends StatelessWidget {
  final Weather weather;
  final AppSettings settings;

  const WeatherDetailsCard({
    Key? key,
    required this.weather,
    required this.settings,
  }) : super(key: key);

  /// Format Unix timestamp to local time
  String _formatTime(int unixTimestamp, int timezone) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      unixTimestamp * 1000 + timezone * 1000,
    );
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final convertedTemp = settings.convertTemperature(weather.temperature);
    final convertedFeelsLike = settings.convertTemperature(weather.feelsLike);
    final convertedWindSpeed = settings.convertWindSpeed(weather.windSpeed);

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Weather icon and main info
              WeatherIconWidget(iconCode: weather.icon, size: 120),
              const SizedBox(height: 16),
              Text(
                '${weather.cityName}, ${weather.country}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${convertedTemp.toStringAsFixed(1)}${settings.getTemperatureUnit()}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                weather.description,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Detailed info grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.2,
                children: [
                  _buildInfoItem(
                    'Feels Like',
                    '${convertedFeelsLike.toStringAsFixed(1)}${settings.getTemperatureUnit()}',
                  ),
                  _buildInfoItem('Humidity', '${weather.humidity}%'),
                  _buildInfoItem(
                    'Wind Speed',
                    '${convertedWindSpeed.toStringAsFixed(1)} ${settings.getWindSpeedUnit()}',
                  ),
                  _buildInfoItem(
                    'Pressure',
                    '${weather.pressure.toStringAsFixed(0)} hPa',
                  ),
                  _buildInfoItem(
                    'Visibility',
                    '${(weather.visibility / 1000).toStringAsFixed(1)} km',
                  ),
                  _buildInfoItem(
                    'Sunrise',
                    _formatTime(weather.sunrise, weather.timezone),
                  ),
                  _buildInfoItem(
                    'Sunset',
                    _formatTime(weather.sunset, weather.timezone),
                  ),
                  _buildInfoItem(
                    'Timezone',
                    'UTC${weather.timezone > 0 ? '+' : ''}${(weather.timezone / 3600).toStringAsFixed(0)}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build individual info item
  Widget _buildInfoItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
