import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../error_handling/error_handler_interface.dart';

class AuthProvider extends ChangeNotifier {
  final IErrorHandler _errorHandler;
  final AuthService _authService;
  bool isLoading = false;
  bool isAuthenticated = false;

  AuthProvider(this._errorHandler, this._authService);

  Future<bool> login(
      BuildContext context, String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final success = await _authService.login(email, password);
      isAuthenticated = success;
      isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      isLoading = false;
      isAuthenticated = false;
      notifyListeners();
      _errorHandler.handleError(e);
      return false;
    }
  }

  Future<bool> register(
      BuildContext context, String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final success = await _authService.register(email, password);
      isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      _errorHandler.handleError(e);
      return false;
    }
  }

  void logout() {
    isAuthenticated = false;
    notifyListeners();
  }
}
