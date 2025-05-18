import 'package:get_it/get_it.dart';
import '../providers/error_handler.dart';
import '../error_handling/error_handler_interface.dart';
import '../services/auth_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Error Handler (debe registrarse primero)
  getIt.registerLazySingleton<IErrorHandler>(() => ErrorHandler());
  
  // Services
  getIt.registerLazySingleton(() => AuthService());
}
