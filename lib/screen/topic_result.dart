import 'package:flutter/material.dart';

import '../widget/base_background.dart';

class TopicResultScreen extends StatelessWidget {
  const TopicResultScreen({super.key});

  static const routeName = '/topic-result';

  @override
  Widget build(BuildContext context) {
    final selected = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      body: BaseBackground(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '선택한 주제',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    selected ?? '선택 없음',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
