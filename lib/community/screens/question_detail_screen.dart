import 'package:codeclimx/common/widget/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import '../../common/themes/app_colors.dart' as app_colors;
import 'package:intl/intl.dart';

class QuestionDetailScreen extends StatefulWidget {
  final String docId; // 인덱스 매개변수 정의

  const QuestionDetailScreen({super.key, required this.docId});

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetailScreen> {
  late String docId;
  String questionTitle = "css가 뭔가요?";
  String question = 'html과 어떤 관련이 있을까요??';
  String nickname = 'goog******';
  String answerNickname = 'CodeClimX';
  String userAnswer =
      'CSS는 "Cascading Style Sheets"의 약자로, 웹 페이지의 디자인을 담당하는 스타일 시트 언어입니다. 이를 통해 HTML로 구축된 웹 페이지의 레이아웃, 컬러, 폰트 크기 등 다양한 시각적 요소를 정의하고 관리할 수 있습니다. HTML과 CSS는 밀접하게 연관되어 있습니다. HTML은 웹 페이지의 구조를 담당하는 반면, CSS는 그 구조에 스타일을 적용하는 역할을 합니다. 예를 들어, HTML을 사용해 텍스트나 이미지 등의 웹 콘텐츠를 웹 페이지에 배치하고, CSS를 사용해 이러한 콘텐츠의 배경색, 마진, 폰트 속성 등을 조절하여 시각적으로 더 매력적으로 만듭니다. HTML 요소에 CSS 스타일을 적용하는 방법에는 여러 가지가 있습니다. 가장 직접적인 방법은 HTML 태그 내에 `style` 속성을 사용하는 것이며, 좀 더 체계적으로 스타일을 관리하기 위해 `<head>` 태그 안에 `<style>` 태그를 사용하거나 외부 스타일 시트 파일을 만들어 링크할 수도 있습니다. CSS를 활용하면 웹 페이지의 일관성을 유지하면서도 유지보수를 용이하게 하며 사용자 경험을 향상시킬 수 있습니다.';
  String userStatus = 'AI';
  String postDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  int like = 9283;

  bool isFavorited = true;

  @override
  void initState() {
    super.initState();
    // initState에서 widget.index 값을 가져와 index 변수에 할당합니다.
    docId = widget.docId;
  }

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
          icon: const Icon(Icons.menu, color: app_colors.iconColor, size: 30),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon:
                const Icon(Icons.person, color: app_colors.iconColor, size: 30),
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Image.asset(
            //     'assets/asdf.png',
            //     fit: BoxFit.cover,
            //   ),
            // ),
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
        currentIndex: 4,
      ),
    );
  }
}
