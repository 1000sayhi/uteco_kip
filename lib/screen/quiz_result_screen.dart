import 'package:flutter/material.dart';

import '../widget/base_background.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  static const routeName = '/quiz-result';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final topic = (args?['topic'] as String?) ?? '';
    final total = (args?['total'] as int?) ?? 0;
    final correct = (args?['correct'] as int?) ?? 0;

    return Scaffold(
      body: BaseBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                '게임 결과',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '$topic 편',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF06B4C9),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                '$correct / $total',
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFF4A73B),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '👏🎉 $correct개나 맞혔어요!',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '다음 번엔 더 잘할 수 있을 거예요!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                ),
                onPressed: () => Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                ),
                child: const Icon(
                  Icons.refresh,
                  size: 32,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
