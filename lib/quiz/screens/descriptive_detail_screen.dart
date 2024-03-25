import 'package:flutter/material.dart';
import 'package:codeclimx/quiz/screens/descriptive_result_screen.dart';
import 'package:codeclimx/quiz/services/gpt_service.dart';
import '../models/descriptive.dart';
import '../services/firebase_service.dart';

class DescriptiveDetailScreen extends StatefulWidget {
  final String videoDocId;

  const DescriptiveDetailScreen({super.key, required this.videoDocId});

  @override
  DescriptiveDetailScreenState createState() => DescriptiveDetailScreenState();
}

class DescriptiveDetailScreenState extends State<DescriptiveDetailScreen> {
  late Future<List<Descriptive>> _descriptiveFuture;
  final List<TextEditingController> _controllers = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _descriptiveFuture = FirebaseService()
        .loadDescriptives(widget.videoDocId)
        .then((descriptives) {
      // _controllers가 아직 채워지지 않았다면 한 번만 채우도록 함.
      if (_controllers.isEmpty) {
        setState(() {
          // _controllers에 새로 할당하는 대신, 기존 리스트에 요소들을 추가.
          _controllers.addAll(
            List.generate(
              descriptives.length,
              (index) => TextEditingController(),
            ),
          );
        });
      }
      return descriptives;
    });
  }

  @override
  void dispose() {
    // 컨트롤러들을 메모리 해제
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // 제출 버튼이 눌렸을 때 호출되는 함수
  void _onSubmit() async {
    setState(() {
      isLoading = true; // 로딩 시작
    });
    final gptService = GPTService();
    List<Future<String>> responses = [];
    try {
      List<Descriptive> descriptives = await _descriptiveFuture;
      int itemCount = descriptives.length;
      List<String> userAnswers = _controllers.map((c) => c.text).toList();

      for (int i = 0; i < itemCount; i++) {
        final prompt = '질문: ${descriptives[i].question}\n'
            '힌트: ${descriptives[i].hint}\n'
            '사용자 답변: ${userAnswers[i]}';
        responses.add(gptService.getResponse(prompt).catchError((error) {
          debugPrint('Error while getting GPT-4 response: $error');
          return 'Error: $error';
        }));
      }

      final gptFeedbacks = await Future.wait(responses);

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DescriptiveResultScreen(
            descriptives: descriptives.sublist(0, itemCount),
            userAnswers: userAnswers.sublist(0, itemCount),
            gptFeedbacks: gptFeedbacks,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      // 오류 발생 시 사용자에게 알림
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('오류 발생'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: const Text('확인'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false; // 로딩 종료
        });
      }
    }
  }

  // 주관식 문항 하나를 위젯으로 만드는 함수
  Widget _buildDescriptiveItem(Descriptive descriptive, int index) {
    // 현재 인덱스에 해당하는 기존 컨트롤러를 사용
    final controller = _controllers[index];

    // 초기에는 힌트를 숨김
    bool isHintVisible = false;

    // StatefulBuilder를 사용하여 setState를 호출할 때
    // 오직 이 카드 내부의 위젯만 다시 빌드되도록 함
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(descriptive.question),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: controller,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: '답변을 입력해주세요...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // '힌트 보기'를 탭하면 힌트를 보여주거나 숨김
              ListTile(
                title: Text(
                  '힌트 보기',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                trailing: Icon(
                  isHintVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
                onTap: () {
                  // 힌트의 가시성 상태를 토글
                  setState(
                    () {
                      isHintVisible = !isHintVisible;
                    },
                  );
                },
              ),
              // AnimatedCrossFade를 사용하여 힌트의 가시성을 부드럽게 전환
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(), // 힌트가 숨겨져 있을 때 표시
                secondChild: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    descriptive.hint,
                  ), // 힌트가 보여질 때 표시
                ),
                crossFadeState: isHintVisible
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(
                  milliseconds: 300,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 위젯 트리를 구성하는 부분
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '주관식 퀴즈',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      // FutureBuilder를 사용하여 비동기 데이터를 처리
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Descriptive>>(
              future: _descriptiveFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('주관식 퀴즈가 없습니다.'));
                }
                // 데이터가 있으면, 각 문항에 대한 카드를 리스트뷰로 표시
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.1,
                  ),
                  itemBuilder: (context, index) {
                    return _buildDescriptiveItem(snapshot.data![index], index);
                  },
                );
              },
            ),
      // 제출 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : _onSubmit, // 로딩 중이면 제출 버튼을 비활성화
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
