import 'package:flutter/material.dart';

import '../widget/base_background.dart';
import 'quiz_flow_screen.dart';

class GameStartScreen extends StatelessWidget {
  const GameStartScreen({super.key});

  static const routeName = '/game-start';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final topic = (args?['topic'] as String?) ?? '';
    final difficulty = (args?['difficulty'] as String?) ?? '';
    final count = (args?['count'] as String?) ?? '';

    return Scaffold(
      body: BaseBackground(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 12,
              bottom: 12,
              child: SafeArea(
                child: IconButton(
                  iconSize: 32,
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 280),
                Text(
                  topic,
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF06B4C9),
                    decorationColor: Color(0xFF06B4C9),
                    decorationThickness: 2.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: '난이도: ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: difficulty,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: '문제수: ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: count,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                SizedBox(
                  width: 200,
                  height: 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF09B9C8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        QuizFlowScreen.routeName,
                        arguments: {
                          'topic': topic,
                          'difficulty': difficulty,
                          'count': count,
                        },
                      );
                    },
                    child: const Text('start'),
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
