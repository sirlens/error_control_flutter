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
        if (errorHandler.hasError && errorHandler.lastError != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showErrorMessage(context, errorHandler.lastError!);
            errorHandler.clearError();
          });
        }
        return child;
      },
    );
  }

  void _showErrorMessage(BuildContext context, AppException error) {
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
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
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