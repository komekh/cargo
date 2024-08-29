import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String message;

  const RetryWidget({
    super.key,
    required this.onRetry,
    this.message = 'error_message',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
