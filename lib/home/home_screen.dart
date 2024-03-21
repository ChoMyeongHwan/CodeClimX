import 'package:codeclimx/chatbot/components/chatbot_widget.dart';
import 'package:codeclimx/videos/authentication/repos/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:codeclimx/quiz/widgets/custom_bottom_navbar.dart'; // 하단 네비게이션 바 추가
import '../quiz/themes/app_colors.dart' as app_colors; // 색상 테마 추가

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = 'home';
  static const String routeURL = '/home';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // 중앙 정렬
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: app_colors.iconColor, size: 40),
          onPressed: () {},
        ),
        title: SizedBox(
          height: kToolbarHeight, // AppBar의 높이를 맞춤
          child: Image.asset(
            'assets/logo.jpg',
            fit: BoxFit.contain, // 이미지 비율을 유지하면서 공간을 최대로 채움
          ),
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.logout, color: app_colors.iconColor, size: 40),
            onPressed: () {
              ref.read(authRepo).signOut();
              context.go("/");
            },
          ),
        ],
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.question_mark, size: 50), // 아이콘 변경
            Text('여기에 무엇을 넣으면 좋을까?') // 추가적인 위젯이나 콘텐츠를 여기에 배치
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const ChatBotWidget(),
      bottomNavigationBar:
          const CustomBottomNavbar(currentIndex: 0), // 현재 인덱스 수정
    );
  }
}
