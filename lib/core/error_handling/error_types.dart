// Domain Errors
abstract class DomainError implements Exception {
  final String message;
  DomainError(this.message);
}

class ValidationError extends DomainError {
  ValidationError(super.message);
}

class BusinessRuleError extends DomainError {
  BusinessRuleError(super.message);
}

// Data Errors
abstract class DataError implements Exception {
  final String message;
  final String? code;
  DataError(this.message, {this.code});
}

class NetworkError extends DataError {
  NetworkError() : super('Network connection error', code: 'NET_001');
}

class ServerError extends DataError {
  ServerError() : super('Server error', code: 'SRV_001');
}

// UI Errors
abstract class UIError implements Exception {
  final String message;
  UIError(this.message);
}

class WidgetError extends UIError {
  WidgetError(super.message);
}

class NavigationError extends UIError {
  NavigationError(super.message);
}
