# Run iOS App

A Flutter iOS application that allows users to input and save a Client ID. The app provides a simple, clean interface for managing client identification information.

## Features

- **Client ID Input**: Clean text input field for entering client IDs
- **Persistent Storage**: Uses SharedPreferences to save and retrieve client IDs
- **Modern UI**: Material Design 3 with a beautiful, responsive interface
- **Loading States**: Visual feedback during save operations
- **Error Handling**: Proper error messages and validation

## Screenshots

The app features:
- A prominent input field for Client ID entry
- A save button with loading indicator
- Display of previously saved Client ID
- Clean, modern iOS-style interface

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Xcode (for iOS development)
- iOS Simulator or physical iOS device

### Installation

1. Clone the repository:
```bash
git clone https://github.com/srujan5570/run-ios.git
cd run-ios
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Building for iOS

### Manual Build

To build the app manually:

```bash
flutter build ios --release
```

### Automated Build with GitHub Actions

This repository includes a GitHub Actions workflow that automatically builds and creates IPA files.

#### To trigger the build:

1. Go to the **Actions** tab in the GitHub repository
2. Select **iOS-ipa-build** workflow
3. Click **Run workflow**
4. The workflow will:
   - Set up Flutter environment
   - Install dependencies
   - Build the iOS app
   - Create an IPA file
   - Upload it as a release

## Project Structure

```
run-ios/
├── lib/
│   └── main.dart              # Main application code
├── ios/
│   ├── Runner/
│   │   └── Info.plist         # iOS app configuration
│   └── Runner.xcodeproj/      # Xcode project files
├── .github/
│   └── workflows/
│       └── ios-build.yml      # GitHub Actions workflow
├── pubspec.yaml               # Flutter dependencies
└── README.md                  # This file
```

## Dependencies

- **flutter**: Core Flutter framework
- **cupertino_icons**: iOS-style icons
- **shared_preferences**: Local data persistence

## Development

### Key Components

- **MyApp**: Main app widget with Material Design theme
- **ClientIdScreen**: Main screen with input functionality
- **SharedPreferences**: Used for persistent storage

### State Management

The app uses Flutter's built-in `StatefulWidget` for state management, handling:
- Text input state
- Loading states
- Saved client ID display

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support or questions, please open an issue in the GitHub repository. 