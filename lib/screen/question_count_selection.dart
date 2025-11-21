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
                _buildCustomCountButton(context, topic, difficulty),
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
          _navigateToGameStart(context, topic, difficulty, label);
        },
        child: Text(label),
      ),
    );
  }

  Widget _buildCustomCountButton(
    BuildContext context,
    String topic,
    String difficulty,
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
        onPressed: () async {
          final customCount = await _showCustomCountDialog(context);
          if (customCount == null) {
            return;
          }
          _navigateToGameStart(
            context,
            topic,
            difficulty,
            customCount.toString(),
          );
        },
        child: const Text('+'),
      ),
    );
  }

  void _navigateToGameStart(
    BuildContext context,
    String topic,
    String difficulty,
    String count,
  ) {
    Navigator.pushNamed(
      context,
      GameStartScreen.routeName,
      arguments: {
        'topic': topic,
        'difficulty': difficulty,
        'count': count,
      },
    );
  }

  Future<int?> _showCustomCountDialog(BuildContext context) {
    int tempValue = 15;
    return showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 91, 130, 34),
                  Color.fromARGB(255, 58, 199, 124)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 30,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '문제 수를 선택해주세요',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _AdjustButton(
                          icon: Icons.remove,
                          enabled: tempValue > 1,
                          onPressed: () {
                            if (tempValue > 1) {
                              setState(() => tempValue--);
                            }
                          },
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '$tempValue',
                                style: const TextStyle(
                                  fontSize: 52,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                '문제',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        _AdjustButton(
                          icon: Icons.add,
                          enabled: tempValue < 30,
                          onPressed: () {
                            if (tempValue < 30) {
                              setState(() => tempValue++);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('취소'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF0A5FA2),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () =>
                                Navigator.pop(dialogContext, tempValue),
                            child: const Text('확인'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _AdjustButton extends StatelessWidget {
  const _AdjustButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(40),
        child: Ink(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
