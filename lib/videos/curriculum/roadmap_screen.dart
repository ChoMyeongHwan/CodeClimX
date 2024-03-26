import 'package:codeclimx/common/widget/custom_bottom_navbar.dart';
import 'package:codeclimx/videos/curriculum/widgets/lecturebox.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class RoadmapScreen extends StatefulWidget {
  static const String routeName = "roadmap";
  static const String routeURL = "/roadmap";

  const RoadmapScreen({super.key});

  @override
  _RoadmapScreenState createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference lecturesCollection;
  late Future<List<Lecture>> lecturesFuture;

  @override
  void initState() {
    super.initState();
    lecturesCollection = firestore.collection('videos');
    lecturesFuture = fetchLectures();
  }

  Future<List<Lecture>> fetchLectures() async {
    try {
      QuerySnapshot videoSnapshot = await lecturesCollection.get();
      List<Lecture> lectures = [];

      for (var videoDoc in videoSnapshot.docs) {
        var videoData = videoDoc.data() as Map<String, dynamic>;
        // Firestore 인스턴스 재사용
        var sectionCountSnapshot = await lecturesCollection
            .doc(videoDoc.id)
            .collection('sections')
            .get();
        int sectionCount = sectionCountSnapshot.docs.length;

        lectures.add(Lecture(
            title: videoData['videoName'] ?? 'No Title',
            description: videoData['totalDesc'] ?? 'No Summary',
            sectionCount: sectionCount,
            videoId: videoDoc.id));
      }
      return lectures;
    } catch (e) {
      // 오류 처리
      print(e.toString());
      throw Exception('Failed to fetch lectures');
    }
  }

  void _onHomeTap(BuildContext context) {
    // 수정된 부분: GoRouter를 사용하여 홈 화면으로 이동
    GoRouter.of(context).go('/home');
  }

  void _onVideoSearchTap(BuildContext context) {
    // 수정된 부분: GoRouter를 사용하여 홈 화면으로 이동
    GoRouter.of(context).go('/videoSearch');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Lectures"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search), // 검색 아이콘 추가
            onPressed: () => _onVideoSearchTap(context),
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => _onHomeTap(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Lecture>>(
        future: lecturesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print(snapshot);
            return const Center(child: Text('No lectures found'));
          }
          final lectures = snapshot.data!;
          return ListView.builder(
            itemCount: lectures.length,
            itemBuilder: (context, index) {
              return LectureBox(lecture: lectures[index]);
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavbar(
        currentIndex: 1,
      ),
    );
  }
}

class Lecture {
  final String title;
  final String description;
  final int sectionCount;
  final String videoId;

  Lecture({
    required this.title,
    required this.description,
    required this.sectionCount,
    required this.videoId,
  });
}
