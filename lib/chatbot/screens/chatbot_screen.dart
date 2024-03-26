import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeclimx/chatbot/model/chat.dart';
import 'package:codeclimx/chatbot/service/database.dart';
import 'package:codeclimx/common/themes/app_colors.dart';
import 'package:codeclimx/common/widget/custom_bottom_navbar.dart';
import 'package:codeclimx/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:collection/collection.dart';

class TypingIndicator extends StatefulWidget {
  final Color color;
  final double dotSize;

  const TypingIndicator({
    super.key,
    this.color = Colors.deepPurple,
    this.dotSize = 10.0,
  });

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _animation2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
      ),
    );

    _animation3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (_animationController.status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
      setState(() {});
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AnimatedDot(
            animation: _animation1,
            dotSize: widget.dotSize,
            color: widget.color),
        SizedBox(width: widget.dotSize),
        AnimatedDot(
            animation: _animation2,
            dotSize: widget.dotSize,
            color: widget.color),
        SizedBox(width: widget.dotSize),
        AnimatedDot(
            animation: _animation3,
            dotSize: widget.dotSize,
            color: widget.color),
      ],
    );
  }
}

class AnimatedDot extends StatelessWidget {
  const AnimatedDot({
    super.key,
    required this.animation,
    required this.dotSize,
    required this.color,
  });

  final Animation<double> animation;
  final double dotSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Container(
        height: dotSize,
        width: dotSize,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class ChatMessage {
  String text;
  bool isSentByMe;
  bool isMostRecent;

  ChatMessage(
      {required this.text,
      required this.isSentByMe,
      this.isMostRecent = false});
}

class ChatbotPage extends StatefulWidget {
  static const String routeName = "chatbot";
  static const String routeURL = "/chatbot";

  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late WebSocketChannel channel;
  StreamSubscription? _messageSubscription;
  bool _isAwaitingResponse = false;

  @override
  void initState() {
    super.initState();
    channel =
        WebSocketChannel.connect(Uri.parse('ws://127.0.0.1:8000/chatbot'));

    _messageSubscription = channel.stream.listen((message) {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      final String userId = _firebaseAuth.currentUser!.uid;

      if (mounted) {
        setState(() {
          // Insert the received message at the start of the chat messages list.
          _messages.insert(0, ChatMessage(text: message, isSentByMe: false));
          _isAwaitingResponse = false;

          // Add the sent and received messages to Firestore
          // Assuming that the last message in _messages sent by the user is the one that corresponds to this received message
          ChatMessage? lastSentMessage =
              _messages.firstWhereOrNull((m) => m.isSentByMe && m.isMostRecent);
          if (lastSentMessage != null) {
            print(
                'Adding chat message to the database with the following details:');
            print('Sent Message: ${lastSentMessage.text}');
            print('Received Message: $message');
            DatabaseService().addChatMessage(
                Chat(
                    sentMessage: lastSentMessage.text, // Last sent message
                    receivedMessage: message, // New received message
                    sentTime: Timestamp
                        .now(), // You might want to store the actual sent time
                    receivedTime:
                        Timestamp.now()), // The time the message was received
                userId);

            // Mark the message as no longer most recent after saving to Firestore
            lastSentMessage.isMostRecent = false;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    channel.sink.close();
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      channel.sink.add(text);
      setState(() {
        // Mark all messages as not most recent
        for (var message in _messages) {
          message.isMostRecent = false;
        }
        // Add new message and mark it as most recent
        _messages.insert(
            0, ChatMessage(text: text, isSentByMe: true, isMostRecent: true));
        _isAwaitingResponse = true;
      });
      _textController.clear();
    }
  }

  Widget _buildMessage(ChatMessage message, BuildContext context) {
    final alignment =
        message.isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final messageColor =
        message.isSentByMe ? Colors.deepPurple : Colors.deepPurple[50];
    final textColor = message.isSentByMe ? Colors.white : Colors.black;
    final borderRadius = message.isSentByMe
        ? BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
        : BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          if (!message.isSentByMe)
            Text(
              "Xbot",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (message.isSentByMe)
            Text(
              "me",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: messageColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message.text,
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white), // Add top border
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textController,
                decoration:
                    const InputDecoration.collapsed(hintText: "Send a message"),
                onSubmitted: _handleSubmitted,
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
        title: Text(
          'X-bot',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Makes the text bold
          ),
        ),
        backgroundColor: secondaryColor,
      ),
      body: ColoredBox(
        color: secondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) =>
                    _buildMessage(_messages[index], context),
                itemCount: _messages.length,
              ),
            ),
            if (_isAwaitingResponse) // Only show one typing indicator based on the flag
              const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  // Wrap with Padding for better control
                  padding: EdgeInsets.only(left: 14.0, bottom: 8.0),
                  child: TypingIndicator(
                    dotSize: 8.0,
                  ),
                ),
              ),
            const Divider(height: 1.0),
            _buildTextComposer(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(
        currentIndex: 2,
      ),
    );
  }
}
