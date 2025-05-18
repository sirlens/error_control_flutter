import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../error_handling/app_error_handler.dart';

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
          throw NavigationError(route: settings.name ?? 'unknown');
      }
    } catch (e) {
      return MaterialPageRoute(
        builder: (context) {
          AppErrorHandler.handleError(context, e);
          // Fallback a una ruta segura
          return const LoginPage();
        },
      );
    }
  }
}
