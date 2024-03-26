import 'package:codeclimx/common/widget/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../widgets/quiz_card.dart';
import '../services/firebase_service.dart';
import 'quiz_result_screen.dart';

class QuizDetailScreen extends StatefulWidget {
  final String videoDocId;

  const QuizDetailScreen({super.key, required this.videoDocId});

  @override
  QuizDetailScreenState createState() => QuizDetailScreenState();
}

class QuizDetailScreenState extends State<QuizDetailScreen> {
  List<Quiz> _quizzes = [];
  int _currentQuestionIndex = 0;
  List<int> _selectedChoices = [];

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  void _loadQuizzes() async {
    var quizzes = await FirebaseService().loadQuizzes(widget.videoDocId);
    setState(() {
      _quizzes = quizzes;
      _selectedChoices = List.filled(_quizzes.length, -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '객관식 퀴즈',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: _quizzes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : QuizCard(
              quiz: _quizzes[_currentQuestionIndex],
              selectedChoice: _selectedChoices[_currentQuestionIndex],
              quizNumber: _currentQuestionIndex + 1, // 현재 퀴즈 번호 추가
              onChanged: (int value) {
                setState(() {
                  _selectedChoices[_currentQuestionIndex] = value;
                });
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextQuestion,
        child: Icon(_currentQuestionIndex < _quizzes.length - 1
            ? Icons.arrow_forward
            : Icons.check),
      ),
      bottomNavigationBar: const CustomBottomNavbar(
        currentIndex: 3,
      ),
    );
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _quizzes.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // 퀴즈 결과 화면으로 이동하기 전에 필요한 모든 인자를 전달합니다.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultScreen(
            score: _calculateScore(), // 사용자의 점수
            quizzes: _quizzes, // 전체 퀴즈 목록
            userAnswers: _selectedChoices, // 사용자가 선택한 답변 목록
          ),
        ),
      );
    }
  }

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < _quizzes.length; i++) {
      if (_selectedChoices[i] == _quizzes[i].answerIndex) {
        score++;
      }
    }
    return score;
  }
}
