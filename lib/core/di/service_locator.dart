import 'package:get_it/get_it.dart';
import '../error_handling/error_handler_interface.dart';
import '../error_handling/error_handler.dart';
import '../services/auth_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Services
  getIt.registerLazySingleton(() => AuthService());

  // Error Handler
  getIt.registerLazySingleton<IErrorHandler>(() => ErrorHandler());
}
