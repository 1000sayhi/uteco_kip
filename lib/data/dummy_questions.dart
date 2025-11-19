import '../model/quiz_question.dart';

const Map<String, List<QuizQuestion>> dummyQuestions = {
  '대중문화': [
    QuizQuestion(
      question:
          '2024년 아카데미 시상식에서 작품상(Best Picture)을 수상한 영화는 무엇일까요?',
      options: ['오펜하이머', '바비', '킬러스 오브 더 플라워 문', '패스트 라이브즈'],
      correctIndex: 0,
      explanation:
          '크리스토퍼 놀란 감독의 작품으로, 원자폭탄 개발을 주제로 한 전기 영화입니다. 2024년 아카데미 시상식에서 작품상, 감독상 등 주요 부문을 수상했습니다.',
    ),
    QuizQuestion(
      question: 'BTS가 발표한 곡 중, 2020년 빌보드 Hot 100 1위를 최초로 차지한 곡은?',
      options: ['Dynamite', 'Butter', 'Permission to Dance', 'Boy With Luv'],
      correctIndex: 0,
      explanation:
          '2020년 발표된 디지털 싱글로, 한국 가수 최초로 빌보드 Hot 100 차트 1위를 기록했습니다.',
    ),
  ],
  '기본상식': [
    QuizQuestion(
      question: '빛의 속도는 초당 약 몇 km일까요?',
      options: ['300천 km', '30천 km', '3천 km', '300 km'],
      correctIndex: 0,
      explanation: '빛의 속도는 약 299,792 km/s로, 흔히 300천 km/s로 말합니다.',
    ),
    QuizQuestion(
      question: '태양계에서 가장 큰 행성은 무엇인가요?',
      options: ['지구', '목성', '토성', '해왕성'],
      correctIndex: 1,
      explanation: '목성은 태양계에서 가장 크고 질량이 큰 행성입니다.',
    ),
  ],
};

List<QuizQuestion> getQuestionsFor(String topic) {
  return dummyQuestions[topic] ??
      dummyQuestions.values.first;
}
