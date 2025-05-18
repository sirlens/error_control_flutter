import 'package:flutter/material.dart';
import '../error_handling/error_handler_interface.dart';
import '../exceptions/app_exceptions.dart';
import '../di/service_locator.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

class AppRouter {
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case login:
          return MaterialPageRoute(builder: (_) => const LoginPage());
        case dashboard:
          return MaterialPageRoute(builder: (_) => const DashboardPage());
        default:
          throw NavigationException(
            route: settings.name ?? 'unknown'
          );
      }
    } catch (e) {
      return MaterialPageRoute(
        builder: (context) {
          if (e is AppException) {
            getIt<IErrorHandler>().handleError(e);
          } else {
            getIt<IErrorHandler>().handleError(
              GenericException(message: e.toString()),
            );
          }
          return const LoginPage();
        },
      );
    }
  }
}
