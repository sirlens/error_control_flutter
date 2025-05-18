abstract class AppException implements Exception {
  final String message;
  final String code;

  const AppException({
    required this.message,
    required this.code,
  });
}

class GenericError extends AppException {
  GenericError({
    required String message,
    String code = 'GEN_001',
  }) : super(message: message, code: code);
}

class AuthException extends AppException {
  AuthException({
    required String message,
    String code = 'AUTH_001',
  }) : super(message: message, code: code);
}

class NetworkException extends AppException {
  NetworkException({String code = 'NET_001'})
      : super(
          message: 'Network connection error',
          code: code,
        );
}

class ServerException extends AppException {
  ServerException({String code = 'SRV_001'})
      : super(
          message: 'Server error',
          code: code,
        );
}
