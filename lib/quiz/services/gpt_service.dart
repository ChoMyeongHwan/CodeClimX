import 'dart:convert';
import '../../utils/config.dart';
import 'package:http/http.dart' as http;

class GPTService {
  final String? apiKey = Config.apiKey;
  final String apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> getResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4-turbo-preview',
          'messages': [
            {
              'role': 'system',
              'content': '당신은 IT 관련 사용자 답변에 따른 피드백을 주는 모델입니다.'
            },
            {
              'role': 'user',
              'content': '$prompt : 핵심 요약해서 문자열로 사용자 답변에 대한 피드백을 300자 이내로 주세요\n'
                  '형식은 "피드백: 피드백 내용" 으로 주세요'
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final decodedData = utf8.decode(response.bodyBytes);
        final data = jsonDecode(decodedData);
        print('--------> 피드백 : ${data['choices'][0]['message']['content']}');
        return data['choices'][0]['message']['content'] ??
            'Empty response'; // Null이면 대체 텍스트 제공
      } else {
        throw 'Error: Invalid response';
      }
    } catch (e) {
      // 어떤 유형의 오류든지 catch 합니다.
      print('오류 발생: $e');
      return 'Error: $e'; // 여기서 null을 반환하면 안 되며, 오류 메시지를 문자열로 반환해야 합니다.
    }
  }
}
