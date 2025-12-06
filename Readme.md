# Weather App — Beautiful Multi-Page Flutter Weather Client

Lightweight, modern Flutter weather app demonstrating a clean architecture, Provider state management, local persistence, and secure API-key handling for OpenWeatherMap.

Key highlights:

- Fast search by city name
- Full weather details (temperature, feels-like, humidity, wind, pressure, visibility, sunrise/sunset, timezone)
- Favorites list with persistence
- Settings (°C / °F) persisted with SharedPreferences
- Secure API key handling (dotenv and compile-time --dart-define supported)

---

**Getting Started**

Prerequisites:

- Flutter SDK (tested with Flutter 3.38.3)
- Android SDK (for Android emulator or device)
- An OpenWeatherMap API key (free tier OK)

Quick setup:

1. Clone the repo:

```powershell
git clone <your-repo-url>
cd Weather_app
```

2. Add your OpenWeatherMap API key (pick one method):

- Recommended (local .env): create a file named `.env` in the project root with:

```text
OPENWEATHERMAP_API_KEY=your_real_api_key_here
```

- Alternative (compile-time): pass the key when running/building:

```powershell
flutter run --dart-define=OPENWEATHERMAP_API_KEY=your_real_api_key_here
flutter build apk --release --dart-define=OPENWEATHERMAP_API_KEY=your_real_api_key_here
```

3. Install dependencies and run:

```powershell
flutter pub get
flutter run
```

If you used `.env`, the app's `main()` loads it automatically (via `flutter_dotenv`). If you used `--dart-define`, the value is available at compile time.

---

**Security & API Key Notes**

- Never commit your real `.env` file. A sample `.env.example` is included to show the format.
- `.gitignore` includes `.env` and common IDE run configuration patterns to prevent leaks.
- If you accidentally commit keys, rotate them immediately and remove from git history (see `API_KEY_SECURITY.md`).

---

**Run on Android Emulator**

Start an emulator via Android Studio AVD Manager, or from the terminal:

```powershell
# list available emulators
emulator -list-avds
# start one (replace with your AVD name)
emulator -avd Pixel_4_API_30
# then run the app
flutter run
```

If you want to target a specific device id:

```powershell
flutter devices
flutter run -d emulator-5554
```

---

**Build Release APK (for submission)**

```powershell
flutter build apk --release --dart-define=OPENWEATHERMAP_API_KEY=your_real_api_key_here
```

Generated APK: `build/app/outputs/flutter-apk/app-release.apk` or in `build/app/outputs/apk/release/`.

---

**Troubleshooting**

- App complains "API key not found":
	- If you used `.env`, ensure `.env` exists and `main.dart` loads it (project already does).
	- If using `--dart-define`, restart the app with the flag — hot-reload won't pick up compile-time values.

- Android NDK/build errors:
	- Delete corrupted NDKs under `%LOCALAPPDATA%\\Android\\Sdk\\ndk` and let Gradle re-download, or set a compatible `ndkVersion` in `android/gradle.properties`.

---

**Project Structure (high level)**

- `lib/` — main Dart sources
	- `models/` — data classes
	- `services/` — API + storage services
	- `providers/` — Provider state management
	- `pages/` — UI screens
	- `widgets/` — reusable UI widgets
	- `constants/api_config.dart` — secure API key integration (checks --dart-define and `.env`)

- `android/` — platform project

---




