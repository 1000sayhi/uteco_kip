import 'package:flutter/material.dart';

import 'topic_selection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/home_screen.jpg',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 120),
                const Text(
                  'KIP',
                  style: TextStyle(
                    fontSize: 110,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 62, 179, 75),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      TopicSelectionScreen.routeName,
                    );
                  },
                  child: const Text(
                    '🧠',
                    style: TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(255, 171, 185, 1.0)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'press button to\nstart the KIP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
