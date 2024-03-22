import 'package:codeclimx/common/widget/custom_bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class QuestionDetailScreen extends StatefulWidget {
  const QuestionDetailScreen({super.key});

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetailScreen> {
  String questionTitle = "CSS의 가상 클래스와 가상 요소 달디 달디 달고 달디 달고 달디단 밤양갱";
  String question = '아래 방식으로 설명해주세요! 달디 달디 달디 달디 달고 단 밤양갱갱ㄱ액액ㅇ개개액애';
  String nickname = 'kimam******';
  String answerNickname = 'CodeClimX';
  String userAnswer =
      '가상 클래스와 가상 요소는 HTML 요소의 특정 상태나 위치에 따라 스타일을 동적으로 변경하고 다양한 디자인 요구사항을 족시키는 데 사용됩니다.';
  String userStatus = 'AI';
  String postDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  int like = 9283;

  bool isFavorited = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Questions',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.purple, size: 30),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person, color: Colors.purple, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 113,
              child: Image.asset(
                'assets/banner.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Q.',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(width: 15),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      questionTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20), // 왼쪽에 20의 패딩을 추가합니다.
              child: Align(
                alignment: Alignment.centerLeft, // 자식 위젯을 왼쪽으로 정렬합니다.
                child: Text(
                  nickname,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 113, 113, 113),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset(
                'assets/asdf.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 20), // 왼쪽에 20의 패딩을 추가합니다.
              child: Row(
                // Row 위젯을 사용하여 텍스트와 "루피"를 나란히 표시합니다.
                children: [
                  Align(
                    alignment: Alignment.centerLeft, // 자식 위젯을 왼쪽으로 정렬합니다.
                    child: Text(
                      postDate,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 113, 113, 113),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      // 색상을 조건에 따라 변경합니다.
                      color: isFavorited
                          ? Colors.grey
                          : const Color.fromARGB(255, 255, 0, 85),
                      size: 20,
                    ),
                    onPressed: () {
                      // 버튼을 누를 때마다 상태를 업데이트합니다.
                      setState(() {
                        isFavorited = !isFavorited;
                        isFavorited ? like-- : like++;
                      });
                    },
                  ),
                  Text(
                    '$like',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 113, 113, 113),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFFE7E2FF), // 프로필 이미지 배경색
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF7B5FDA),
                    ), // 기본 사용자 아이콘, 여기에 이미지를 넣을 수 있음
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '+answer', // 플레이스홀더 텍스트
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0), // 상하 간격 조절
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // 수평 방향으로 우측 정렬
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF7B5FDA),
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // 버튼을 눌렀을 때 실행될 기능
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //========================AI 답변========================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: answerNickname == 'CodeClimX'
                      ? const Color(0xFFFFDF60)
                      : const Color(0xFFE7E2FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: userStatus == 'AI'
                            ? const Color(0xFFE9E9E9)
                            : const Color(0xFFCAC0FF),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white, // 프로필 이미지 배경색
                            child: Image.asset(
                              'assets/logo.png',
                              fit: BoxFit.cover,
                            ), // 기본 사용자 아이콘, 여기에 이미지를 넣을 수 있음
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(answerNickname,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF464646),
                                      fontWeight: FontWeight.bold)),
                              const Text(
                                'AI',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF646464),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // padding: const EdgeInsets.all(25),
                      padding: const EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 35,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        userAnswer,
                        style: const TextStyle(
                          fontSize: 17,
                          height: 2.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(
        currentIndex: 3,
      ),
    );
  }
}
