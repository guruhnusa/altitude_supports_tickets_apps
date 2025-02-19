# Altitude Support Ticket Apps

A Flutter application for managing support tickets with ease and efficiency.

## 🚀 Requirements
- **Flutter Version**: `3.24.4`

## 🛠️ Setup Guide

Follow these steps to set up and run the project:

### 1. Create `.env` File
Add the base URL for your API in a `.env` file at the root of your project.

```env
BASE_URL = "https://your-api-url.com"
```

### 2. Install Dependencies
Run the following command to install all required packages:
```bash
flutter pub get
```

### 3. Generate Assets
Use `fluttergen` to generate asset files automatically:
```bash
fluttergen
```

### 4. Generate Code with Build Runner
Run the build runner in watch mode to generate required files:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

**Made by Nusa**
