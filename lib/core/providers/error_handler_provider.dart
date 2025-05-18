import 'package:flutter/material.dart';
import '../exceptions/auth_exceptions.dart';

class ErrorHandlerProvider extends ChangeNotifier {
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void handleError(dynamic error) {
    if (error is AuthException) {
      _errorMessage = error.message;
    } else if (error is NetworkException) {
      _errorMessage = error.message;
    } else if (error is ServerException) {
      _errorMessage = error.message;
    } else {
      _errorMessage = 'An unexpected error occurred';
    }
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
