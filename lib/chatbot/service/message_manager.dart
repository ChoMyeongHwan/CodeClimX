import 'package:flutter/foundation.dart';

class ChatMessage {
  String text;
  bool isSentByMe;

  ChatMessage({required this.text, required this.isSentByMe});
}

class MessageManager extends ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  void addMessage(ChatMessage message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}
