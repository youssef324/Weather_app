import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../providers/app_data_provider.dart';
import '../widgets/weather_details_card.dart';
import '../models/city.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadSearchHistory();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSearchHistory() async {
    setState(() {
      _searchHistory = ['London', 'New York', 'Tokyo', 'Paris', 'Sydney'];
    });
  }

  void _handleSearch(String cityName) {
    if (cityName.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a city name')));
      return;
    }

    if (!_searchHistory.contains(cityName)) {
      _searchHistory.insert(0, cityName);
      if (_searchHistory.length > 5) {
        _searchHistory.removeLast();
      }
    }

    context.read<WeatherProvider>().fetchWeatherByCity(cityName);
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final appDataProvider = context.read<AppDataProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Weather App'), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a city...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: _handleSearch,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _handleSearch(_searchController.text),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Search', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 32),

              if (_searchHistory.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Searches',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _searchHistory
                          .map(
                            (city) => ActionChip(
                              label: Text(city),
                              onPressed: () => _handleSearch(city),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),

              Consumer<WeatherProvider>(
                builder: (context, weatherProvider, _) {
                  if (weatherProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (weatherProvider.error != null) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          const SizedBox(height: 8),
                          Text(
                            'Error',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            weatherProvider.error ?? '',
                            style: TextStyle(color: Colors.red[700]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  if (weatherProvider.currentWeather != null) {
                    return Column(
                      children: [
                        WeatherDetailsCard(
                          weather: weatherProvider.currentWeather!,
                          settings: appDataProvider.settings,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final weather = weatherProvider.currentWeather!;
                              final city = City(
                                name: weather.cityName,
                                country: weather.country,
                                latitude: 0,
                                longitude: 0,
                              );
                              appDataProvider.addFavorite(city);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to favorites!'),
                                ),
                              );
                            },
                            icon: Icon(
                              appDataProvider.isFavorite(
                                    weatherProvider.currentWeather!.cityName,
                                    weatherProvider.currentWeather!.country,
                                  )
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            label: const Text('Add to Favorites'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.cloud_queue,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search for a city to see weather',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
