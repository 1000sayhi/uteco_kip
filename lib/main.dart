import 'package:flutter/material.dart';
import 'screen/home.dart';
import 'screen/splash.dart';
import 'screen/difficulty_selection.dart';
import 'screen/question_count_selection.dart';
import 'screen/game_start_screen.dart';
import 'screen/topic_selection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        TopicSelectionScreen.routeName: (context) =>
            const TopicSelectionScreen(),
        DifficultySelectionScreen.routeName: (context) =>
            const DifficultySelectionScreen(),
        QuestionCountSelectionScreen.routeName: (context) =>
            const QuestionCountSelectionScreen(),
        GameStartScreen.routeName: (context) => const GameStartScreen(),
      },
    );
  }
}
