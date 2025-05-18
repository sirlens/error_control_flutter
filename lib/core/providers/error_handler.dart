//import 'package:flutter/scheduler.dart';
import '../exceptions/app_exceptions.dart';
import '../error_handling/error_handler_interface.dart';

class ErrorHandler extends IErrorHandler {
  AppException? _lastError;
  final List<AppException> _errorHistory = [];
/*   final List<AppException> _errorQueue = [];
  bool _isProcessingErrors = false; */

  @override
  AppException? get lastError => _lastError;

  @override
  bool get hasError => _lastError != null;

  List<AppException> get errorHistory => List.unmodifiable(_errorHistory);

  @override
  void handleError(AppException error) {
    // Manejo sincrónico del error
    _lastError = error;
    _errorHistory.add(error);
    notifyListeners();
  }

/*   void _processErrorQueue() {
    if (_errorQueue.isEmpty) {
      _isProcessingErrors = false;
      return;
    }

    _isProcessingErrors = true;
    // Procesar el siguiente error inmediatamente
    if (_errorQueue.isNotEmpty) {
      _lastError = _errorQueue.removeAt(0);
      _errorHistory.add(_lastError!);
      notifyListeners();
      // Continuar procesando la cola si hay más errores
      if (_errorQueue.isNotEmpty) {
        Future.microtask(_processErrorQueue);
      } else {
        _isProcessingErrors = false;
      }
    }
  } */

  @override
  void clearError() {
    if (_lastError != null) {
      _lastError = null;
      notifyListeners();
    }
  }
}
