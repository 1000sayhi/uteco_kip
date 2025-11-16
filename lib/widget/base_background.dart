import 'package:flutter/material.dart';

class BaseBackground extends StatelessWidget {
  const BaseBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/base_screen.jpg',
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),
      ],
    );
  }
}
