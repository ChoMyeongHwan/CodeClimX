import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:codeclimx/chatbot/pages/chatbot_page.dart';

class ChatBotWidget extends StatelessWidget {
  final IOWebSocketChannel channel;

  const ChatBotWidget({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatbotPage(
                  channel: channel)), // Pass the channel to the ChatbotPage
        );
      },
      backgroundColor: Colors.purple[400],
      child: const Icon(Icons.message),
    );
  }
}
