import 'package:flutter/foundation.dart';

import '../exceptions/app_exceptions.dart';

abstract class IErrorHandler extends ChangeNotifier {
  AppException? get lastError;
  bool get hasError;
  
  void handleError(AppException error);
  void clearError();
}
