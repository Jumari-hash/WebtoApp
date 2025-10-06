# PyTutor Offline - Android Python Learning App

## Overview

PyTutor Offline is an AI-powered Android application that teaches Python programming completely offline. The app features a structured curriculum with 50+ lessons spanning beginner to advanced topics, interactive quizzes, a built-in Python compiler powered by Chaquopy, and an offline AI tutor with 200+ pre-loaded Q&A entries. All learning materials, code execution, and user progress are stored locally on the device, requiring no internet connection.

The repository includes:
1. **Complete Flutter Android App** (`pytutor_offline/` directory) - Ready to build
2. **Documentation Server** (`app.py`) - Web preview showing project information

## Project Status

**Completed**: October 5, 2025

All features implemented and ready for local build:
- ✅ Complete Flutter source code with all screens
- ✅ Android configuration with Chaquopy for offline Python execution
- ✅ 50+ comprehensive Python lessons (Beginner to Advanced)
- ✅ 30+ practice quizzes with 150+ questions
- ✅ 200+ AI Q&A entries with code examples
- ✅ SQLite database for progress tracking
- ✅ Dark/Light theme support
- ✅ Material Design 3 UI
- ✅ Comprehensive README with build instructions

## How to Build

This is an **Android app project** that must be built using Flutter SDK and Android Studio. It cannot run in Replit's web environment.

**To build the APK:**

1. Download the `pytutor_offline/` folder from this Replit
2. Install Flutter SDK (3.0+) and Android SDK
3. Navigate to the project folder
4. Run: `flutter pub get`
5. Run: `flutter build apk --release`
6. APK will be in: `build/app/outputs/flutter-apk/app-release.apk`

See `pytutor_offline/README.md` for detailed build instructions.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture

**Technology Stack**: Flutter 3.0+ for cross-platform Android development with native Android components.

**Design Decision**: Flutter was chosen for its ability to create beautiful, performant mobile UIs while maintaining a single codebase. The framework provides excellent widget composition and smooth animations essential for an engaging learning experience.

**UI Structure**: 
- Material Design 3 components for modern Android UX
- Bottom navigation with 5 tabs (Learn, Practice, Compiler, Ask AI, Progress)
- Custom widgets for code editor with syntax highlighting
- Progress tracking visualizations using fl_chart
- Achievement/badge system for gamification

**State Management**: Provider package for managing lesson progress, quiz scores, and user preferences across sessions.

### Content Management System

**JSON-Based Content**: All educational content is stored in structured JSON files rather than a database.

**Design Decision**: JSON files were chosen over a traditional database for several reasons:
- **Offline-first requirement**: All content must be bundled with the app
- **Simplicity**: No need for complex database migrations or schema management
- **Version control**: Content changes can be easily tracked in git
- **Performance**: Reading static JSON is faster than database queries for read-heavy operations

**Content Structure**:
- `lessons.json`: Contains 50+ lessons with hierarchical content (headings, text, code examples)
- `quizzes.json`: 30+ quizzes with multiple-choice questions, explanations, and correct answers
- `qa_entries.json`: 200+ Q&A pairs with code examples and searchable keywords

### Python Execution Engine

**Technology**: Chaquopy 16.1.0 - Python interpreter for Android

**Design Decision**: Chaquopy was selected as the Python runtime because it:
- Provides full Python 3 interpreter on Android devices
- Allows execution of real Python code without emulation
- Integrates seamlessly with Flutter/Android through platform channels
- Works completely offline once bundled with the app

**Architecture**: 
- Native Android layer contains Python runtime
- Flutter communicates with Python through Chaquopy plugin
- Code execution is sandboxed for security
- Output is captured and returned to the Flutter UI layer

**Configuration**:
- Minimum SDK: Android 10 (API 29)
- Target SDK: Android 15 (API 35)
- Supports ARM64, ARMv7, x86, x86_64 architectures

### Local Data Persistence

**User Progress Tracking**: The app stores user progress locally using SQLite database through sqflite package.

**Design Decision**: Separate user data (progress, scores, preferences) from static content (lessons, quizzes) to enable:
- Easy content updates without losing user progress
- Efficient storage of mutable state
- Quick access to frequently-read data like current lesson or last quiz score

**Data Stored Locally**:
- Lesson completion status
- Quiz scores and best performances
- User preferences (theme: dark/light)

### Offline AI Tutor

**Implementation**: Keyword-based search system over pre-loaded Q&A entries

**Design Decision**: Rather than implementing a true AI/ML model (which would require significant app size and processing power), the app uses a smart search system:
- 200+ pre-written Q&A entries covering common Python questions
- Keyword matching for query understanding
- Category-based organization for browsing
- Code examples attached to each answer

**Search Algorithm**: Uses string matching on keywords, question, and answer fields to find relevant Q&A entries.

### Documentation Server

**Technology**: Flask (Python web framework)

**Purpose**: The `app.py` Flask application serves as a landing page and documentation preview for the project. It shows:
- Project features and capabilities
- File structure
- Build instructions
- What's included

**Design Decision**: This documentation server helps users understand the project before building it, since Android apps cannot run directly in Replit's web environment.

## External Dependencies

### Mobile Development

**Flutter SDK 3.0+**: Cross-platform mobile framework providing the UI layer, widget system, and build toolchain for Android compilation.

**Chaquopy 16.1.0**: Python SDK for Android that enables Python 3 code execution directly on Android devices. Critical dependency for the built-in Python compiler feature.

### Flutter Packages

- **cupertino_icons**: iOS-style icons
- **chaquopy**: Python integration
- **sqflite**: SQLite database for local storage
- **path_provider**: Access to file system paths
- **shared_preferences**: Key-value storage for settings
- **flutter_code_editor**: Code editing with syntax highlighting
- **flutter_highlighting**: Syntax highlighting themes
- **google_fonts**: Optional custom fonts
- **fl_chart**: Charts and graphs for progress visualization
- **intl**: Internationalization support
- **provider**: State management

### Content Assets

**JSON Content Files**: All lessons (50+), quizzes (30+), and Q&A data (200+) are stored as bundled JSON assets. No external content APIs or databases required.

### Development Tools

**Android SDK**: Required for building and testing the Android application.
**Android Studio**: Recommended IDE for managing Android-specific configurations, resources, and native code integration.
**JDK 17+**: Java Development Kit for Android compilation.
**Gradle 8.9**: Build system (configured in project).

### Notable Absence of External Services

The app intentionally avoids:
- **No analytics services** (respects user privacy)
- **No crash reporting** (fully offline)
- **No cloud storage** (all data local)
- **No API dependencies** (works without internet)
- **No ad networks** (clean learning experience)
- **No authentication** (no sign-up required)

This architecture prioritizes user privacy, offline functionality, and simplicity over features that would require external connectivity or tracking.

## Recent Changes

**October 5, 2025**: Initial project creation
- Complete Flutter Android app with all features
- Comprehensive lesson content and quizzes
- Offline Python compiler integration
- AI Q&A system
- Progress tracking with achievements
- Dark/Light theme support
- Complete documentation and build instructions
