# ✅ Flutter To-Do App with SQLite  

A simple and efficient **To-Do List app** built with **Flutter** and **SQLite** for local data storage. This app allows users to **add, update, delete, and mark tasks as completed**, ensuring tasks are persistently stored even after restarting the app.  

#### Features  
-  **Add, edit, and delete tasks**  
-  **Mark tasks as completed or pending**  
-  **Persistent storage with SQLite**  
-  **Search & filter tasks**  
-  **Minimal and responsive UI**  

#### Technologies Used  
- **Flutter** (Dart)  
- **SQLite** (`sqflite` package)

#### Software requirements
# Ensure you have the following installed on your machine
- Flutter: Install the Flutter SDK and add it to environment variable (Windows) or your shell (macOS).
- Dart.
- Git.
- Android Studio: Install Android SDK, Android SDK Command-line Tools, Android Virtual Device (AVD) in Android Studio.
  Set up the ANDROID_HOME environment variable:
  Windows: Add C:\Users\YourName\AppData\Local\Android\Sdk to Path.
  macOS/Linux: Add this to your .bashrc or .zshrc:
  *export ANDROID_HOME=$HOME/Android/Sdk
  *export PATH=$PATH:$ANDROID_HOME/emulator
  *export PATH=$PATH:$ANDROID_HOME/platform-tools
  Select an download a device under the Android Virtual Device (AVD) and use it to run the app.
- XCODE (For macOS users): Follow same steps under Android studio, but use XCODE simulator which comes along with the download of XCODE instead of an Android Virtual Device (AVD) to run the app.

#### How to Run  
# Clone the Repository
Open a terminal and run:  
- git clone https://github.com/your-username/flutter-todo-app.git

# Open the file in Android Studio and open the repository contents.

- Inside the lib/ folder, create the following directories and files:
lib/
│── database/   # Handles SQLite database operations
│── models/     # Contains data models
│── screens/    # UI screens of the app
│── main.dart   # Entry point of the app

# Ensure proper imports
- In database/database_helper.dart file
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

- In screens/home_screen.dart file
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/task.dart';



