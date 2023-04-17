import 'package:expense_ledger/value/route_names.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacementNamed(RouteName.home),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              width: 125,
              height: 110,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),
            Text(
              'Track Your Expenses',
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 24),
            ),
            Text(
              'Simply',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
