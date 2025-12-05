# Weather App - Setup Guide

## Quick Start

### 1. Get OpenWeatherMap API Key

1. Visit [OpenWeatherMap](https://openweathermap.org/api)
2. Click "Sign Up" and create a free account
3. Once logged in, go to your **API keys** page
4. Copy your **Default API Key** (this is free and ready to use immediately)

**Free Tier Benefits:**
- 60 API calls/minute
- 1,000,000 API calls/month
- All current weather data included
- Perfect for development and learning

### 2. Configure the App

#### Option A: Quick Setup (Recommended)

1. Open `lib/constants/api_config.dart`
2. Replace `'YOUR_API_KEY_HERE'` with your actual API key:
   ```dart
   const String openWeatherMapApiKey = 'your_actual_key_here';
   ```
3. Save the file

#### Option B: Using Environment Variables (Advanced)

You can set up environment variables instead of hardcoding:

```bash
# On Windows PowerShell
$env:OPENWEATHERMAP_API_KEY = 'your_api_key_here'

# Then in your code
const String openWeatherMapApiKey = String.fromEnvironment('OPENWEATHERMAP_API_KEY', defaultValue: 'YOUR_API_KEY_HERE');
```

### 3. Install Flutter (If Not Already Done)

```bash
# Check if Flutter is installed
flutter --version

# If not installed, download from https://flutter.dev/docs/get-started/install
```

### 4. Clone or Download the Project

```bash
# Navigate to the project directory
cd Weather_app

# Get dependencies
flutter pub get
```

### 5. Run the App

#### On Android Emulator
```bash
# Start Android emulator first, then:
flutter run

# Or specify device
flutter run -d emulator-5554
```

#### On iOS Simulator (macOS only)
```bash
open -a Simulator
flutter run
```

#### On Physical Device
```bash
# Enable Developer Mode and USB Debugging on your device
flutter devices          # List connected devices
flutter run -d <device_id>
```

#### On Web
```bash
flutter run -d web
flutter run -d chrome
```

---

## Project Structure Explanation

### Directory Breakdown

```
lib/
├── main.dart                          # App entry point
│
├── models/                            # Data models
│   ├── weather.dart                   # Weather data from API
│   ├── city.dart                      # City/Favorite model
│   ├── app_settings.dart              # User preferences
│   └── index.dart                     # Exports
│
├── services/                          # Business logic
│   ├── weather_api_service.dart       # ← Uses your API key here
│   ├── storage_service.dart           # Local data storage
│   └── index.dart                     # Exports
│
├── providers/                         # State management (Provider)
│   ├── weather_provider.dart          # Weather state
│   ├── app_data_provider.dart         # Favorites & settings state
│
├── pages/                             # UI Screens
│   ├── home_screen.dart               # Search & display weather
│   ├── favorites_screen.dart          # Saved cities
│   ├── settings_screen.dart           # App settings
│   └── index.dart                     # Exports
│
├── widgets/                           # Reusable UI components
│   ├── weather_icon_widget.dart       # Weather icon display
│   ├── weather_details_card.dart      # Weather info card
│   └── index.dart                     # Exports
│
└── constants/
    ├── api_config.dart                # ← ADD YOUR API KEY HERE
    └── api_config.example.dart        # Example template
```

---

## Key Files to Edit

### 1. API Configuration (REQUIRED)

**File:** `lib/constants/api_config.dart`

```dart
// Before:
const String openWeatherMapApiKey = 'YOUR_API_KEY_HERE';

// After (Example):
const String openWeatherMapApiKey = 'abc123def456ghi789jkl012mno345pqr';
```

**Important:** 
- Never commit this file with your actual API key
- It's already in `.gitignore` to prevent accidental upload
- If you accidentally commit it, regenerate your API key immediately

### 2. Testing the API Key

To verify your API key works:

```bash
# Open any Dart file and run this quick test
flutter run

# Search for any city in the app
# If weather appears, your API key is working!
```

---

## Troubleshooting

### "City not found" Error
- Check spelling of city name
- Try with just the main city name (e.g., "London" not "London, UK")
- Ensure internet connection is active

### "Invalid API key" Error
- Go back to https://openweathermap.org
- Copy your API key again (make sure no extra spaces)
- Paste into `api_config.dart`
- Try restarting the app

### "No internet connection" Error
- Check your device/emulator has internet
- Restart the emulator with `flutter clean`
- Check firewall isn't blocking the app

### App Won't Start
```bash
# Clean build
flutter clean
flutter pub get
flutter run

# Or rebuild with verbose output
flutter run -v
```

### API Rate Limit Exceeded (429 error)
- You've made too many requests
- Free tier: 1,000,000 calls/month
- Wait a few minutes and try again
- Or upgrade your account on openweathermap.org

---

## Features Walkthrough

### 1. Home/Search Screen
- **What:** Search for weather by city name
- **How to:** Type city name and press Search
- **Result:** Display weather for that city
- **Bonus:** Recent searches appear as chips for quick access

### 2. Weather Details
Shows comprehensive information:
- Current temperature
- "Feels like" temperature
- Weather description (Sunny, Rainy, etc.)
- Humidity percentage
- Wind speed
- Atmospheric pressure
- Visibility
- Sunrise and Sunset times
- Timezone information

### 3. Favorites
- **Save:** Click "Add to Favorites" button after searching
- **View:** Go to Favorites tab to see saved cities
- **Quick Search:** Tap a favorite city to instantly view its weather
- **Remove:** Delete icon next to each city to remove from favorites

### 4. Settings
- **Temperature Unit:** Toggle between Celsius and Fahrenheit
- **Unit Conversion:** All temperatures and wind speeds auto-convert
- **Persistent:** Your preference is saved and remembered

---

## Building for Release

### Android APK

```bash
# Generate release APK
flutter build apk --release

# Location: build/app/outputs/apk/release/app-release.apk
# Size: ~30-50 MB

# Install on device
flutter install --release
```

### iOS Build

```bash
# Generate iOS build
flutter build ios --release

# Open in Xcode for further configuration
open ios/Runner.xcworkspace
```

### Web Build

```bash
flutter build web --release

# Deploy the `build/web` directory to your hosting
```

---

## API Limits and Best Practices

### Free Tier Limits
- **Calls per minute:** 60
- **Calls per month:** 1,000,000
- **History:** Last 3 hours of weather
- **Update frequency:** Real-time (10-15 second delay)

### Best Practices
1. **Cache Results:** Don't request same city multiple times
2. **Use Favorites:** Reduce API calls by saving frequently-used cities
3. **Batch Requests:** Update multiple cities efficiently
4. **Handle Offline:** App gracefully handles no internet

### Monitoring API Usage
Visit https://openweathermap.org/my/statistics to see:
- API calls made today
- Total API calls this month
- API request history

---

## Environment Variables (Advanced)

### Setting API Key via Environment
Instead of editing `api_config.dart`, use environment variables:

```bash
# Windows PowerShell
$env:OPENWEATHERMAP_API_KEY = 'your_key_here'
flutter run

# macOS/Linux
export OPENWEATHERMAP_API_KEY='your_key_here'
flutter run

# Or in Visual Studio Code launch.json
{
  "configurations": [
    {
      "name": "Flutter",
      "request": "launch",
      "type": "dart",
      "env": {
        "OPENWEATHERMAP_API_KEY": "your_key_here"
      }
    }
  ]
}
```

---

## Performance Tips

1. **Use Real Device:** Emulator can be slow, use a real phone for better experience
2. **Minimize Requests:** Use favorites to avoid repeated searches
3. **Network Settings:** Ensure good WiFi/mobile connection
4. **Storage:** App uses ~50 MB disk space

---

## Support & Resources

### Official Documentation
- [OpenWeatherMap API Docs](https://openweathermap.org/api)
- [OpenWeatherMap FAQ](https://openweathermap.org/faq)
- [Weather Condition Codes](https://openweathermap.org/weather-conditions)

### Flutter Resources
- [Flutter Docs](https://flutter.dev/docs)
- [Dart Language](https://dart.dev/guides)
- [Provider Package](https://pub.dev/packages/provider)

### Community Help
- [Stack Overflow - Flutter](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter Community Discord](https://discord.gg/N7Yshp7)
- [Reddit: r/FlutterDev](https://reddit.com/r/FlutterDev/)

---

## FAQ

**Q: Can I use this app without an API key?**
A: No, the app requires an OpenWeatherMap API key to fetch weather data. The free tier is perfect for development.

**Q: How long does the API key take to activate?**
A: Usually immediately after signup, but can take up to 10 minutes.

**Q: Can I share my API key?**
A: No, never share your API key. If compromised, regenerate it on openweathermap.org.

**Q: What happens if I exceed the free tier limit?**
A: API calls will be blocked. You can then upgrade to a paid plan or wait for the next month.

**Q: Can I use the app offline?**
A: No, but previously searched weather data is cached locally for a limited time.

**Q: How often is weather data updated?**
A: The API provides real-time data with a typical delay of 10-15 seconds.

---

## Getting Help

If you encounter issues:

1. **Check the logs:** `flutter logs`
2. **Run with verbose:** `flutter run -v`
3. **Clean and rebuild:** `flutter clean && flutter pub get`
4. **Check internet:** Verify device/emulator has internet access
5. **Verify API key:** Double-check key in `api_config.dart`

---

**Happy weather checking! 🌤️**
