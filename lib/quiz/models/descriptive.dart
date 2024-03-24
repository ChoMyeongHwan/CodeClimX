class Descriptive {
  final String id, question, hint;

  Descriptive({
    required this.id,
    required this.question,
    required this.hint,
  });

  factory Descriptive.fromMap(Map<String, dynamic> data, String id) {
    return Descriptive(
      id: id,
      question: data['question'],
      hint: data['hint'],
    );
  }
}
