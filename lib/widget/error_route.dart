import 'package:flutter/material.dart';

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Error Route',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
