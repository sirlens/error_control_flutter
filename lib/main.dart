import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simulate_struct_app/features/auth/presentation/pages/login_page.dart';
import 'core/di/service_locator.dart';
import 'core/error_handling/error_handler_interface.dart';
import 'core/services/auth_service.dart';
import 'core/providers/auth_provider.dart';
import 'core/routing/app_router.dart';
import 'core/widgets/error_display.dart';

void main() {
  setupServiceLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            getIt<IErrorHandler>(),
            getIt<AuthService>(),
          ),
        ),
        ChangeNotifierProvider<IErrorHandler>(
          create: (_) => getIt<IErrorHandler>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: AppRouter.login,
      onGenerateRoute: AppRouter.generateRoute,
      home: const ErrorDisplay(
        child: LoginPage(),
      ),
    );
  }
}
