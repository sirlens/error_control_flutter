import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../error_handling/error_handler.dart';

class ErrorListener extends StatelessWidget {
  final Widget child;

  const ErrorListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ErrorHandler>(
      builder: (context, errorHandler, _) {
        if (errorHandler.currentError != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(errorHandler.currentError?.message ??
                      'Unknown error occurred'),
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
            }
          });
        }
        return child;
      },
    );
  }
}
