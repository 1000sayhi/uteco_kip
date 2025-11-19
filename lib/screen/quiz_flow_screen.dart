import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/dummy_questions.dart';
import '../model/quiz_question.dart';
import '../widget/base_background.dart';

enum QuizStage { question, result, explanation }

class QuizFlowScreen extends StatefulWidget {
  const QuizFlowScreen({super.key});

  static const routeName = '/quiz-flow';

  @override
  State<QuizFlowScreen> createState() => _QuizFlowScreenState();
}

class _QuizFlowScreenState extends State<QuizFlowScreen> {
  late final String topic;
  late final String difficulty;
  late final int totalQuestions;
  late final List<QuizQuestion> questions;
  bool _initialized = false;

  int currentIndex = 0;
  int correctCount = 0;
  QuizStage stage = QuizStage.question;
  int? selectedIndex;
  bool isAnswerCorrect = false;
  int countdown = 10;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    topic = (args['topic'] as String?) ?? '';
    difficulty = (args['difficulty'] as String?) ?? '';
    final countLabel = (args['count'] as String?) ?? '10';
    final parsedCount = int.tryParse(countLabel);

    final baseQuestions = getQuestionsFor(topic);
    totalQuestions =
        parsedCount == null ? baseQuestions.length : parsedCount.clamp(1, 100);
    questions = List.generate(totalQuestions, (index) {
      return baseQuestions[index % baseQuestions.length];
    });
    _startTimer();
  }

  void _selectAnswer(int index) {
    if (stage != QuizStage.question) return;
    _timer?.cancel();
    selectedIndex = index;
    final question = questions[currentIndex];
    isAnswerCorrect = question.correctIndex == index;
    if (isAnswerCorrect) correctCount++;
    setState(() {
      stage = QuizStage.result;
    });
  }

  void _goToExplanation() {
    if (stage != QuizStage.result) return;
    setState(() {
      stage = QuizStage.explanation;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _nextQuestion() {
    if (currentIndex + 1 >= totalQuestions) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      currentIndex++;
      selectedIndex = null;
      stage = QuizStage.question;
      countdown = 10;
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    countdown = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (stage != QuizStage.question) {
        timer.cancel();
        return;
      }
      if (countdown > 1) {
        setState(() {
          countdown--;
        });
      } else {
        setState(() {
          countdown = 0;
        });
        timer.cancel();
        _selectAnswer(-1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];
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
                const SizedBox(height: 40),
                Text(
                  topic,
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF06B4C9),
                  ),
                ),
                const SizedBox(height: 16),
                if (stage == QuizStage.question)
                  _buildQuestionView(question)
                else if (stage == QuizStage.explanation)
                  _buildExplanationView(question)
                else
                  const Spacer(),
                Text(
                  '${currentIndex + 1} / $totalQuestions',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
            if (stage == QuizStage.result)
              Positioned.fill(
                child: _buildResultView(question),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionView(QuizQuestion question) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Text(
              countdown.toString(),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Color(0xFFE74C3C),
              ),
            ),
            const SizedBox(height: 60),
            Expanded(
              child: Column(
                children: [
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 120),
                  Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: question.options.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 2.5,
                      ),
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white24,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () => _selectAnswer(index),
                          child: Text(question.options[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView(QuizQuestion question) {
    final correctTextStyle = TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.w900,
      color: isAnswerCorrect ? Colors.blueAccent : Colors.redAccent,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 140),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            countdown.toString(),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Color(0xFFE74C3C),
            ),
          ),
          const SizedBox(height: 80),
          Text(
            isAnswerCorrect ? 'O' : 'X',
            style: correctTextStyle,
          ),
          const SizedBox(height: 10),
          Text(
            isAnswerCorrect ? '정답입니다' : '오답입니다',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF09B9C8),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            ),
            onPressed: _goToExplanation,
            child: const Text(
              '정답 및 해설 보기',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationView(QuizQuestion question) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              '정답 및 해설',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                question.options[question.correctIndex],
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF06B4C9),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  question.explanation,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF09B9C8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
              ),
              onPressed: _nextQuestion,
              child: Text(
                currentIndex + 1 >= totalQuestions ? '완료' : '다음 문제',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
