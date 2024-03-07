import 'package:codeclimx/chatbot/components/chatbot_widget.dart';
import 'package:codeclimx/videos/authentication/repos/authentication_repo.dart';
import 'package:codeclimx/websocket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = 'home';
  static const String routeURL = '/home';

  const HomeScreen({
    super.key,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final channel = ref.watch(webSocketChannelProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authRepo).signOut();
              context.go("/");
            },
          ),
        ],
      ),
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
