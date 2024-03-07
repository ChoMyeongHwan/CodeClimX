import 'package:codeclimx/chatbot/components/chatbot_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ChatBotWidget(),
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
