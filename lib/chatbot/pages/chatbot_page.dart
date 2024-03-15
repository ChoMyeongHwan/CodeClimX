import 'package:flutter/material.dart';
import 'dart:async'; // Import dart:async to use StreamSubscription
import 'package:web_socket_channel/web_socket_channel.dart'; // Import the WebSocket library

class ChatMessage {
  String text;
  bool isSentByMe;

  ChatMessage({required this.text, required this.isSentByMe});
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late WebSocketChannel channel; // Declare a WebSocketChannel
  StreamSubscription?
      _messageSubscription; // For managing the stream subscription

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse(
        'ws://192.168.0.255:8001/chatbot')); // Connect to your WebSocket server

    _messageSubscription = channel.stream.listen((message) {
      if (mounted) {
        setState(() {
          _messages.insert(0, ChatMessage(text: message, isSentByMe: false));
        });
      }
    });
  }

  @override
  void dispose() {
    _messageSubscription?.cancel(); // Cancel the stream subscription
    channel.sink.close(); // Close the WebSocket connection
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      channel.sink.add(text); // Send message to the WebSocket server
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: text,
            isSentByMe: true,
          ),
        );
      });
      _textController.clear();
    }
  }

  Widget _buildMessage(ChatMessage message, BuildContext context) {
    final alignment =
        message.isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color =
        message.isSentByMe ? Colors.deepPurple : Colors.deepPurple[50];
    final textColor = message.isSentByMe ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            message.text,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textController,
                decoration:
                    const InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true, // Newest messages at the bottom
              itemBuilder: (_, int index) =>
                  _buildMessage(_messages[index], context),
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}


/*import 'package:codeclimx/provider/websocket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage {
  String text;
  bool isSentByMe;

  ChatMessage({required this.text, required this.isSentByMe});
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();

  WebSocketProvider? _provider; // Declare _provider here

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider = Provider.of<WebSocketProvider>(context, listen: false);
      _provider?.connect();
      _provider?.channel?.stream.listen((message) {
        if (mounted) {
          setState(() {
            _messages.insert(0, ChatMessage(text: message, isSentByMe: false));
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _provider?.disconnect(); // Access _provider here
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      final provider = Provider.of<WebSocketProvider>(context, listen: false);
      provider.channel?.sink.add(text);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _messages.insert(
              0,
              ChatMessage(
                text: text,
                isSentByMe: true,
              ),
            );
          });
        }
      });
      _textController.clear();
    }
  }

  Widget _buildMessage(ChatMessage message, BuildContext context) {
    final alignment =
        message.isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color =
        message.isSentByMe ? Colors.deepPurple : Colors.deepPurple[50];
    final textColor = message.isSentByMe ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            message.text,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textController,
                decoration:
                    const InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true, // Newest messages at the bottom
              itemBuilder: (_, int index) =>
                  _buildMessage(_messages[index], context),
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}
*/