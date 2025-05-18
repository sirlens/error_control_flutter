import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/error_handling/error_handler_interface.dart';
import '../../core/exceptions/app_exceptions.dart';

class ErrorDisplay extends StatelessWidget {
  final Widget child;

  const ErrorDisplay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<IErrorHandler>(
      builder: (context, errorHandler, _) {
        final currentError = errorHandler.lastError;
        if (errorHandler.hasError && currentError != null) {
          // Usar microtask para asegurar que el error se muestre después de que el widget se construya
          Future.microtask(() {
            if (context.mounted) {
              _showErrorMessage(context, currentError);
              errorHandler.clearError();
            }
          });
        }
        return child;
      },
    );
  }

  void _showErrorMessage(BuildContext context, AppException error) {
    // Limpiar cualquier SnackBar anterior
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(error.message),
            if (error.code != null)
              Text(
                'Code: ${error.code}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        backgroundColor: _getErrorColor(error.severity),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            if (context.mounted) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          },
        ),
      ),
    );
  }

  Color _getErrorColor(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.low:
        return Colors.orange;
      case ErrorSeverity.medium:
        return Colors.red;
      case ErrorSeverity.high:
        return Colors.red[900]!;
    }
  }
}