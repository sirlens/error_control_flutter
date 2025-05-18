import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../error_handling/error_handler_interface.dart';

class ErrorDisplay extends StatelessWidget {
  final Widget child;

  const ErrorDisplay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<IErrorHandler>(
      builder: (context, errorHandler, _) {
        if (errorHandler.currentError != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error ${errorHandler.getErrorCode() ?? ''}'),
                content: Text(errorHandler.getErrorMessage()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      errorHandler.clearError();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          });
        }
        return child;
      },
    );
  }
}
