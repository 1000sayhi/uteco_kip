import 'package:flutter/material.dart';

import '../widget/base_background.dart';

class TopicSelectionScreen extends StatelessWidget {
  const TopicSelectionScreen({super.key});

  static const routeName = '/topic-selection';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BaseBackground(
        child: Center(
          child: Text(
            '주제를 선택하세요.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
