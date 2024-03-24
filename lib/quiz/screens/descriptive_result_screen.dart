import 'package:flutter/material.dart';
import '../models/descriptive.dart';

class DescriptiveResultScreen extends StatelessWidget {
  final List<Descriptive> descriptives;
  final List<String> userAnswers;
  final List<String> gptFeedbacks;

  const DescriptiveResultScreen({
    super.key,
    required this.descriptives,
    required this.userAnswers,
    required this.gptFeedbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('퀴즈 결과'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: descriptives.length,
        itemBuilder: (context, index) {
          final descriptive = descriptives[index];
          final userAnswer = userAnswers[index];
          final feedback = gptFeedbacks[index];
          print('---결과화면 : $userAnswer---');
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '[퀴즈 ${index + 1}] ${descriptive.question}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '당신의 답변: $userAnswer',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '피드백: $feedback',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
