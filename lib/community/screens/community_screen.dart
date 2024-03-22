import 'package:codeclimx/common/widget/custom_bottom_navbar.dart';
import 'package:codeclimx/community/screens/question_screen.dart';
import 'package:codeclimx/community/widgets/category_button.dart';
import 'package:codeclimx/community/widgets/question_list_tile.dart';
import 'package:flutter/material.dart';
import '../../common/themes/app_colors.dart' as app_colors;

class CommunityScreen extends StatelessWidget {
  static const String routeName = "community";
  static const String routeURL = "/community";

  const CommunityScreen({super.key});

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
          '커뮤니티',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(
                20.0,
                16.0,
                16.0,
                3.0,
              ),
              child: Text(
                'Best Question',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A5A5A),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      right: 15.0,
                      bottom: 10,
                    ),
                    width: 200,
                    child: Card(
                      elevation: 20.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: index.isEven
                              ? const Color(0xFFFFDF60)
                              : const Color(0xFF52B0E5),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 15.0,
                                  top: 10.0,
                                  right: 10.0,
                                ),
                                child: Text(
                                  'Q.질문 클래스와 인터페이스의 차이는 무엇인가요?',
                                  style: TextStyle(
                                    color: Color(0xFF464646),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5.0,
                              right: 10.0,
                              child: Text(
                                '확인',
                                style: TextStyle(
                                  color: index.isEven
                                      ? const Color(0xFF7B5FDA)
                                      : const Color(0xFFF6AE21),
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 113,
              child: Image.asset(
                'assets/banner.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Column(
              children: [
                CategoryButton(),
                QuestionListTitle(),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(
        currentIndex: 3,
      ),
      floatingActionButton: FloatingActionButton(
        //글쓰기 버튼
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuestionScreen()),
          );
        },
        backgroundColor: app_colors.iconColor,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
