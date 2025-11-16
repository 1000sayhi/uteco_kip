import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _routeToHome();
  }

  void _routeToHome() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Image.asset(
            'assets/images/splash_screen.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
