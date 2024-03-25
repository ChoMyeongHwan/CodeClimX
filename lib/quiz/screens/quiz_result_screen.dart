import 'package:codeclimx/common/widget/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import '../models/quiz.dart';
import 'quiz_screen.dart';

class QuizResultScreen extends StatelessWidget {
  final int score;
  final List<Quiz> quizzes;
  final List<int> userAnswers;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.quizzes,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('퀴즈 결과'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // 모든 스택을 제거하고 홈 화면으로 이동
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const QuizScreen()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: quizzes.length + 1, // +1 for the score display at the end
          itemBuilder: (context, index) {
            if (index < quizzes.length) {
              Quiz quiz = quizzes[index];
              bool hasAnswered = userAnswers[index] != -1;
              bool isCorrect =
                  hasAnswered && userAnswers[index] == quiz.answerIndex;
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    '[퀴즈 ${index + 1}] ${quiz.question}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('정답: ${quiz.choices[quiz.answerIndex]}'),
                      hasAnswered
                          ? Text('사용자 선택: ${quiz.choices[userAnswers[index]]}')
                          : const Text('사용자 선택: 답변하지 않음'),
                    ],
                  ),
                  trailing: hasAnswered
                      ? Icon(
                          isCorrect
                              ? Icons.check_circle_outline
                              : Icons.highlight_off,
                          color: isCorrect ? Colors.green : Colors.red,
                        )
                      : null,
                ),
              );
            } else {
              // Score display tile
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  '당신의 점수는 $score점 입니다.',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(
        currentIndex: 3,
      ),
    );
  }
}
