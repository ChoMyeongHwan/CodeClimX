import 'package:codeclimx/chatbot/widgets/chatbot_widget.dart';
import 'package:codeclimx/common/widget/custom_bottom_navbar.dart';
import 'package:codeclimx/videos/authentication/repos/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../common/themes/app_colors.dart' as app_colors; // 색상 테마 추가

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
            'assets/logo.png',
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
      body: SingleChildScrollView(
        // 스크롤 가능한 화면을 위해 SingleChildScrollView를 사용
        child: Column(
          mainAxisSize: MainAxisSize.min, // 내용의 크기에 맞게 Column을 조정
          children: [
            Container(
              height: MediaQuery.of(context).size.height, // 화면의 높이를 채우도록 설정
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/home_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
