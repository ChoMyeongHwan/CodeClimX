import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LectureScreen extends StatefulWidget {
  final String _videoUrl;
  final String _videoTitle;
  final int _timestamp;

  const LectureScreen(this._videoUrl, this._videoTitle, this._timestamp,
      {super.key});

  @override
  State<LectureScreen> createState() =>
      _LectureScreenState(_videoUrl, _videoTitle, _timestamp);

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

  _LectureScreenState(this._videoUrl, this._videoTitle, this._timestamp);

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

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(title: Text(_videoTitle)),
      body: Column(
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
          )
        ],
      ),
    );
  }
}
