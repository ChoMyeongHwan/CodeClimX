// 질문
import 'package:flutter/material.dart';

class QuestionListTile extends StatefulWidget {
  const QuestionListTile({super.key});

  @override
  State<QuestionListTile> createState() => _QuestionListTileState();
}

String selectedButtonText = 'All';
int answersCount = 0;
bool aiStatus = true;
String question = 'CSS의 가상 클래스와 가상 요소';

class _QuestionListTileState extends State<QuestionListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < 3; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: i % 2 == 0
                    ? const Color(0xFFE7E2FF)
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
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5), // 좌측에 10의 패딩 추가
                            child: Text(
                              question,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(), // 제목과 답변 사이에 공간을 채우기 위해 Spacer 추가
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, bottom: 5), // 좌측과 상단에 각각 10의 패딩 추가
                            child: Text(
                              '답변 $answersCount', // answersCount는 동적으로 바뀌는 답변의 숫자입니다.
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // aiStatus가 true일 때만 AI 컨테이너를 보여줍니다.
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Visibility(
                            visible: aiStatus, // aiStatus는 boolean 타입이어야 합니다.
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Frontend',
                                    style: TextStyle(
                                      color: Color(0xFF6E41E2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 22.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6E41E2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '2분 전',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
