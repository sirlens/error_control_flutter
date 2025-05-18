import 'dart:math';
import '../exceptions/app_exceptions.dart';

class AuthService {
  bool _hasNetwork() {
    // Simular error de red (40% de probabilidad)
    return Random().nextDouble() > 0.4;
  }

  bool _isServerAvailable() {
    // Simular error de servidor (30% de probabilidad)
    return Random().nextDouble() > 0.3;
  }

  Future<bool> login(String email, String password) async {
    if (!_hasNetwork()) {
      throw NetworkException();
    }

    if (!_isServerAvailable()) {
      throw ServerException();
    }

    if (email == 'test@test.com' && password == '123456') {
      return true;
    }
    throw AuthException(message: 'Invalid credentials');
  }

  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!_hasNetwork()) {
      throw NetworkException();
    }

    if (!_isServerAvailable()) {
      throw ServerException();
    }

    if (email == 'existing@test.com') {
      throw AuthException(message: 'Email already exists');
    }

    if (email.isNotEmpty && password.length >= 6) {
      return true;
    }
    throw AuthException(message: 'Invalid registration data');
  }
}
