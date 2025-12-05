# API Key Security Guide

## ⚠️ Important: Protecting Your API Key

Your API key is **sensitive information**. This guide shows you how to keep it secure when pushing to GitHub.

---

## 🔒 Security Setup (Choose One Method)

### Method 1: Using Command Line (Simplest)

Run the app with your API key passed as an argument:

```bash
# For Android/iOS/Web
flutter run --dart-define=OPENWEATHERMAP_API_KEY=your_actual_key_here

# Or build APK
flutter build apk --release --dart-define=OPENWEATHERMAP_API_KEY=your_actual_key_here
```

**Advantages:**
- ✅ No files to manage
- ✅ Key never stored locally
- ✅ Perfect for CI/CD

**Disadvantages:**
- ❌ Key visible in terminal history
- ❌ Need to remember to add flag every time

---

### Method 2: Local Environment Variable (Recommended for Development)

#### Windows PowerShell:
```powershell
# Set environment variable (session only)
$env:OPENWEATHERMAP_API_KEY = 'your_actual_key_here'

# Or permanently (requires admin, careful!)
[Environment]::SetEnvironmentVariable(
  'OPENWEATHERMAP_API_KEY',
  'your_actual_key_here',
  'User'
)

# Then run normally
flutter run
```

#### macOS/Linux:
```bash
# Add to ~/.bashrc or ~/.zshrc
export OPENWEATHERMAP_API_KEY='your_actual_key_here'

# Then reload
source ~/.bashrc  # or source ~/.zshrc

# Then run normally
flutter run
```

**Advantages:**
- ✅ Set once, use everywhere
- ✅ Not visible in git history
- ✅ Clean command line

**Disadvantages:**
- ❌ Different setup per OS
- ❌ Need to set up on each machine

---

### Method 3: VS Code Launch Configuration (Recommended)

Create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=OPENWEATHERMAP_API_KEY=your_actual_key_here"
      ]
    }
  ]
}
```

**Advantages:**
- ✅ One-time setup
- ✅ Auto-used by VS Code
- ✅ .vscode often in .gitignore

**Disadvantages:**
- ⚠️ File shouldn't be committed (add to .gitignore)

---

### Method 4: Flutter .env File (Most Developer Friendly)

#### Step 1: Add flutter_dotenv to pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_dotenv: ^5.1.0
  # ... other dependencies
```

#### Step 2: Create .env file (add to .gitignore!)

```
OPENWEATHERMAP_API_KEY=your_actual_key_here
```

Add `.env` to `.gitignore` (already done):
```
.env
.env.local
.env.*.local
```

#### Step 3: Create .env.example for reference

```
# Copy this to .env and add your actual API key
OPENWEATHERMAP_API_KEY=your_actual_key_here
```

#### Step 4: Update lib/main.dart

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();  // Load .env file
  runApp(const MyApp());
}
```

#### Step 5: Update lib/constants/api_config.dart

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String openWeatherMapApiKey = String.fromEnvironment(
  'OPENWEATHERMAP_API_KEY',
  defaultValue: 'YOUR_API_KEY_HERE',
);

// Or read from .env file:
// String get openWeatherMapApiKey => dotenv.env['OPENWEATHERMAP_API_KEY'] ?? 'YOUR_API_KEY_HERE';
```

**Advantages:**
- ✅ Most developer-friendly
- ✅ Works with existing CI/CD
- ✅ Easy team collaboration
- ✅ Can have multiple .env files per environment

**Disadvantages:**
- ❌ Requires additional dependency
- ❌ Must remember to create .env

---

## 🔐 Production Deployment

### For CI/CD (GitHub Actions, GitLab CI, etc.)

```yaml
# GitHub Actions Example (.github/workflows/deploy.yml)
name: Build and Deploy

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
      
      - name: Build APK
        run: |
          flutter pub get
          flutter build apk --release \
            --dart-define=OPENWEATHERMAP_API_KEY=${{ secrets.OPENWEATHERMAP_API_KEY }}
      
      - name: Upload APK
        uses: actions/upload-artifact@v2
        with:
          name: app-release.apk
          path: build/app/outputs/apk/release/app-release.apk
```

### For App Stores

Store API key in:
- **Google Play:** Use Google Play Console secure settings
- **App Store:** Use Apple environment variables
- **Firebase:** Use Firebase Secrets Manager
- **AWS:** Use Secrets Manager or Parameter Store
- **Azure:** Use Key Vault

---

## ✅ Security Checklist

Before pushing to GitHub:

- [ ] Never commit actual API key to git
- [ ] `.env` file in `.gitignore`
- [ ] `api_config.dart` in `.gitignore`
- [ ] `.vscode/launch.json` in `.gitignore` (optional)
- [ ] `.env.example` committed (shows format only)
- [ ] Use `String.fromEnvironment()` in code
- [ ] Test locally with environment variable set
- [ ] Document setup in README
- [ ] Add teammates to API key distribution
- [ ] Rotate API key if accidentally exposed

---

## 🚀 Quick Setup for This Project

### Fastest Way (Command Line):

```bash
# Simply run with your key
flutter run --dart-define=OPENWEATHERMAP_API_KEY=your_actual_key_here
```

### Best Way (Environment Variable):

#### Windows:
```powershell
$env:OPENWEATHERMAP_API_KEY = 'your_actual_key_here'
flutter run
```

#### Mac/Linux:
```bash
export OPENWEATHERMAP_API_KEY='your_actual_key_here'
flutter run
```

---

## 📝 Updating README.md

Add this section to your README:

```markdown
## 🔒 API Key Setup (Secure Method)

### Using Environment Variable

1. Get your free API key: https://openweathermap.org/api

2. Set environment variable:
   
   **Windows PowerShell:**
   ```powershell
   $env:OPENWEATHERMAP_API_KEY = 'your_key_here'
   ```
   
   **macOS/Linux:**
   ```bash
   export OPENWEATHERMAP_API_KEY='your_key_here'
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Or use command line flag:

```bash
flutter run --dart-define=OPENWEATHERMAP_API_KEY=your_key_here
```
```

---

## 🛡️ What NOT to Do

❌ **DON'T:**
- Hardcode API key in source files
- Commit `.env` files with real keys
- Share API key in pull requests
- Email your API key
- Commit API key to git history
- Use API key in public repositories

✅ **DO:**
- Use environment variables
- Add keys to CI/CD secrets
- Rotate keys if exposed
- Use `.gitignore` properly
- Document setup process
- Review commit history before pushing

---

## 🆘 If You Accidentally Committed Your Key

### Immediate Actions:

1. **Regenerate your API key** at https://openweathermap.org/
2. Remove from git history:
   ```bash
   git filter-branch --force --index-filter \
     'git rm --cached --ignore-unmatch lib/constants/api_config.dart' \
     --prune-empty --tag-name-filter cat -- --all
   
   git push --force --all
   ```
3. Or use `git-filter-repo` (recommended):
   ```bash
   pip install git-filter-repo
   git filter-repo --path lib/constants/api_config.dart --invert-paths
   git push --force --all
   ```

---

## 📚 References

- [Flutter Documentation - dart-define](https://flutter.dev/docs/development/packages-and-plugins/using-packages)
- [OpenWeatherMap API Security](https://openweathermap.org/faq)
- [GitHub: Keep Secrets Secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [GitLab: CI/CD Variables](https://docs.gitlab.com/ee/ci/variables/)
- [12 Factor App](https://12factor.net/config)

---

## ✨ Recommended Setup for This Project

**For Development:** Environment variable (Method 2)
**For CI/CD:** GitHub Secrets (GitHub Actions)
**For Sharing:** Use .env.example file

---

**Your API key is safe! 🔐**

Never commit sensitive information. Always use environment variables or secrets management.
