import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

final webSocketChannelProvider = Provider<IOWebSocketChannel>((ref) {
  // WebSocket 채널을 생성하고 반환합니다.
  return IOWebSocketChannel.connect('ws://127.0.0.1:8000/chatbot');
  // return IOWebSocketChannel.connect('ws://192.168.0.255:8000/chatbot');
});
