import 'package:flutter/material.dart';

class QuizTypeModal extends StatelessWidget {
  final VoidCallback onMultipleSelected;
  final VoidCallback onDescripiveSelected;

  const QuizTypeModal({
    super.key,
    required this.onMultipleSelected,
    required this.onDescripiveSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('객관식'),
            onTap: onMultipleSelected,
          ),
          ListTile(
            leading: const Icon(Icons.short_text),
            title: const Text('주관식'),
            onTap: onDescripiveSelected,
          ),
        ],
      ),
    );
  }
}
