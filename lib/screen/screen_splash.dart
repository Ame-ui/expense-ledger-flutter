import 'package:expense_ledger/value/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
      ),
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
