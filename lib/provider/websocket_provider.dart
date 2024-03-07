/*import 'package:web_socket_channel/io.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class WebSocketProvider extends ChangeNotifier {
  IOWebSocketChannel? channel;
  Timer? disconnectTimer;
  final Duration inActiveDuration =
      const Duration(seconds: 600); // Adjust this duration

  bool _isConnected = false;

  bool get isConnected => _isConnected;

  void connect() {
    channel = IOWebSocketChannel.connect('ws://127.0.0.1:8000/chatbot');
    _isConnected = true;
    resetTimer();
    notifyListeners();
  }

  void disconnect() {
    channel?.sink.close();
    channel = null;
    _isConnected = false;
    disconnectTimer?.cancel();
    notifyListeners();
  }

  void resetTimer() {
    disconnectTimer?.cancel();
    disconnectTimer =
        Timer(inActiveDuration, disconnect); // Schedule disconnection
  }
}
*/