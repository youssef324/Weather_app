# Weather App - Multi-Page Flutter Application

A comprehensive Flutter weather application that fetches and displays real-time weather data using the OpenWeatherMap Current Weather API. The app features a clean, responsive UI with multiple screens for searching weather, managing favorites, and configuring settings.

> ⚠️ **SECURITY NOTE**: This project uses secure environment variables for API keys. Your API key will never be committed to git. See [API_KEY_SECURITY.md](API_KEY_SECURITY.md) for detailed setup instructions.

## Features

### ✅ Core Features Implemented

- **Search Screen**: Search for weather by city name with recent search history
- **Weather Details**: Display comprehensive weather information including:
  - Current temperature with "feels like" indicator
  - Weather description and condition icon
  - Humidity, wind speed, and atmospheric pressure
  - Visibility and timezone information
  - Sunrise and sunset times with local time formatting
  
- **Favorites Management**: 
  - Save favorite cities for quick access
  - View all saved favorite cities in a dedicated screen
  - Quick weather lookup by tapping favorites
  
- **Settings Screen**:
  - Temperature unit toggle (Celsius/Fahrenheit)
  - Wind speed unit conversion (m/s/mph)
  - App information and API key setup instructions
  
- **State Management**: Using Provider for efficient state management
- **Local Storage**: SharedPreferences for persisting favorites and settings
- **Error Handling**: Comprehensive error messages for network issues and invalid cities
- **Responsive UI**: Material Design 3 with adaptive layouts

## Project Structure

```
lib/
├── main.dart                    # App entry point and navigation setup
├── models/                      # Data models
│   ├── weather.dart            # Weather data model with API parsing
│   ├── city.dart               # City/Favorite model
│   ├── app_settings.dart       # User settings and preferences
│   └── index.dart              # Barrel file (exports all models)
├── services/                    # Business logic and API calls
│   ├── weather_api_service.dart # OpenWeatherMap API integration
│   ├── storage_service.dart    # Local storage management
│   └── index.dart              # Barrel file (exports all services)
├── providers/                   # State management (Provider)
│   ├── weather_provider.dart   # Weather data state management
│   ├── app_data_provider.dart  # Favorites and settings management
├── pages/                       # Screen UI
│   ├── home_screen.dart        # Search and weather display
│   ├── favorites_screen.dart   # Favorites list
│   ├── settings_screen.dart    # App settings
│   └── index.dart              # Barrel file (exports all pages)
├── widgets/                     # Reusable UI components
│   ├── weather_icon_widget.dart   # Weather icon from API
│   ├── weather_details_card.dart  # Weather details display
│   └── index.dart              # Barrel file (exports all widgets)
└── constants/                   # App constants and config
    └── api_config.dart         # API key configuration
```

## Tech Stack

- **Framework**: Flutter 3.38.3
- **Language**: Dart 3.10.1
- **State Management**: Provider 6.0.0
- **HTTP Client**: http 1.1.0
- **Local Storage**: shared_preferences 2.2.0
- **Date/Time**: intl 0.19.0
- **UI**: Material Design 3

## Installation & Setup

### Prerequisites

- Flutter SDK 3.10.1 or higher
- Dart SDK 3.10.1 or higher
- Android Studio or VS Code with Flutter extension
- An OpenWeatherMap API key (free tier available)

### Step 1: Get Your API Key

1. Visit [OpenWeatherMap](https://openweathermap.org/api)
2. Sign up for a free account
3. Navigate to your API keys section
4. Copy your API key

### Step 2: Configure API Key (Secure Method)

**Use environment variables to keep your API key secure:**

#### Windows PowerShell:
```powershell
# Set environment variable
$env:OPENWEATHERMAP_API_KEY = 'your_actual_api_key_here'
```

#### macOS/Linux:
```bash
# Set environment variable
export OPENWEATHERMAP_API_KEY='your_actual_api_key_here'
```

#### Or use command line flag:
```bash
flutter run --dart-define=OPENWEATHERMAP_API_KEY=your_actual_api_key_here
```

**For detailed security options, see [API_KEY_SECURITY.md](API_KEY_SECURITY.md)**

### Step 3: Install Dependencies

```bash
# From the project root directory
flutter pub get
```

### Step 4: Run the App

```bash
# On Android/iOS emulator or connected device
flutter run

# Or specify the device
flutter run -d <device_id>
```

### Step 5: Build APK (Optional)

```bash
# Build Android APK (with API key from environment)
flutter build apk --release

# Or explicitly pass API key
flutter build apk --release --dart-define=OPENWEATHERMAP_API_KEY=your_key_here
flutter build apk --target-platform=android-arm,android-arm64,android-x86_64
```

## Usage Guide

### Home/Search Screen
1. Enter a city name in the search field
2. Press "Search" or hit Enter
3. View the weather details for the selected city
4. Click "Add to Favorites" to save the city
5. Previous searches appear as chips for quick re-searching

### Favorites Screen
1. View all your saved favorite cities
2. Tap a city to fetch its weather (returns to home screen)
3. Swipe or tap the delete icon to remove from favorites

### Settings Screen
1. Toggle between Celsius and Fahrenheit
2. View app version and information
3. See API key setup instructions

## API Integration

### OpenWeatherMap Current Weather API

**Base URL**: `https://api.openweathermap.org/data/2.5/weather`

#### Search by City Name
```
GET /data/2.5/weather?q={city}&appid={API_KEY}&units=metric
```

#### Search by Coordinates
```
GET /data/2.5/weather?lat={latitude}&lon={longitude}&appid={API_KEY}&units=metric
```

**Parameters**:
- `units`: `metric` (Celsius) or `imperial` (Fahrenheit)
- `appid`: Your OpenWeatherMap API key

**Response**: Includes temperature, humidity, wind speed, weather description, sunrise/sunset times, and more.

## Features in Detail

### Error Handling

The app handles multiple error scenarios:

- **Network Errors**: "No internet connection. Please check your network connection."
- **Invalid City**: "City not found. Please check the spelling."
- **Invalid API Key**: "Invalid API key. Please check your API key."
- **Timeout**: "Request timeout. Please check your internet connection."
- **General API Errors**: Detailed error messages with HTTP status codes

### Data Persistence

- **Favorites**: Saved locally using SharedPreferences
- **Settings**: User preferences (temperature unit) persisted on device
- **Search History**: Recent searches maintained in memory during session

### Temperature Conversion

- **Metric (°C)**: Direct API values
- **Imperial (°F)**: Automatically converted using formula: (°C × 9/5) + 32

### Wind Speed Conversion

- **Metric (m/s)**: Direct API values
- **Imperial (mph)**: Automatically converted using factor 2.237

## Code Quality

- ✅ Clean, readable code with comments
- ✅ Proper folder structure for scalability
- ✅ Separation of concerns (models, services, UI)
- ✅ Null safety implemented throughout
- ✅ Material Design 3 compliance
- ✅ Responsive design for multiple screen sizes

## Building for Release

### Android APK

```bash
flutter clean
flutter pub get
flutter build apk --release
```

The APK will be located at: `build/app/outputs/apk/release/app-release.apk`

### iOS (if applicable)

```bash
flutter clean
flutter pub get
flutter build ios --release
```

## Troubleshooting

### API Key Issues
- Ensure you've signed up for an OpenWeatherMap account
- Check that the API key is correctly copied without extra spaces
- Verify your account has API access enabled
- Free tier should work immediately after signup

### Build Issues
- Run `flutter clean` followed by `flutter pub get`
- Ensure Flutter SDK is up to date: `flutter upgrade`
- Check that you're running from the project root directory

### Runtime Issues
- Clear app data and reinstall
- Check internet connection
- Verify API key is valid in `lib/constants/api_config.dart`
- Check device logs: `flutter logs`

## API Documentation Reference

- [OpenWeatherMap Current Weather API](https://openweathermap.org/current)
- [Weather Icon Codes](https://openweathermap.org/weather-conditions)
- [API Error Codes](https://openweathermap.org/faq)

## License

This project is for educational purposes.

## Author

Created as a Flutter learning project for Multi-Page Weather Application assignment.

---

**Note**: Never commit your API key to version control. The `api_config.dart` file should be added to `.gitignore` if it contains sensitive information.

