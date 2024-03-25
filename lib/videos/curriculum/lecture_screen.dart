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

  // @override
  // State<LectureScreen> createState() => _LectureScreenState();

  //   @override
//   LectureScreenState createState() => LectureScreenState(_videoID, _videoTitle);
// }

// class LectureScreenState extends State<LectureScreen> {
//   final String _videoID;
//   final String _videoTitle;

//   LectureScreenState(this._videoID, this._videoTitle);

//   late YoutubePlayerController _controller;
}

class _LectureScreenState extends State<LectureScreen> {
  final String _videoUrl;
  final String _videoTitle;
  final int _timestamp;
  final String _detail;

  _LectureScreenState(
      this._videoUrl, this._videoTitle, this._timestamp, this._detail);

  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(_videoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        startAt: (_timestamp),
      ),
    );

    super.initState();
  }

  void _onHomeTap(BuildContext context) {
    // 수정된 부분: GoRouter를 사용하여 홈 화면으로 이동
    GoRouter.of(context).go('/home');
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      // appBar: AppBar(title: Text(_videoTitle)),
      appBar: AppBar(
        centerTitle: true,
        title: Text(_videoTitle),
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
            YoutubePlayer(
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
                const PlaybackSpeedButton(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), // 상하좌우 여백을 줍니다.
              child: Text(
                _detail, // _detail 문자열을 화면에 출력합니다.
                style: const TextStyle(fontSize: 16), // 텍스트 스타일 지정
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const CustomBottomNavbar(
        currentIndex: 1,
      ),
    );
  }
}
