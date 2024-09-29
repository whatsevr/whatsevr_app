import 'package:cached_chewie_plus/cached_chewie_plus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import '../../services/file_upload.dart';
import '../media/aspect_ratio.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class WtvFullPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnail;
  const WtvFullPlayer({
    super.key,
    this.videoUrl,
    this.thumbnail,
  });

  @override
  State<StatefulWidget> createState() {
    return _WtvFullPlayerState();
  }
}

class _WtvFullPlayerState extends State<WtvFullPlayer> {
  CachedVideoPlayerController? videoPlayerController;
  ChewieController? _chewieController;

  int? selectedQuality;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer({int? quality}) async {
    // if (videoPlayerController?.value.isPlaying == true) {
    //   return;
    // }

    // Generate optimized video URL based on selected quality
    String adaptiveVideoUrl = generateOptimizedCloudinaryVideoUrl(
      originalUrl: widget.videoUrl!,
      quality: quality,
    );

    videoPlayerController = CachedVideoPlayerController.networkUrl(
      Uri.parse(adaptiveVideoUrl),
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
    );
    await videoPlayerController?.initialize();
    _createChewieController();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      useRootNavigator: true,
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: false,
      showControlsOnInitialize: false,
      allowFullScreen: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      zoomAndPan: true,
      showOptions: true,
      draggableProgressBar: true,
      startAt: const Duration(seconds: 0),
      additionalOptions: (context) {
        return [
          if (false)
            OptionItem(
              title: 'Quality',
              iconData: Icons.settings,
              onTap: () {
                showAppModalSheet(
                    draggableScrollable: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Select Video Quality',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        for ((String label, int? quality) record in [
                          ('Auto', null),
                          ('Low', 20),
                          ('Normal', 60),
                          ('Max', 100),
                        ])
                          ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Text(record.$1),
                            leading: selectedQuality == record.$2
                                ? const Icon(Icons.check)
                                : null,
                            onTap: () {
                              selectedQuality = record.$2;
                              Navigator.pop(context);
                              initializePlayer(quality: selectedQuality);
                            },
                          ),
                      ],
                    ));
              },
            ),
        ];
      },
      progressIndicatorDelay: const Duration(milliseconds: 2000),
      aspectRatio: videoPlayerController!.value.aspectRatio,
      hideControlsTimer: const Duration(seconds: 3),
      allowedScreenSleep: false,
      fullScreenByDefault: false,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
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
            aspectRatio:
                _chewieController?.aspectRatio.isAspectRatioLandscapeOrSquare ==
                        true
                    ? _chewieController?.aspectRatio ??
                        WhatsevrAspectRatio.landscape.ratio
                    : WhatsevrAspectRatio.square.ratio,
            child: Chewie(
              controller: _chewieController!,
            ),
          )
        : AspectRatio(
            aspectRatio: WhatsevrAspectRatio.landscape.ratio,
            child: Stack(
              children: [
                ExtendedImage.network(
                  widget.thumbnail ?? MockData.imagePlaceholder('Thumbnail'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  enableLoadState: false,
                ),
                if (_chewieController
                        ?.videoPlayerController.value.isBuffering ==
                    true)
                  const CupertinoActivityIndicator(),
              ],
            ),
          );
  }
}

class VideoPlayerWithControls extends StatefulWidget {
  const VideoPlayerWithControls({
    super.key,
    required this.videoUrl,
    this.iconColor = Colors.white,
    this.loadingColor = Colors.red,
    this.skipVideoUptoSec = 5,
    this.videoProgressBgColor = Colors.grey,
    this.videoProgressBufferColor = Colors.white24,
    this.videoProgressPlayedColor = Colors.red,
    this.autoPlay = true,
  });
  final String videoUrl;
  final Color iconColor;
  final Color loadingColor;
  final int skipVideoUptoSec;
  final Color videoProgressBgColor;
  final Color videoProgressBufferColor;
  final Color videoProgressPlayedColor;
  final bool autoPlay;
  @override
  State<VideoPlayerWithControls> createState() =>
      _VideoPlayerWithControlsState();
}

class _VideoPlayerWithControlsState extends State<VideoPlayerWithControls> {
  late CachedVideoPlayerController _controller;
  bool isVideoLoading = true;
  bool showControls = false;
  bool showPlayButton = true;

  @override
  void initState() {
    super.initState();
    _controller =
        CachedVideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            setState(() {
              isVideoLoading = false;
              if (widget.autoPlay) {
                _controller.play();
                showPlayButton = false;
                showControls = true;
              }
            });
          });
  }

  void hideControls() {
    setState(() {
      showControls = !showControls;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: isVideoLoading == true
          ? Center(child: CircularProgressIndicator(color: widget.loadingColor))
          : !_controller.value.isInitialized
              ? const SizedBox()
              : GestureDetector(
                  onTap: hideControls,
                  onLongPress: hideControls,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                      AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: CachedVideoPlayer(_controller)),
                      skipSeconds(context),
                      showInitialPlayButton(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          videoProgressIndicator(),
                          otherControls(false)
                        ],
                      )
                    ],
                  ),
                ),
    );
  }

  skipSeconds(context) {
    return Visibility(
      visible: showControls,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                skipBy(-widget.skipVideoUptoSec);
              });
            },
            icon: const Icon(Icons.replay_10),
            color: widget.iconColor,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                skipBy(widget.skipVideoUptoSec);
              });
            },
            icon: const Icon(Icons.forward_10),
            color: widget.iconColor,
          ),
        ],
      ),
    );
  }

  skipBy(int seconds) {
    if (_controller.value.isInitialized) {
      final newPosition =
          Duration(seconds: _controller.value.position.inSeconds + seconds);
      _controller.seekTo(newPosition);
    }
  }

  showInitialPlayButton() {
    return Visibility(
      visible: showPlayButton,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              _controller.play();
              showPlayButton = false;
              // showControls = true;
            });
            hideControls();
          },
          icon: const Icon(
            Icons.play_arrow,
            size: 50.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  videoProgressIndicator() {
    return VideoProgressIndicator(_controller,
        allowScrubbing: true,
        colors: VideoProgressColors(
            backgroundColor: widget.videoProgressBgColor,
            bufferedColor: widget.videoProgressBufferColor,
            playedColor: widget.videoProgressPlayedColor));
  }

  otherControls(isFullScreen) {
    return Visibility(
      visible: showControls,
      child: Row(
        children: [
          playPauseButton(),
          videoDuration(),
          const Spacer(),
          fullScreenButton(isFullScreen)
        ],
      ),
    );
  }

  playPauseButton() {
    return ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) {
          return IconButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: widget.iconColor,
            ),
          );
        });
  }

  videoDuration() {
    return ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) {
          return Text(
            '${formatDuration(_controller.value.position)} / ${formatDuration(_controller.value.duration)}',
            style: TextStyle(color: widget.iconColor),
          );
        });
  }

  fullScreenButton(bool isFullScreen) {
    return IconButton(
        onPressed: () {
          SystemChrome.setPreferredOrientations([
            !isFullScreen
                ? DeviceOrientation.landscapeRight
                : DeviceOrientation.portraitUp
          ]);
          !isFullScreen ? goFullScreen(context) : Navigator.pop(context);
          !isFullScreen
              ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive)
              : SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          hideControls();
        },
        icon: Icon(
          Icons.fullscreen,
          color: widget.iconColor,
        ));
  }

  void goFullScreen(BuildContext context) {
    bool showControls = false;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp]);
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
              Navigator.pop(context);
              return true;
            },
            child: StatefulBuilder(builder: (context, setState) {
              return Scaffold(
                  body: GestureDetector(
                onTap: () {
                  setState(() {
                    showControls = !showControls;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.black,
                      child: Center(
                        child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: CachedVideoPlayer(_controller)),
                      ),
                    ),
                    Visibility(
                      visible: showControls,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                skipBy(-widget.skipVideoUptoSec);
                              });
                            },
                            icon: const Icon(Icons.replay_10),
                            color: widget.iconColor,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                skipBy(widget.skipVideoUptoSec);
                              });
                            },
                            icon: const Icon(Icons.forward_10),
                            color: widget.iconColor,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: showControls,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          videoProgressIndicator(),
                          Visibility(
                            visible: showControls,
                            child: Row(
                              children: [
                                playPauseButton(),
                                videoDuration(),
                                const Spacer(),
                                fullScreenButton(true)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
            }),
          );
        },
      ),
    );
  }
}

String formatDuration(Duration duration) {
  String hours = duration.inHours.remainder(24).toString().padLeft(2, '0');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

  if (hours == "00") {
    return '$minutes:$seconds';
  } else {
    return '$hours:$minutes:$seconds';
  }
}
