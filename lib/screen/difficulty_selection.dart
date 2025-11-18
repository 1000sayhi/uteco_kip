import 'package:flutter/material.dart';

import '../widget/base_background.dart';

class DifficultySelectionScreen extends StatelessWidget {
  const DifficultySelectionScreen({super.key});

  static const routeName = '/difficulty-selection';

  @override
  Widget build(BuildContext context) {
    final selectedTopic = ModalRoute.of(context)?.settings.arguments as String?;

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
                  selectedTopic ?? '',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF06B4C9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                _buildDifficultyButton(context, '쉬움'),
                const SizedBox(height: 24),
                _buildDifficultyButton(context, '보통'),
                const SizedBox(height: 24),
                _buildDifficultyButton(context, '어려움'),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(BuildContext context, String label) {
    return SizedBox(
      width: 220,
      height: 76,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(217, 217, 217, 0.27),
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: () {
          // 문제 수 선택 화면 이동
        },
        child: Text(label),
      ),
    );
  }
}
