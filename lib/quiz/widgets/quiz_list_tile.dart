import 'package:flutter/material.dart';
import '../screens/quiz_detail_screen.dart';
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
          video.data()?['videoName'] ?? '제목 없음', // videoName이 없다면 '제목 없음'을 사용
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizDetailScreen(
                videoDocId: video.id,
              ),
            ),
          );
        },
      ),
    );
  }
}
