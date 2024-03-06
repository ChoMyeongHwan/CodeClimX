import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class ChatbotPage extends StatefulWidget {
  final IOWebSocketChannel channel;

  const ChatbotPage({super.key, required this.channel});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<String> _messages = []; // List to hold messages
  final TextEditingController _textController =
      TextEditingController(); // Controller for the input field

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      // Send the text to the WebSocket channel
      widget.channel.sink.add(text);

      // Clear the text field
      _textController.clear();

      // Optionally, you can add the message to the local list to display it
      setState(() {
        _messages.insert(0, text);
      });
    }
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    const InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
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
              reverse: true, // To keep the latest messages at the bottom
              itemBuilder: (_, int index) => ListTile(
                title: Text(_messages[index]),
              ),
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child:
                _buildTextComposer(), // Call to the widget builder for the text input
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}


/* listen to the response of websocket
@override
void initState() {
  super.initState();
  widget.channel.stream.listen((message) {
    setState(() {
      _messages.insert(0, message);
    });
  });
}
 */