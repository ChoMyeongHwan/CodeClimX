import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:codeclimx/home/home_screen.dart';

void main() {
  final channel = IOWebSocketChannel.connect('ws://127.0.0.1:8000/chatbot');
  runApp(MyApp(channel: channel));
}

class MyApp extends StatelessWidget {
  final IOWebSocketChannel channel;

  const MyApp({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(channel: channel),
      debugShowCheckedModeBanner: false,
    );
  }
}
