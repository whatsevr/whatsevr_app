import 'package:cached_chewie_plus/cached_chewie_plus.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';

import '../media/aspect_ratio.dart';

class FullVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnail;
  const FullVideoPlayer({
    super.key,
    this.videoUrl,
    this.thumbnail,
  });

  @override
  State<StatefulWidget> createState() {
    return _FullVideoPlayerState();
  }
}

class _FullVideoPlayerState extends State<FullVideoPlayer> {
  CachedVideoPlayerController? videoPlayerController;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = CachedVideoPlayerController.networkUrl(
      Uri.parse('${widget.videoUrl}'),
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
    )..initialize().then((_) {
        if (mounted) {
          _createChewieController();
        }
      });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    videoPlayerController?.dispose();

    super.dispose();
  }

  void _createChewieController() {
    final List<Subtitle> subtitles = <Subtitle>[];

    _chewieController = ChewieController(
      useRootNavigator: true,
      videoPlayerController: videoPlayerController!,
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
      allowedScreenSleep: false, fullScreenByDefault: false,
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
      autoInitialize: false,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController?.videoPlayerController.value.isInitialized == true
        ? AspectRatio(
            aspectRatio: _chewieController?.videoPlayerController.value
                        .aspectRatio.isAspectRatioLandscape ==
                    true
                ? _chewieController!.videoPlayerController.value.aspectRatio
                : WhatsevrAspectRatio.square.ratio,
            child: Chewie(
              controller: _chewieController!,
            ),
          )
        : AspectRatio(
            aspectRatio: WhatsevrAspectRatio.landscape.ratio,
            child: ExtendedImage.network(
              widget.thumbnail ?? MockData.imagePlaceholder('Thumbnail'),
              width: double.infinity,
              fit: BoxFit.cover,
              enableLoadState: false,
            ),
          );
  }
}
