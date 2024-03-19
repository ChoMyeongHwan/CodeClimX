class Quiz {
  final String id;
  final String question;
  final List<String> choices;
  final int answerIndex;

  Quiz({
    required this.id,
    required this.question,
    required this.choices,
    required this.answerIndex,
  });

  factory Quiz.fromMap(Map<String, dynamic> data, String id) {
    return Quiz(
      id: id,
      question: data['question'],
      choices: List<String>.from(data['choices']),
      answerIndex: data['answer'],
    );
  }
}
