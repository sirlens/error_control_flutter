abstract class AppException implements Exception {
  final String message;
  final String? code;
  final ErrorSeverity severity;

  AppException({
    required this.message,
    this.code,
    this.severity = ErrorSeverity.medium,
  });
}

class AuthException extends AppException {
  AuthException({required super.message})
      : super(
          code: 'AUTH_001',
          severity: ErrorSeverity.high,
        );
}

class NetworkException extends AppException {
  NetworkException()
      : super(
          message: 'No internet connection',
          code: 'NET_001',
          severity: ErrorSeverity.high,
        );
}

class ServerException extends AppException {
  ServerException()
      : super(
          message: 'Server error, try again later',
          code: 'SRV_001',
          severity: ErrorSeverity.high,
        );
}

class GenericException extends AppException {
  GenericException({required super.message})
      : super(
          code: 'GEN_001',
          severity: ErrorSeverity.medium,
        );
}

class NavigationException extends AppException {
  NavigationException({required String route})
      : super(
          message: 'Route $route not found',
          code: 'NAV_404',
          severity: ErrorSeverity.high,
        );
}

enum ErrorSeverity { low, medium, high }