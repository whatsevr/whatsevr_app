import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/slider.dart';
import '../../services/file_upload.dart';

import 'package:flutter/services.dart';

class WtvFullPlayer extends StatefulWidget {
  const WtvFullPlayer({
    super.key,
    required this.videoUrl,
    required this.thumbnail,
    required this.title,
    this.iconColor = Colors.white,
    this.skipVideoUptoSec = 10,
    this.videoProgressBgColor = Colors.grey,
    this.videoProgressBufferColor = Colors.white24,
    this.videoProgressPlayedColor = Colors.red,
    this.autoPlay = true,
  });

  final String? videoUrl;
  final String? thumbnail;
  final String? title;
  final Color iconColor;

  final int skipVideoUptoSec;
  final Color videoProgressBgColor;
  final Color videoProgressBufferColor;
  final Color videoProgressPlayedColor;
  final bool autoPlay;

  @override
  State<WtvFullPlayer> createState() => _WtvFullPlayerState();
}

class _WtvFullPlayerState extends State<WtvFullPlayer> {
  late CachedVideoPlayerPlusController _controller;
  bool isVideoLoading = true;
  bool showControls = false;
  bool showPlayButton = true;
  double volume = 1.0;
  double brightness = 1.0;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  void initializePlayer() async {
    if (widget.videoUrl == null) return;
    String? optimizedUrl = generateOptimizedCloudinaryVideoUrl(
      originalUrl: widget.videoUrl!,
    );
    _controller = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse(optimizedUrl),
      invalidateCacheIfOlderThan: const Duration(days: 90),
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: true,
      ),
    )..initialize().then((_) {
        setState(() {
          isVideoLoading = false;
          if (widget.autoPlay) {
            _controller.play();
            showPlayButton = false;
            showControls = true;
          }
        });
      });
    _controller.addListener(_onVideoStateChanged);
  }

  void _onVideoStateChanged() {
    if (_controller.value.position == _controller.value.duration) {
      setState(() {
        showControls = true;
      });
    }
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
    return isVideoLoading == true
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              alignment: Alignment.center,
              color: Colors.black,
              child: CupertinoActivityIndicator(),
            ),
          )
        : !_controller.value.isInitialized
            ? const SizedBox()
            : GestureDetector(
                onTap: hideControls,
                onLongPress: hideControls,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                      CachedVideoPlayerPlus(_controller),
                      Center(child: showInitialPlayButton()),
                      skipSecondsButtons(context),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          videoProgressIndicator(),
                          durationAndFullScreenButton(false)
                        ],
                      )
                    ],
                  ),
                ),
              );
  }

  Widget skipSecondsButtons(context) {
    return Center(
      child: Visibility(
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
            //play pause
            playPauseReplayButton(),
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
    );
  }

  void skipBy(int seconds) {
    if (_controller.value.isInitialized) {
      final newPosition =
          Duration(seconds: _controller.value.position.inSeconds + seconds);
      _controller.seekTo(newPosition);
    }
  }

  Widget showInitialPlayButton() {
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

  Widget videoProgressIndicator() {
    return VideoProgressIndicator(_controller,
        allowScrubbing: true,
        colors: VideoProgressColors(
            backgroundColor: widget.videoProgressBgColor,
            bufferedColor: widget.videoProgressBufferColor,
            playedColor: widget.videoProgressPlayedColor));
  }

  Widget durationAndFullScreenButton(isFullScreen) {
    return Visibility(
      visible: showControls,
      child: Row(
        children: [
          Gap(8),
          videoDuration(),
          const Spacer(),
          fullScreenButton(isFullScreen)
        ],
      ),
    );
  }

  Widget playPauseReplayButton() {
    return ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) {
          return IconButton(
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  if (_controller.value.position ==
                      _controller.value.duration) {
                    _controller.seekTo(Duration.zero);
                    _controller.play();
                  } else {
                    _controller.play();
                  }
                }
              });
            },
            icon: Icon(
              _controller.value.isPlaying
                  ? Icons.pause
                  : _controller.value.position == _controller.value.duration
                      ? Icons.replay
                      : Icons.play_arrow,
              color: widget.iconColor,
            ),
          );
        });
  }

  Widget videoDuration() {
    return ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) {
          return Text(
            '${formatDuration(_controller.value.position)} / ${formatDuration(_controller.value.duration)}',
            style: TextStyle(color: widget.iconColor, fontSize: 12),
          );
        });
  }

  Widget fullScreenButton(bool isFullScreen) {
    return IconButton(
        visualDensity: VisualDensity.compact,
        onPressed: () {
          SystemChrome.setPreferredOrientations(!isFullScreen
              ? [
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft
                ]
              : [DeviceOrientation.portraitUp]);
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
    bool showControls = true;

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
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Colors.black,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: CachedVideoPlayerPlus(_controller),
                          ),
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
                            playPauseReplayButton(),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Gap(8),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    SystemChrome.setPreferredOrientations(
                                        [DeviceOrientation.portraitUp]);
                                    SystemChrome.setEnabledSystemUIMode(
                                        SystemUiMode.edgeToEdge);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                  color: widget.iconColor,
                                ),
                                Expanded(
                                  child: Text(
                                    '${widget.title}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showAppModalSheet(
                                      context: context,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: const Icon(Icons.share),
                                            title: const Text('Share'),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.save),
                                            title: const Text('Save'),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.download),
                                            title: const Text('Download'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.more_vert),
                                  color: widget.iconColor,
                                ),
                              ],
                            ),
                            Spacer(),
                            videoProgressIndicator(),
                            Row(
                              children: [
                                Gap(8),
                                videoDuration(),
                                const Spacer(),
                                fullScreenButton(true),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Volume Slider
                      Positioned(
                        left: 6,
                        top: 0,
                        bottom: 0,
                        child: Visibility(
                          visible: showControls,
                          child: WhatsevrVideoPlayerSlider(
                            value: volume,
                            min: 0,
                            max: 1,
                            onChanged: (newVolume) {
                              setState(() {
                                volume = newVolume;
                                _controller.setVolume(volume);
                              });
                            },
                          ),
                        ),
                      ),
                      // Brightness Slider
                      Positioned(
                        right: 6,
                        top: 0,
                        bottom: 0,
                        child: Visibility(
                          visible: showControls,
                          child: WhatsevrVideoPlayerSlider(
                            value: brightness,
                            min: 0,
                            max: 1,
                            onChanged: (newBrightness) {
                              setState(() {
                                brightness = newBrightness;
                                ScreenBrightness()
                                    .setApplicationScreenBrightness(brightness);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  String formatDuration(Duration duration) {
    String hours = duration.inHours.remainder(24).toString().padLeft(2, '0');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours == "00") {
      return '$minutes:$seconds';
    } else {
      return '$hours:$minutes:$seconds';
    }
  }
}
