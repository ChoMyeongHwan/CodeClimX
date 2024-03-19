import 'package:codeclimx/quiz/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/quiz_list_tile.dart';
import '../services/firebase_service.dart';
import '../themes/app_colors.dart' as app_colors;

class QuizScreen extends StatelessWidget {
  // utils 폴더에 상수를 관리하는 파일을 만들어 관리하는 방법 고려
  static const String routeName = "quiz";
  static const String routeURL = "/quiz";

  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: app_colors.iconColor,
            size: 40,
          ),
          onPressed: () {},
        ),
        title: const Text(
          '퀴즈',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.person,
              color: app_colors.iconColor,
              size: 40,
            ),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseService.streamVideos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  '데이터가 없습니다',
                ),
              );
            }
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) {
                var video = snapshot.data!.docs[index];
                return QuizListTile(
                  video: video,
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(
        currentIndex: 2,
      ),
    );
  }
}
