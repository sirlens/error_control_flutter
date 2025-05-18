import 'package:flutter/scheduler.dart';
import '../exceptions/app_exceptions.dart';
import '../error_handling/error_handler_interface.dart';

class ErrorHandler extends IErrorHandler {
  AppException? _lastError;
  final List<AppException> _errorHistory = [];
  final List<AppException> _errorQueue = [];
  bool _isProcessingErrors = false;

  @override
  AppException? get lastError => _lastError;

  @override
  bool get hasError => _lastError != null;

  List<AppException> get errorHistory => List.unmodifiable(_errorHistory);

  @override
  void handleError(AppException error) {
    _errorQueue.add(error);
    if (!_isProcessingErrors) {
      _processErrorQueue();
    }
  }

  void _processErrorQueue() {
    if (_errorQueue.isEmpty) {
      _isProcessingErrors = false;
      return;
    }

    _isProcessingErrors = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_errorQueue.isNotEmpty) {
        _lastError = _errorQueue.removeAt(0);
        _errorHistory.add(_lastError!);
        notifyListeners();
      }
      _processErrorQueue();
    });
  }

  @override
  void clearError() {
    _lastError = null;
    notifyListeners();
  }
}
