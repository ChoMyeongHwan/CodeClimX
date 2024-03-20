import 'package:flutter/material.dart';
import '../models/quiz.dart';

class QuizCard extends StatelessWidget {
  final Quiz quiz;
  final int selectedChoice;
  final int quizNumber; // 퀴즈 번호를 위한 변수 추가
  final ValueChanged<int> onChanged;

  const QuizCard({
    super.key,
    required this.quiz,
    required this.selectedChoice,
    required this.quizNumber, // 생성자에 퀴즈 번호를 추가
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: Card(
          elevation: 4.0, // 카드에 그림자 추가
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '[퀴즈 $quizNumber] ${quiz.question}', // 퀴즈 번호와 질문을 함께 표시
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20.0),
                ...quiz.choices.asMap().entries.map(
                  (entry) {
                    int idx = entry.key;
                    String text = entry.value;
                    return RadioListTile<int>(
                      title: Text(text),
                      value: idx,
                      groupValue: selectedChoice,
                      onChanged: (int? value) {
                        if (value != null) {
                          onChanged(value);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
