import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../utils/config.dart';

Future<String> fetchChatGptResponse(String userInput, String docId) async {
  String? apiKey = Config.apiKey;
  final uri = Uri.parse('https://api.openai.com/v1/chat/completions');

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  final body = jsonEncode({
    "model": "gpt-4-turbo-preview",
    "messages": [
      {
        "role": "system",
        "content":
            "넌 한국인 개발자용 학습 앱 커뮤니티에서 사용자들의 질문에 답해주는 AI 로봇이야. 개발 관련 외의 질문을 받으면 \"주제에 어긋나지 않는 질문만 해주시기 바랍니다.\" 말해줘. 또 보는 사람이 기분 나쁠만한 언어를 사용했다고 판단되면 \"부적절\"이라고만 답해줘."
      },
      {
        "role": "user",
        "content": userInput // 사용자 입력을 동적으로 처리합니다.
      }
    ],
    "temperature": 1,
    "max_tokens": 4095,
    "top_p": 1,
    "frequency_penalty": 0,
    "presence_penalty": 0
  });

  final response = await http.post(uri, headers: headers, body: body);

  if (response.statusCode == 200) {
    // final answer = utf8.decode(response.bodyBytes);
    // UTF-8로 디코드합니다.
    final decodedResponse = utf8.decode(response.bodyBytes);
    final jsonResponse = json.decode(decodedResponse);

    // 'content' 필드의 값을 추출합니다.
    final answerContent = jsonResponse['choices'][0]['message']['content'];

    // Firestore에 answer 저장
    await FirebaseFirestore.instance.collection('community_answer').add({
      'id': 'AI',
      'answer': answerContent,
      'question_id': docId,
    });

    await FirebaseFirestore.instance
        .collection('community_question')
        .doc(docId)
        .update({
      'aiStatus': true,
    });

    return answerContent; // 또는 필요에 따라 가공하여 반환
  } else {
    throw Exception('Failed to load response: ${response.body}');
  }
  // if (response.statusCode == 200) {
  //   final jsonResponse = json.decode(response.body);
  //   final gptText = jsonResponse['choices'][0]['text']; // GPT 응답 추출
  //   return gptText;
  // } else {
  //   throw Exception('Failed to load response: ${response.body}');
  // }
}
