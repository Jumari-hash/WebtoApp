# PyTutor Offline 🐍

An AI-powered offline Python learning app for Android that teaches Python programming from beginner to advanced level, featuring a built-in Python compiler, interactive lessons, quizzes, and an offline AI tutor.

![Android](https://img.shields.io/badge/Android-10%20to%2015-green)
![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue)
![Python](https://img.shields.io/badge/Python-Chaquopy-yellow)

## 📱 Features

### ✅ Complete Offline Experience
- **No internet required** - all lessons, quizzes, and Python execution work offline
- All data stored locally on the device
- No data collection or tracking

### 📚 Structured Learning Path
- **50+ Comprehensive Lessons** organized by difficulty:
  - **Beginner**: Variables, data types, strings, lists, conditionals, loops
  - **Intermediate**: Functions, dictionaries, file handling, OOP basics
  - **Advanced**: Classes, modules, decorators, generators, advanced topics
- Each lesson includes:
  - Clear explanations
  - Code examples with syntax highlighting
  - Practice challenges
  - Progress tracking

### 💻 Built-in Python Compiler
- Write and execute real Python code on your Android device
- Powered by **Chaquopy** - full Python 3 interpreter
- Syntax highlighting in code editor
- Real-time output display
- Error messages with explanations

### 🤖 Offline AI Tutor
- **200+ Pre-loaded Q&A** entries covering common Python questions
- Smart search functionality
- Code examples for each answer
- Organized by category (Data Structures, OOP, Control Flow, etc.)

### ✅ Practice Quizzes
- **30+ Interactive Quizzes** with multiple choice questions
- Instant feedback and explanations
- Score tracking and best score saving
- Covers all difficulty levels

### 📊 Progress Tracking
- Visual progress dashboard with charts
- Lesson completion tracking
- Quiz performance statistics
- Achievement system with unlockable badges

### 🎨 Modern UI/UX
- **Material Design 3** interface
- **Dark & Light theme** support
- Smooth animations and transitions
- Responsive layout for all screen sizes
- Clean, intuitive navigation

## 📋 Requirements

### To Build the App
- **Flutter SDK**: 3.0 or higher
- **Android Studio** or Android SDK
- **Java Development Kit (JDK)**: 17 or higher
- **Gradle**: 8.9 (included)
- **Python 3**: For Chaquopy build process

### Android Compatibility
- **Minimum SDK**: Android 10 (API 29)
- **Target SDK**: Android 15 (API 35)
- **Supported**: Android 10, 11, 12, 13, 14, 15
- **Architecture**: ARM64, ARMv7, x86, x86_64

## 🚀 Build Instructions

### 1. Prerequisites Setup

#### Install Flutter
```bash
# Download Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Verify installation
flutter doctor
```

#### Install Android SDK
Download Android Studio from https://developer.android.com/studio

Or install just the command-line tools:
```bash
# Follow instructions at:
# https://developer.android.com/studio#command-tools
```

### 2. Clone or Download This Project
```bash
# If you have the project as a git repo
git clone <repository-url>
cd pytutor_offline

# Or simply download and extract the project folder
```

### 3. Install Dependencies
```bash
# Get Flutter packages
flutter pub get

# This will download all dependencies including:
# - Chaquopy (Python integration)
# - sqflite (local database)
# - flutter_code_editor (code editing)
# - fl_chart (progress charts)
# - And more...
```

### 4. Build the APK

#### Debug Build (for testing)
```bash
flutter build apk --debug
```

#### Release Build (for distribution)
```bash
flutter build apk --release
```

The APK will be generated in:
```
build/app/outputs/flutter-apk/app-release.apk
```

### 5. Build App Bundle (for Google Play)
```bash
flutter build appbundle --release
```

The AAB will be in:
```
build/app/outputs/bundle/release/app-release.aab
```

## 📱 Installation

### Method 1: Install via USB
```bash
# Connect Android device via USB
# Enable USB debugging on device
flutter install

# Or use adb directly
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Method 2: Manual Installation
1. Copy `app-release.apk` to your Android device
2. Open the APK file on your device
3. Allow installation from unknown sources if prompted
4. Tap "Install"

## 🏗️ Project Structure

```
pytutor_offline/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── screens/                  # All app screens
│   │   ├── home_screen.dart      # Bottom navigation
│   │   ├── learn_screen.dart     # Lessons browser
│   │   ├── practice_screen.dart  # Quizzes list
│   │   ├── compiler_screen.dart  # Python code editor
│   │   ├── ai_tutor_screen.dart  # Q&A search
│   │   ├── progress_screen.dart  # Statistics & achievements
│   │   ├── lesson_detail_screen.dart
│   │   └── quiz_screen.dart
│   ├── models/                   # Data models
│   │   ├── lesson.dart
│   │   ├── quiz.dart
│   │   └── qa_entry.dart
│   ├── services/                 # Business logic
│   │   ├── database_service.dart # SQLite & data loading
│   │   ├── python_service.dart   # Chaquopy integration
│   │   └── theme_service.dart    # Theme management
│   └── widgets/                  # Reusable UI components
├── assets/
│   ├── lessons/
│   │   ├── lessons.json         # 50+ Python lessons
│   │   └── quizzes.json         # 30+ quizzes
│   └── qa_data/
│       └── qa_entries.json      # 200+ Q&A entries
├── android/
│   ├── app/
│   │   ├── build.gradle         # Chaquopy configuration
│   │   └── src/main/
│   │       ├── AndroidManifest.xml
│   │       ├── kotlin/
│   │       └── python/          # Python scripts
│   ├── build.gradle
│   └── settings.gradle
├── pubspec.yaml                 # Flutter dependencies
└── README.md
```

## 🔧 Configuration

### Chaquopy Configuration
The app uses Chaquopy 16.1.0 for Python integration. Configuration is in `android/app/build.gradle`:

```gradle
android {
    defaultConfig {
        minSdk 29
        targetSdk 35
        
        ndk {
            // Architectures to include
            abiFilters "arm64-v8a", "armeabi-v7a", "x86", "x86_64"
        }
        
        python {
            buildPython "/usr/bin/python3"
        }
    }
}
```

### Adding Python Packages
To add Python packages that can be used in the compiler:

```gradle
python {
    pip {
        install "numpy"
        install "pandas"
        install "requests"
    }
}
```

Check available packages at: https://chaquo.com/pypi-13.0/

## 🎯 Usage Guide

### Learn Tab
- Browse lessons organized by difficulty
- Tap any lesson to view content
- Each lesson includes explanations and code examples
- Mark lessons as complete when done

### Practice Tab
- Access quizzes organized by category
- Take quizzes to test your knowledge
- See instant feedback and explanations
- Track your best scores

### Compiler Tab
- Write Python code in the syntax-highlighted editor
- Tap "Run Code" to execute
- View output and error messages
- Save example codes for reference

### Ask AI Tab
- Search for Python-related questions
- Get instant answers from offline database
- View code examples
- Browse by category

### Progress Tab
- View completion statistics
- See quiz performance charts
- Unlock achievements
- Track learning journey

## 📊 Content Breakdown

### Lessons (50+)
- **Beginner (30 lessons)**: Basics, variables, strings, lists, loops, conditionals
- **Intermediate (15 lessons)**: Functions, dictionaries, file I/O, OOP
- **Advanced (10+ lessons)**: Classes, modules, decorators, async

### Quizzes (30+)
- **Beginner (15 quizzes)**: 75+ questions
- **Intermediate (10 quizzes)**: 50+ questions
- **Advanced (5+ quizzes)**: 25+ questions

### AI Q&A Database (200+)
- Data Structures (50 entries)
- Control Flow (30 entries)
- Functions (25 entries)
- OOP (40 entries)
- File Handling (20 entries)
- Error Handling (15 entries)
- Modules & Packages (20 entries)

## 🔒 Privacy & Data

- **100% Offline** - no data sent to servers
- **No tracking** or analytics
- **No permissions** required except storage (for saving progress)
- All data stored locally on device
- No account or sign-up needed

## 🐛 Troubleshooting

### Build Fails
```bash
# Clean build
flutter clean
flutter pub get
flutter build apk --release
```

### Chaquopy Issues
- Ensure Python 3 is installed on build machine
- Check `android/app/build.gradle` for correct configuration
- Verify internet connection during first build (downloads Python)

### APK Size
The APK is large (~50-100MB) due to:
- Python interpreter
- Multiple ABIs
- Lesson/quiz data

To reduce size:
- Build for specific ABI only
- Use app bundle (.aab) for Play Store
- Remove unused ABIs from `build.gradle`

### App Crashes
- Check logcat: `adb logcat`
- Verify Android version (must be 10+)
- Clear app data and reinstall

## 📝 License

This project is licensed under the MIT License - see LICENSE file for details.

## 🤝 Contributing

This is an educational project. Contributions welcome:
- Add more lessons
- Create additional quizzes
- Improve UI/UX
- Fix bugs
- Add features

## 📧 Support

For issues or questions:
1. Check the Troubleshooting section
2. Review existing issues
3. Create a new issue with details

## 🌟 Acknowledgments

- **Flutter** - UI framework
- **Chaquopy** - Python integration for Android
- **Material Design** - UI guidelines
- Python community for inspiration

---

**Built with ❤️ for Python learners everywhere**

*Learn Python anywhere, anytime - no internet required!*
