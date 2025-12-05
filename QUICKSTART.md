# Quick Reference Guide

## 🚀 30-Second Setup

1. Get API key: https://openweathermap.org/api (free, instant)
2. Edit `lib/constants/api_config.dart`: Add your key
3. Run: `flutter pub get && flutter run`

Done! ✅

---

## 📁 Key Files to Know

| File | Purpose | Edit? |
|------|---------|-------|
| `lib/constants/api_config.dart` | API Key | ✏️ **YES** |
| `lib/services/weather_api_service.dart` | API calls | ❌ No |
| `lib/pages/home_screen.dart` | Search UI | ❌ No |
| `lib/providers/weather_provider.dart` | Weather state | ❌ No |
| `pubspec.yaml` | Dependencies | ❌ No |

---

## 🎯 Three Main Screens

```
┌─────────────────┐
│  Home/Search    │  ← Search cities, view weather
├─────────────────┤
│   Favorites     │  ← View saved cities
├─────────────────┤
│   Settings      │  ← Toggle °C/°F
└─────────────────┘
```

---

## 🔄 App Flow

```
App Start
   ↓
Load Settings & Favorites from Storage
   ↓
Show Home Screen
   ↓
User searches city
   ↓
API call to OpenWeatherMap
   ↓
Display weather
   ↓
User can: Add favorite / Change settings / Search another city
```

---

## 💾 What Gets Saved

```
SharedPreferences Storage:
├── favorites  [List of City objects]
└── settings   [Temperature unit preference]

Persists across:
- App closes
- Phone restart
- Updates
```

---

## 🌡️ Temperature Conversion

```
Display °C → User enters city → API returns Celsius
                                     ↓
                        App shows in Celsius
                                     ↓
User toggles to °F → App converts using: (°C × 9/5) + 32
                                     ↓
All temps now show in Fahrenheit
```

---

## 📱 Common Tasks

### Search a City
1. Type city name
2. Press "Search" button or Enter
3. View weather details
4. Optional: Click "Add to Favorites"

### View Favorites
1. Go to "Favorites" tab
2. See list of saved cities
3. Tap any city to search it again
4. Tap trash icon to delete

### Change Temperature Unit
1. Go to "Settings" tab
2. Toggle between Celsius and Fahrenheit
3. All temperatures update instantly
4. Setting saved automatically

---

## 🔧 Building for Different Platforms

```bash
# Run on emulator/device
flutter run

# Build Android APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Build Web
flutter build web
```

---

## ⚠️ Common Issues & Fixes

| Issue | Fix |
|-------|-----|
| "City not found" | Check spelling, try without country |
| "Invalid API key" | Regenerate at openweathermap.org |
| "No internet" | Check WiFi/mobile connection |
| App won't start | Run `flutter clean && flutter pub get` |
| Favorites lost | Check device storage permission |

---

## 📊 API Response Data

```dart
Weather object contains:
- cityName: "London"
- country: "GB"
- temperature: 15.5
- feelsLike: 14.2
- description: "Partly cloudy"
- humidity: 65
- windSpeed: 3.5
- sunrise: 1701523200 (Unix timestamp)
- sunset: 1701556800 (Unix timestamp)
- pressure: 1013
- visibility: 10000
```

---

## 🛡️ Error Messages (User-Friendly)

```
Scenario                    → Message
────────────────────────────────────────────────────────
No WiFi/mobile             → "No internet connection..."
Typo in city name          → "City not found..."
API key missing            → "Invalid API key..."
Takes too long             → "Request timeout..."
Rate limit (rare)          → "Too many requests..."
```

---

## 📚 Documentation Map

- **README.md** → Start here!
- **SETUP_GUIDE.md** → Detailed setup & troubleshooting
- **FEATURES.md** → Complete feature documentation
- **IMPLEMENTATION.md** → Technical deep dive
- **This file** → Quick reference

---

## 🎨 UI Components

```
Home Screen:
  ├── AppBar (title)
  ├── Search TextField
  ├── Search Button
  ├── Recent Searches (chips)
  └── Weather Display
      ├── Weather Icon
      ├── Temperature
      ├── Description
      └── Metrics Grid (8 items)

Favorites Screen:
  ├── AppBar (title)
  └── City List
      ├── City Name
      ├── Country
      └── Delete Button

Settings Screen:
  ├── AppBar (title)
  ├── Temperature Unit Toggle
  ├── About Info
  └── Setup Instructions
```

---

## 🔐 API Key Management

```
✅ DO:
- Store in api_config.dart
- Keep in .gitignore
- Regenerate if compromised

❌ DON'T:
- Hardcode in multiple places
- Commit to GitHub
- Share with others
- Use in production without rate limiting
```

---

## 📈 Performance Tips

1. **Use Favorites** - Reduce repeated searches
2. **Real Device** - Emulator can be slow
3. **Good WiFi** - Faster responses
4. **Clear Cache** - If app feels slow

---

## 🚀 Next Steps

1. ✅ Add API key → `lib/constants/api_config.dart`
2. ✅ Run app → `flutter run`
3. ✅ Search a city → Try "London"
4. ✅ Add favorite → Save for later
5. ✅ Toggle units → Test conversion
6. ✅ Close app → Reopen (favorites persist)

Done! You now have a working weather app! 🎉

---

## 📞 Need Help?

1. Check **SETUP_GUIDE.md** for detailed help
2. Read **FEATURES.md** for what's possible
3. See **IMPLEMENTATION.md** for technical details
4. Visit [OpenWeatherMap FAQ](https://openweathermap.org/faq)

---

## 🎓 Learning Resources

- [Flutter Widgets](https://flutter.dev/docs/development/ui/widgets)
- [Provider Package](https://pub.dev/packages/provider)
- [Dart Language](https://dart.dev/guides)
- [HTTP Requests](https://pub.dev/packages/http)
- [SharedPreferences](https://pub.dev/packages/shared_preferences)

---

**Happy coding! 🌤️**
