import 'package:codeclimx/videos/curriculum/roadmap_screen.dart';
import 'package:codeclimx/videos/curriculum/topics_screen.dart';
import 'package:flutter/material.dart';

class LectureBox extends StatelessWidget {
  final Lecture lecture;

  const LectureBox({super.key, required this.lecture});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector 추가
      onTap: () {
        // onTap 이벤트 핸들러에서 SectionDetailScreen으로 네비게이션
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TopicsScreen(
                  videoId: lecture.videoId,
                  title: lecture.title,
                )));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          leading: const Icon(Icons.bookmark_border,
              size: 40), // Use an icon that matches the design
          title: Text(
            lecture.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(lecture.description),
          trailing: Text("소단원 수: ${lecture.sectionCount}"),
        ),
      ),
    );
  }
}
