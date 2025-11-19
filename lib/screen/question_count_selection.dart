import 'package:flutter/material.dart';

import '../widget/base_background.dart';
import 'game_start_screen.dart';

class QuestionCountSelectionScreen extends StatelessWidget {
  const QuestionCountSelectionScreen({super.key});

  static const routeName = '/question-count-selection';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final topic = (args?['topic'] as String?) ?? '';
    final difficulty = (args?['difficulty'] as String?) ?? '';

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
                const SizedBox(height: 80),
                Text(
                  topic,
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF06B4C9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                if (difficulty.isNotEmpty)
                  Text(
                    difficulty,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                const Spacer(),
                _buildCountButton(context, topic, difficulty, '10'),
                const SizedBox(height: 24),
                _buildCountButton(context, topic, difficulty, '20'),
                const SizedBox(height: 24),
                _buildCountButton(context, topic, difficulty, '30'),
                const SizedBox(height: 24),
                _buildCountButton(context, topic, difficulty, '+'),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountButton(
    BuildContext context,
    String topic,
    String difficulty,
    String label,
  ) {
    return SizedBox(
      width: 220,
      height: 76,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.35),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            GameStartScreen.routeName,
            arguments: {
              'topic': topic,
              'difficulty': difficulty,
              'count': label,
            },
          );
        },
        child: Text(label),
      ),
    );
  }
}
