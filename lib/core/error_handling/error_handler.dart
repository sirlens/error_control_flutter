import 'error_handler_interface.dart';
import '../exceptions/app_exceptions.dart';

class ErrorHandler extends IErrorHandler {
  AppException? _currentError;

  @override
  AppException? get currentError => _currentError;

  @override
  void handleError(dynamic error) {
    if (error is AppException) {
      _currentError = error;
    } else {
      _currentError = GenericError(
        message: error.toString(),
      );
    }
    notifyListeners();
  }

  @override
  void clearError() {
    _currentError = null;
    notifyListeners();
  }

  @override
  String getErrorMessage() {
    return _currentError?.message ?? 'Unknown error occurred';
  }

  @override
  String? getErrorCode() {
    return _currentError?.code;
  }
}
