import 'package:codeclimx/chatbot/components/chatbot_widget.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class HomeScreen extends StatefulWidget {
  final IOWebSocketChannel channel;
  const HomeScreen({super.key, required this.channel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ChatBotWidget(channel: widget.channel),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Other widgets can be added here as children of the Column
            Icon(
              Icons.code,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
