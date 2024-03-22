import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home'); // 'HomeScreen.routeURL' 사용 가능
            break;
          case 1:
            context.go('/roadmap');
            break;
          case 2:
            context.go('/quiz');
            break;
          case 3:
            context.go('/community');
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.videocam),
          label: '동영상',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz),
          label: '퀴즈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.border_color_outlined),
          label: '커뮤니티',
        ),
      ],
    );
  }
}
