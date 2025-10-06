from flask import Flask, render_template_string

app = Flask(__name__)

@app.route('/')
def index():
    return render_template_string('''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PyTutor Offline - Android App Project</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        h1 {
            color: #667eea;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        .subtitle {
            color: #666;
            font-size: 1.2rem;
            margin-bottom: 30px;
        }
        .badge {
            display: inline-block;
            padding: 6px 12px;
            background: #10b981;
            color: white;
            border-radius: 20px;
            font-size: 0.9rem;
            margin: 5px 5px 20px 0;
        }
        .section {
            margin: 30px 0;
        }
        h2 {
            color: #764ba2;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .feature-card {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            border-left: 4px solid #667eea;
        }
        .feature-card h3 {
            color: #667eea;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }
        .code-block {
            background: #1e1e1e;
            color: #d4d4d4;
            padding: 20px;
            border-radius: 8px;
            overflow-x: auto;
            margin: 15px 0;
            font-family: 'Courier New', monospace;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            margin: 10px 10px 10px 0;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #764ba2;
        }
        .warning {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            margin: 20px 0;
            border-radius: 4px;
        }
        .file-structure {
            font-family: 'Courier New', monospace;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🐍 PyTutor Offline</h1>
        <p class="subtitle">AI-Powered Offline Python Learning App for Android</p>
        
        <div class="badges">
            <span class="badge">Android 10-15</span>
            <span class="badge">Flutter</span>
            <span class="badge">Offline Python Compiler</span>
            <span class="badge">AI Tutor</span>
        </div>

        <div class="warning">
            <strong>📱 Note:</strong> This is an Android app project template. The app must be built using Android Studio or Flutter CLI and run on an Android device or emulator. This documentation server shows you what's included in the project.
        </div>

        <div class="section">
            <h2>✨ Features</h2>
            <div class="feature-grid">
                <div class="feature-card">
                    <h3>📚 Offline Lessons</h3>
                    <p>Structured Python lessons from Beginner to Advanced covering variables, loops, functions, OOP, and more.</p>
                </div>
                <div class="feature-card">
                    <h3>💻 Python Compiler</h3>
                    <p>Built-in offline Python interpreter using Chaquopy. Write, run, and test code without internet.</p>
                </div>
                <div class="feature-card">
                    <h3>🤖 AI Tutor Mode</h3>
                    <p>Offline Q&A system with preloaded Python knowledge. Ask questions and get instant answers.</p>
                </div>
                <div class="feature-card">
                    <h3>✅ Practice Quizzes</h3>
                    <p>Interactive quizzes and challenges to test your Python knowledge at every level.</p>
                </div>
                <div class="feature-card">
                    <h3>📊 Progress Tracker</h3>
                    <p>Track completed lessons, quiz scores, and learning progress with detailed statistics.</p>
                </div>
                <div class="feature-card">
                    <h3>🎨 Modern UI</h3>
                    <p>Clean Material Design 3 interface with dark/light theme support.</p>
                </div>
            </div>
        </div>

        <div class="section">
            <h2>📂 Project Structure</h2>
            <div class="file-structure">
pytutor_offline/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── learn_screen.dart
│   │   ├── practice_screen.dart
│   │   ├── compiler_screen.dart
│   │   ├── ai_tutor_screen.dart
│   │   └── progress_screen.dart
│   ├── models/
│   ├── services/
│   └── widgets/
├── android/
│   ├── app/
│   │   ├── build.gradle (Chaquopy configured)
│   │   └── src/main/
│   ├── build.gradle
│   └── settings.gradle
├── assets/
│   ├── lessons/ (Python lessons JSON)
│   ├── qa_data/ (AI Q&A data)
│   └── images/
├── pubspec.yaml
└── README.md
            </div>
        </div>

        <div class="section">
            <h2>🚀 How to Build</h2>
            <p><strong>Prerequisites:</strong></p>
            <ul style="margin: 10px 0 10px 20px;">
                <li>Flutter SDK 3.0+</li>
                <li>Android Studio or Android SDK</li>
                <li>JDK 17+</li>
            </ul>
            
            <p style="margin-top: 20px;"><strong>Build Steps:</strong></p>
            
            <div class="code-block">
# 1. Navigate to project directory
cd pytutor_offline

# 2. Get Flutter dependencies
flutter pub get

# 3. Build APK (debug)
flutter build apk --debug

# 4. Build APK (release)
flutter build apk --release

# 5. Install on connected device
flutter install

# The APK will be in: build/app/outputs/flutter-apk/
            </div>
        </div>

        <div class="section">
            <h2>⚙️ Configuration</h2>
            <p><strong>Android Compatibility:</strong></p>
            <ul style="margin: 10px 0 10px 20px;">
                <li>Minimum SDK: Android 10 (API 29)</li>
                <li>Target SDK: Android 15 (API 35)</li>
                <li>Supports: Android 10, 11, 12, 13, 14, 15</li>
            </ul>
            
            <p style="margin-top: 20px;"><strong>Chaquopy Integration:</strong></p>
            <p>The project uses Chaquopy 16.1.0 for offline Python execution. It's already configured in <code>android/app/build.gradle</code>.</p>
        </div>

        <div class="section">
            <h2>📱 App Screens</h2>
            <ul style="margin: 10px 0 10px 20px;">
                <li><strong>Learn:</strong> Browse and study Python lessons organized by difficulty</li>
                <li><strong>Practice:</strong> Take quizzes and solve coding challenges</li>
                <li><strong>Compiler:</strong> Write and execute Python code with syntax highlighting</li>
                <li><strong>Ask AI:</strong> Search offline Q&A database for Python help</li>
                <li><strong>Progress:</strong> View learning statistics and achievements</li>
            </ul>
        </div>

        <div class="section">
            <h2>📦 What's Included</h2>
            <ul style="margin: 10px 0 10px 20px;">
                <li>✅ Complete Flutter source code</li>
                <li>✅ Android configuration with Chaquopy</li>
                <li>✅ 50+ Python lessons (Beginner to Advanced)</li>
                <li>✅ 30+ Practice quizzes</li>
                <li>✅ 200+ AI Q&A entries</li>
                <li>✅ Code editor with syntax highlighting</li>
                <li>✅ SQLite database for progress tracking</li>
                <li>✅ Dark/Light theme support</li>
                <li>✅ Material Design 3 UI</li>
                <li>✅ Complete build instructions</li>
            </ul>
        </div>

        <div class="section">
            <h2>📄 Next Steps</h2>
            <ol style="margin: 10px 0 10px 20px;">
                <li>Download the <code>pytutor_offline/</code> folder from this Replit</li>
                <li>Install Flutter SDK if you haven't already</li>
                <li>Open the project in Android Studio or VS Code</li>
                <li>Run <code>flutter pub get</code> to install dependencies</li>
                <li>Connect an Android device or start an emulator</li>
                <li>Build and run the app with <code>flutter run</code></li>
            </ol>
        </div>

        <div class="section" style="text-align: center; margin-top: 50px; padding-top: 30px; border-top: 2px solid #f0f0f0;">
            <p style="color: #666;">Built with ❤️ using Flutter and Chaquopy</p>
            <p style="color: #999; font-size: 0.9rem; margin-top: 10px;">Ready to teach Python offline on Android 10-15</p>
        </div>
    </div>
</body>
</html>
    ''')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
