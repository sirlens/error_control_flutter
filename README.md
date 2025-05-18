# Error Control Flutter Project

A comprehensive Flutter project demonstrating robust error handling patterns and implementations in Flutter applications.

## Project Overview

This project showcases a complete error handling architecture with features like:

- Centralized error management
- Type-safe error hierarchies
- Custom error displays
- Error severity levels
- Error code tracking
- Authentication error handling

## Technical Stack

- **Flutter Version**: Originally created with 3.24.4, compatible with 3.29.2
- **Flutter Version Manager (FVM)**: Used for version management
- **Dart Version**: 3.3.1
- **State Management**: Provider
- **Dependency Injection**: GetIt

> **Note**: This project uses FVM (Flutter Version Manager) for Flutter SDK management. Make sure you have FVM installed and configured before running the project.

## Key Features

### Error Handling Components

- **Error Types**:
  - Domain Errors (ValidationError, BusinessRuleError)
  - Data Errors (NetworkError, ServerError)
  - UI Errors (WidgetError, NavigationError)
  - Authentication Errors

- **Core Components**:
  - [`ErrorHandler`](lib/core/error_handling/error_handler.dart) - Central error handling implementation
  - [`ErrorDisplay`](lib/core/widgets/error_display.dart) - Error display widget
  - [`ErrorListener`](lib/core/widgets/error_listener.dart) - Error state listener
  - [`AppErrorHandler`](lib/core/error_handling/app_error_handler.dart) - Application-wide error handling

### Authentication Features

- Login/Register functionality with error handling
- Form validation
- Network error simulation
- Server error simulation

## Project Structure

```
lib/
├── core/
│   ├── di/
│   ├── error_handling/
│   ├── exceptions/
│   ├── providers/
│   ├── routing/
│   ├── services/
│   └── widgets/
└── features/
    ├── auth/
    └── dashboard/
```

## Installing FVM (Flutter Version Manager)

1. Install FVM using dart pub:
   ```bash
   dart pub global activate fvm
   ```

2. Add FVM to your PATH:
   - **Windows**: Add `%LOCALAPPDATA%\Pub\Cache\bin` to your PATH
   - **MacOS/Linux**: Add `$HOME/.pub-cache/bin` to your PATH

3. Verify installation:
   ```bash
   fvm --version
   ```

4. Install Flutter SDK with FVM:
   ```bash
   fvm install 3.29.2
   ```

## Getting Started

1. Ensure you have Flutter installed (FVM recommended)
2. If using FVM, run:
   ```bash
   fvm use 3.29.2
   ```
3. Clone the repository
4. Install dependencies:
   ```bash
   fvm flutter pub get
   ```
5. Run the application:
   ```bash
   fvm flutter run
   ```

## Testing Error Handling

The project includes simulated error scenarios:
- Network errors (80% probability)
- Server errors (70% probability)
- Authentication errors
- Navigation errors

## Contributing

Feel free to contribute to this project by submitting issues or pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.