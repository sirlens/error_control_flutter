import 'package:flutter/material.dart';
import '../error_handling/error_handler_interface.dart';
import '../exceptions/app_exceptions.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final IErrorHandler _errorHandler;
  final AuthService _authService;
  bool isLoading = false;
  bool isAuthenticated = false;

  AuthProvider(this._errorHandler, this._authService);

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final success = await _authService.login(email, password);
      isAuthenticated = success;
      return success;
    } on AppException catch (e) {
      _errorHandler.handleError(e);
      return false;
    } catch (e) {
      _errorHandler.handleError(
        GenericException(message: e.toString()),
      );
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
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
    } on AppException catch (e) {
      _errorHandler.handleError(e);
      return false;

    }
    catch (e) {
      isLoading = false;
      _errorHandler.handleError(
        GenericException(message: e.toString()),
      );
      return false;
    }
  }

  void logout() {
    isAuthenticated = false;
    notifyListeners();
  }
}
