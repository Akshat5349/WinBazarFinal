import 'package:get/get.dart';

class QuizController extends GetxController {
  final RxInt currentQuestion = 0.obs;
  final RxList<int> selectedAnswers = <int>[].obs;
  final RxBool showResult = false.obs;

  final List<Map<String, dynamic>> questions = [
    {
      'ques': 'What does the term "Open" represent in Matka?',
      'options': [
        'Opening Result',
        'Closing Result',
        'Winning Amount',
        'Betting Time'
      ],
      'correct': 0
    },
    {
      'ques': 'In Matka, what is the typical range of single numbers?',
      'options': ['1-10', '0-9', '1-100', '10-99'],
      'correct': 1
    },
    {
      'ques': 'What is another popular name for Matka in India?',
      'options': ['Poker', 'Roulette', 'Satta', 'Baccarat'],
      'correct': 2
    },
    {
      'ques': 'What is a "Single Patti" in Matka?',
      'options': [
        'A single-digit number',
        'A three-digit result',
        'A pair of numbers',
        'A winning bet'
      ],
      'correct': 1
    },
    {
      'ques': 'Which day is most associated with Kalyan Matka draws?',
      'options': ['Monday', 'Wednesday', 'Saturday', 'All days except Sunday'],
      'correct': 3
    },
    {
      'ques': 'What does the term "Jodi" mean in Matka?',
      'options': [
        'A pair of numbers',
        'A single number',
        'A triple number',
        'A bet amount'
      ],
      'correct': 0
    },
    {
      'ques': 'What is the main purpose of a Matka chart?',
      'options': [
        'To display past results',
        'To show betting odds',
        'To list player names',
        'To calculate winnings'
      ],
      'correct': 0
    },
  ];

  void selectAnswer(int index) {
    if (selectedAnswers.length > currentQuestion.value) {
      selectedAnswers[currentQuestion.value] = index;
    } else {
      selectedAnswers.add(index);
    }
  }

  void nextQuestion() {
    if (currentQuestion.value < questions.length - 1) {
      currentQuestion.value++;
    } else {
      showResult.value = true;
    }
  }

  void resetQuiz() {
    currentQuestion.value = 0;
    selectedAnswers.clear();
    showResult.value = false;
  }

  int get correctCount {
    int count = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers.length > i &&
          selectedAnswers[i] == questions[i]['correct']) {
        count++;
      }
    }
    return count;
  }
}
