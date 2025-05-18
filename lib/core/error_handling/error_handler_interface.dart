import 'package:flutter/foundation.dart';
import '../exceptions/app_exceptions.dart';

abstract class IErrorHandler extends ChangeNotifier {
  AppException? get currentError;
  void handleError(dynamic error);
  void clearError();
  String getErrorMessage();
  String? getErrorCode();
}
