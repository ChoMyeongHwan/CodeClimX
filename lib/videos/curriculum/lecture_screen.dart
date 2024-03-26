import 'package:codeclimx/common/widget/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LectureScreen extends StatefulWidget {
  final String _videoUrl;
  final String _videoTitle;
  final int _timestamp;
  final String _detail;

  const LectureScreen(
      this._videoUrl, this._videoTitle, this._timestamp, this._detail,
      {super.key});

  @override
  State<LectureScreen> createState() =>
      _LectureScreenState(_videoUrl, _videoTitle, _timestamp, _detail);
}

class _LectureScreenState extends State<LectureScreen> {
  final String _videoUrl;
  final String _videoTitle;
  final int _timestamp;
  final String _detail;

  _LectureScreenState(
      this._videoUrl, this._videoTitle, this._timestamp, this._detail);

  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(_videoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        startAt: (_timestamp),
      ),
    )..addListener(() {
        // 컨트롤러 리스너 추가
        if (_isFullScreen != _controller.value.isFullScreen) {
          // 전체 화면 상태가 변경되면 상태 업데이트
          setState(() {
            _isFullScreen = _controller.value.isFullScreen;
          });
        }
      });

    super.initState();
  }

  void _onHomeTap(BuildContext context) {
    // 수정된 부분: GoRouter를 사용하여 홈 화면으로 이동
    GoRouter.of(context).go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null
          : AppBar(
              // 전체 화면일 때 앱 바 숨김
              centerTitle: true,
              title: Text(widget._videoTitle),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () => _onHomeTap(context),
                ),
              ],
            ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // YoutubePlayer를 AspectRatio 위젯으로 감쌉니다
            AspectRatio(
              aspectRatio: 16 / 9, // 표준 YouTube 비디오 종횡비
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () => debugPrint('Ready'),
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,
                    colors: const ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),
                  ),
                  FullScreenButton(
                    controller: _controller,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget._detail,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _isFullScreen
          ? null
          : const CustomBottomNavbar(
              currentIndex: 1,
            ),
    );
  }
}
