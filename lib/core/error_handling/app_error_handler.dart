import 'package:flutter/material.dart';

enum ErrorSeverity { low, medium, high }

abstract class AppError {
  final String message;
  final ErrorSeverity severity;
  final String? code;

  AppError({
    required this.message,
    this.severity = ErrorSeverity.medium,
    this.code,
  });
}

class NavigationError extends AppError {
  NavigationError({required String route})
      : super(
            message: 'Could not navigate to $route',
            severity: ErrorSeverity.low,
            code: 'NAV_001');
}

class NetworkError extends AppError {
  NetworkError()
      : super(
            message: 'Network connection error',
            severity: ErrorSeverity.high,
            code: 'NET_001');
}

class GenericError extends AppError {
  GenericError({
    required super.message,
    super.severity,
    String? code,
  }) : super(
          code: code ?? 'GEN_001',
        );
}

class UIError extends AppError {
  UIError({required super.message})
      : super(
          severity: ErrorSeverity.medium,
          code: 'UI_001',
        );
}

class AppErrorHandler {
  static void handleError(BuildContext context, dynamic error) {
    AppError appError;

    if (error is AppError) {
      appError = error;
    } else {
      appError = GenericError(
        message: error.toString(),
      );
    }

    _showError(context, appError);
  }

  static void _showError(BuildContext context, AppError error) {
    final theme = Theme.of(context);
    Color backgroundColor;

    switch (error.severity) {
      case ErrorSeverity.low:
        backgroundColor = Colors.orange;
        break;
      case ErrorSeverity.medium:
        backgroundColor = Colors.red;
        break;
      case ErrorSeverity.high:
        backgroundColor = Colors.red[900]!;
        break;
    }

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(error.message),
              if (error.code != null)
                Text(
                  'Code: ${error.code}',
                  style: theme.textTheme.bodySmall,
                ),
            ],
          ),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    } catch (e) {
      // Recursivamente manejamos el error del SnackBar como un nuevo error UI
      if (e is AssertionError &&
          e.message.toString().contains('_scaffolds.isNotEmpty')) {
        handleError(
          context,
          UIError(message: 'Cannot show error message - No Scaffold found'),
        );
      } else {
        handleError(
          context,
          GenericError(message: 'Error showing error message: ${e.toString()}'),
        );
      }
    }
  }
}
