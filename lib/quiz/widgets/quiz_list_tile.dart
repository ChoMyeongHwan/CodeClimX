import 'package:flutter/material.dart';
import '../widgets/quiz_type_modal.dart';
import '../screens/quiz_detail_screen.dart';
import '../screens/descriptive_detail_screen.dart';
import '../../common/themes/app_colors.dart' as app_colors;

class QuizListTile extends StatelessWidget {
  final dynamic video;

  const QuizListTile({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ListTile(
        leading:
            const Icon(Icons.play_circle_fill, color: app_colors.primaryColor),
        title: Text(
          video.data()?['videoName'] ?? '제목 없음',
          style: const TextStyle(fontSize: 18),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => _showQuizTypeModal(context, video.id), // 여기서 모달을 띄움
      ),
    );
  }

  void _showQuizTypeModal(BuildContext context, String videoId) {
    showModalBottomSheet(
      context: context,
      builder: (_) => QuizTypeModal(
        onMultipleSelected: () {
          Navigator.pop(context); // 모달창 닫기
          Navigator.push(
            // 객관식 퀴즈 상세 화면으로 이동
            context,
            MaterialPageRoute(
              builder: (context) => QuizDetailScreen(videoDocId: videoId),
            ),
          );
        },
        onDescripiveSelected: () {
          Navigator.pop(context); // 모달창 닫기
          Navigator.push(
            // 주관식 퀴즈 상세 화면으로 이동
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DescriptiveDetailScreen(videoDocId: videoId),
            ),
          );
        },
      ),
    );
  }
}
