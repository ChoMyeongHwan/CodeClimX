import 'package:codeclimx/quiz/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String selCategorie = 'All';
  String selLanguage = 'Python';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '질문 작성',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // 이미지를 표시하는 SizedBox
              width: MediaQuery.of(context).size.width,
              height: 113,
              child: Image.asset(
                'assets/banner.png',
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 45, top: 20, right: 45),
              child: Row(
                children: [
                  Text(
                    'Categorie',
                    style: TextStyle(
                      color: Color(0xFF464646),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 85),
                  Text(
                    'Language',
                    style: TextStyle(
                      color: Color(0xFF464646),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        // InputDecoration을 통해 드롭다운의 외형을 조정합니다.
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFF3E5F5)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFCAC0FF),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                      ),
                      value: selCategorie,
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                        color: Color(0xFF7B5FDA),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (String? newValue2) {
                        // `String` 대신 `String?` 타입으로 변경
                        setState(() {
                          if (newValue2 != null) {
                            selCategorie =
                                newValue2; // 새로운 값이 null이 아닐 때만 상태 업데이트
                          }
                        });
                      },
                      items: <String>[
                        'All',
                        'Full stack',
                        'Frontend',
                        'Backend',
                        'AI',
                        'Data science',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 16), // 드롭다운 버튼 사이에 간격 추가
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        // InputDecoration을 통해 드롭다운의 외형을 조정합니다.
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFF3E5F5)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFFFDF60),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                      ),
                      value: selLanguage,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF464646),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                        color: Color(0xFF7B5FDA),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (String? newValue) {
                        // `String` 대신 `String?` 타입으로 변경
                        setState(() {
                          if (newValue != null) {
                            selLanguage =
                                newValue; // 새로운 값이 null이 아닐 때만 상태 업데이트
                          }
                        });
                      },
                      items: <String>[
                        'Python',
                        'JavaScript',
                        'Java',
                        'C#',
                        'C++',
                        'PHP',
                        'Swift',
                        'TypeScript',
                        'Ruby',
                        'Go',
                        'Kotlin',
                        'Rust',
                        'MATLAB',
                        'R',
                        'Objective-C',
                        'Dart',
                        'Perl',
                        'SQL',
                        'Lua',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            //다른 위젯들..
            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(10.0), // 보라색 박스의 둥근 모서리 설정
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 그림자 색상과 투명도 설정
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3), // 그림자의 위치 조정
                    ),
                  ],
                  color: const Color(0xFFCAC0FF), // 보라색 박스의 배경색 설정
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10.0), // 흰색 박스의 둥근 모서리 설정
                      color: Colors.white, // 흰색 박스의 배경색 설정
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            hintText: '제목 (필수)',
                          ),
                        ),
                        SizedBox(height: 8.0),
                        SingleChildScrollView(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  '\n궁금한 내용을 질문해 주세요. \n\n- 답변이 등록되면 질문 수정/삭제가 불가합니다. \n- 질문 내용에 개인정보가 포함되지 않게 해주세요. \n- 피해를 입으셨다면, 서비스에 신고, 112 또는 사이버경찰청으로 신고 부탁드립니다.',
                            ),
                            maxLines: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // 수평 방향으로 우측 정렬
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 45),
                    child: Container(
                      width: 200, // 버튼의 가로 길이 설정
                      height: 50, // 버튼의 세로 길이 설정
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25), // 둥근 모서리 설정
                        color: const Color.fromARGB(
                            255, 166, 148, 255), // 보라색 배경색 설정
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 4), // 그림자의 위치 조정
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          // 버튼을 눌렀을 때 실행될 기능
                        },
                        child: TextButton(
                          onPressed: () {
                            // 버튼을 눌렀을 때 실행될 기능
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   '+image', // 버튼에 표시될 텍스트 설정
                              //   style: TextStyle(
                              //     color: Colors.white, // 흰색 텍스트 색상 설정
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.bold, // 텍스트 크기 설정
                              //   ),
                              // ),
                              Icon(
                                Icons.add_photo_alternate_outlined, // 추가할 아이콘
                                color: Colors.white, // 아이콘 색상 설정
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 4), // 그림자의 위치 조정
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFFE7E2FF),
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          // 버튼을 눌렀을 때 실행될 기능
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(
        currentIndex: 3,
      ),
    );
  }
}
