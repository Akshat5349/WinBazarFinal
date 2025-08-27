import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quiz_controller.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.put(QuizController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Play'),
      ),
      body: Obx(() {
        if (controller.showResult.value) {
          return _buildResult(controller);
        }
        final q = controller.questions[controller.currentQuestion.value];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.questions.length,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: controller.currentQuestion.value == i
                          ? Colors.green
                          : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text('${i + 1}')),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                q['ques'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ...List.generate(q['options'].length, (i) {
                return Obx(() => Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.selectedAnswers.length >
                                      controller.currentQuestion.value &&
                                  controller.selectedAnswers[
                                          controller.currentQuestion.value] ==
                                      i
                              ? Colors.green
                              : Colors.white,
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.black12),
                        ),
                        onPressed: () {
                          controller.selectAnswer(i);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(q['options'][i]),
                        ),
                      ),
                    ));
              }),
              const Spacer(),
              ElevatedButton(
                onPressed: controller.selectedAnswers.length >
                        controller.currentQuestion.value
                    ? controller.nextQuestion
                    : null,
                child: Text(controller.currentQuestion.value ==
                        controller.questions.length - 1
                    ? 'Submit'
                    : 'Next'),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildResult(QuizController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Result',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ...List.generate(controller.questions.length, (i) {
              final q = controller.questions[i];
              final selected = controller.selectedAnswers.length > i
                  ? controller.selectedAnswers[i]
                  : null;
              final correct = q['correct'];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text('Question ${i + 1}: ${q['ques']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Selected Answer: ${selected != null ? q['options'][selected] : 'No answer'}',
                          style: TextStyle(
                              color: selected == correct
                                  ? Colors.green
                                  : Colors.red)),
                      Text('Correct Answer: ${q['options'][correct]}',
                          style: const TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            Text(
              'Score: ${controller.correctCount} / ${controller.questions.length}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.resetQuiz,
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
