import 'package:codeclimx/firebase_options.dart';
import 'package:codeclimx/utils/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // api 저장된 ENV 파일
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //final channel = IOWebSocketChannel.connect('ws://127.0.0.1:8000/chatbot');

  runApp(const ProviderScope(
    // child: MyApp(channel: channel),
    child: MyApp(),
  ) // ProviderScope 추가
      );
}

// final webSocketChannelProvider = Provider<IOWebSocketChannel>((ref) {
//   // WebSocket 채널을 생성하고 반환합니다.
//   return IOWebSocketChannel.connect('ws://127.0.0.1:8000/chatbot');
//   // return IOWebSocketChannel.connect('ws://192.168.0.255:8000/chatbot');
// });

class MyApp extends ConsumerWidget {
  // final IOWebSocketChannel channel;

  const MyApp({
    super.key,
    // required this.channel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
