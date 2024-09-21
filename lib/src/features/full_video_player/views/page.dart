import 'package:cached_chewie_plus/cached_chewie_plus.dart';

import 'package:flutter/material.dart';

class VideoPreviewPlayerPageArguments {
  final String videoUrl;
  const VideoPreviewPlayerPageArguments({
    required this.videoUrl,
  });
}

class VideoPreviewPlayerPage extends StatefulWidget {
  final VideoPreviewPlayerPageArguments pageArguments;

  const VideoPreviewPlayerPage({
    super.key,
    required this.pageArguments,
  });

  @override
  State<StatefulWidget> createState() {
    return _VideoPreviewPlayerPageState();
  }
}

class _VideoPreviewPlayerPageState extends State<VideoPreviewPlayerPage> {
  CachedVideoPlayerController? videoPlayerController;
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
    videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = CachedVideoPlayerController.networkUrl(
      Uri.parse(widget.pageArguments.videoUrl),
    );
    await videoPlayerController!.initialize();
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      useRootNavigator: true,
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: false,
      showControlsOnInitialize: false,
      aspectRatio: videoPlayerController!.value.aspectRatio,
      allowFullScreen: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      zoomAndPan: true,

      showOptions: true,
      draggableProgressBar: true,
      startAt: const Duration(seconds: 0),
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

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
      allowedScreenSleep: false,
      fullScreenByDefault: videoPlayerController!.value.aspectRatio >= 1.0,
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
