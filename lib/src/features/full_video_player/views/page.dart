import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class FullVideoPlayerPageArguments {
  final VideoPlayerController videoPlayerController;
  final String videoUrl;
  const FullVideoPlayerPageArguments({
    required this.videoUrl,
    required this.videoPlayerController,
  });
}

class FullVideoPlayerPage extends StatefulWidget {
  final FullVideoPlayerPageArguments pageArguments;

  const FullVideoPlayerPage({
    super.key,
    required this.pageArguments,
  });

  @override
  State<StatefulWidget> createState() {
    return _FullVideoPlayerPageState();
  }
}

class _FullVideoPlayerPageState extends State<FullVideoPlayerPage> {
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    final List<Subtitle> subtitles = <Subtitle>[];

    _chewieController = ChewieController(
      useRootNavigator: true,
      videoPlayerController: widget.pageArguments.videoPlayerController,
      autoPlay: true,
      looping: false,
      showControlsOnInitialize: true,
      allowFullScreen: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      zoomAndPan: true,
      showOptions: true,
      draggableProgressBar: true,
      startAt: const Duration(seconds: 0),
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

      additionalOptions: (BuildContext context) {
        return <OptionItem>[
          OptionItem(
            onTap: () {},
            iconData: Icons.live_tv_sharp,
            title: 'Option 1',
          ),
        ];
      },
      subtitle: Subtitles(subtitles),
      subtitleBuilder: (BuildContext context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),

      hideControlsTimer: const Duration(seconds: 3),

      // Try playing around with some of these other options:
      allowedScreenSleep: false, fullScreenByDefault: true,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.black,
        handleColor: Colors.grey,
        backgroundColor: Colors.white,
        bufferedColor: Colors.blueGrey.withOpacity(0.5),
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: _chewieController != null &&
                      _chewieController!
                          .videoPlayerController.value.isInitialized
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
