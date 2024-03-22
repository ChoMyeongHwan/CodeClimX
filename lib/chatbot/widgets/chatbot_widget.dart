import 'package:flutter/material.dart';
import 'package:codeclimx/chatbot/pages/chatbot_page.dart';

class ChatBotWidget extends StatelessWidget {
  const ChatBotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatbotPage()),
        );
      },
      backgroundColor: Colors.purple[400],
      child: const Icon(Icons.message),
    );
  }
}
