// 질문
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/question_detail_screen.dart';

class QuestionListTitle extends StatefulWidget {
  const QuestionListTitle({super.key});

  @override
  State<QuestionListTitle> createState() => _QuestionListTitleState();
}

String selectedButtonText = 'All';
int answersCount = 0;

class _QuestionListTitleState extends State<QuestionListTitle> {
  //question 제목
  List<String> questionTitles = [];
  //AI 상태
  List<bool> aiStatus = [];
  //문서id
  List<String> documentIds = [];

  //문서 수
  late int questionListLength;

  @override
  void initState() {
    super.initState();
    initializeData();
    _fetchQuestions();
  }

  Future<void> initializeData() async {
    int docLength = await countDocuments();
    setState(() {
      questionListLength = docLength;
    });
  }

  Future<void> _fetchQuestions() async {
    // Firestore에서 'community_question' 컬렉션의 문서 가져오기
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('community_question').get();

    // 가져온 각 문서의 필드 값을 리스트에 추가
    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>; // 데이터를 Map으로 캐스팅
      var title = data['title']; // 'title' 필드 값 가져오기
      var status = data['aiStatus']; // 'aiStatus' 필드 값 가져오기
      var docId = doc.id; // 문서 ID 가져오기

      if (title != null && status != null) {
        setState(() {
          // questionTitles에 title 추가
          questionTitles.add(title);
          // aiStatus에 status 추가
          aiStatus.add(status);
          // 문서 ID를 저장하는 리스트에 추가
          documentIds.add(docId);
        });
      }
    }
  }

  Future<int> countDocuments() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('community_question').get();
    int documentCount = querySnapshot.size;
    return documentCount;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            for (int i = 0; i < questionListLength; i++)
              GestureDetector(
                onTap: () {
                  int currentIndex = i; // for 루프 외부에서 i 값을 캡처
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionDetailScreen(
                        docId: documentIds[i], // 해당 박스의 인덱스 값을 전달
                      ),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                  questionTitles[i],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                                visible:
                                    aiStatus[i], // aiStatus는 boolean 타입이어야 합니다.
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'AI ',
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
              ),
          ],
        ),
      ),
    );
  }
}
