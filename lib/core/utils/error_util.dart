import 'package:flutter/material.dart';

import '../errors/errors.dart';
import '../router/router.dart';

class ErrorUtil {
  static Widget buildErrorContent(BuildContext context, Failure failure, VoidCallback onRetry) {
    String errorMessage;
    if (failure is ServerFailure) {
      errorMessage = 'Server failure. Please try again later.';
    } else if (failure is CacheFailure) {
      errorMessage = 'Cache failure. Please try again later.';
    } else if (failure is NetworkFailure) {
      errorMessage = 'No network connection. Please check your internet.';
    } else if (failure is CredentialFailure || failure is AuthenticationFailure) {
      errorMessage = 'Invalid credentials. Please try again.';
      // Navigate to the login screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.login,
          (route) => false,
        );
      });
    } else {
      errorMessage = 'An unknown error occurred. Please try again.';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
