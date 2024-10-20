import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/slider.dart';

showVideoPreviewDialog({BuildContext? context, String? videoUrl}) {
  if (videoUrl == null) return;
  context ??= AppNavigationService.currentContext!;
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return _VideoPreviewer(videoUrl: videoUrl);
    },
  );
}

class _VideoPreviewer extends StatefulWidget {
  final String videoUrl;

  const _VideoPreviewer({
    super.key,
    required this.videoUrl,
  });

  @override
  __VideoPreviewerState createState() => __VideoPreviewerState();
}

class __VideoPreviewerState extends State<_VideoPreviewer> {
  late final CachedVideoPlayerPlusController _controller;
  bool showControls = true;
  bool isMuted = false;
  double volume = 1.0;
  double playbackSpeed = 1.0;
  double brightness = 1.0;

  @override
  void initState() {
    super.initState();
    _controller =
        CachedVideoPlayerPlusController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            _controller.play();
            if (mounted) {
              setState(() {});
            }
            if (!_controller.value.aspectRatio.isAspectRatioPortrait) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
            }
          });
    _controller.addListener(_onVideoStateChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoStateChanged);
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void _onVideoStateChanged() {
    if (_controller.value.position == _controller.value.duration) {
      setState(() {
        // Ensure the play button animates to the pause state
      });
    }
  }

  void toggleControls() {
    setState(() {
      showControls = !showControls;
    });
  }

  void skipBy(int seconds) {
    if (_controller.value.isInitialized) {
      final newPosition =
          Duration(seconds: _controller.value.position.inSeconds + seconds);
      _controller.seekTo(newPosition);
    }
  }

  void toggleMute() {
    setState(() {
      isMuted = !isMuted;
      _controller.setVolume(isMuted ? 0 : volume);
    });
  }

  void changeVolume(double newVolume) {
    setState(() {
      volume = newVolume;
      _controller.setVolume(volume);
    });
  }

  void changePlaybackSpeed(double newSpeed) {
    setState(() {
      playbackSpeed = newSpeed;
      _controller.setPlaybackSpeed(playbackSpeed);
    });
  }

  void changeBrightness(double newBrightness) {
    setState(() {
      brightness = newBrightness;
      ScreenBrightness().setApplicationScreenBrightness(brightness);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: 'Video Preview'),
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
                children: [
                  GestureDetector(
                    onTap: toggleControls,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CachedVideoPlayerPlus(_controller),
                    ),
                  ),
                  if (showControls) ...[
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              backgroundColor: Colors.grey,
                              bufferedColor: Colors.white24,
                              playedColor: Colors.red,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton(
                                child: Icon(
                                  CupertinoIcons.gobackward_10,
                                  color: CupertinoColors.white,
                                ),
                                onPressed: () => skipBy(-10),
                              ),
                              CupertinoButton(
                                child: Icon(
                                  _controller.value.isPlaying
                                      ? CupertinoIcons.pause
                                      : CupertinoIcons.play_arrow_solid,
                                  color: CupertinoColors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                              ),
                              CupertinoButton(
                                child: Icon(
                                  CupertinoIcons.goforward_10,
                                  color: CupertinoColors.white,
                                ),
                                onPressed: () => skipBy(10),
                              ),
                              CupertinoButton(
                                child: Icon(
                                  CupertinoIcons.speedometer,
                                  color: CupertinoColors.white,
                                ),
                                onPressed: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      title: Text('Playback Speed'),
                                      actions: [
                                        CupertinoActionSheetAction(
                                          child: Text('0.5x'),
                                          onPressed: () {
                                            changePlaybackSpeed(0.5);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('1.0x'),
                                          onPressed: () {
                                            changePlaybackSpeed(1.0);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('1.5x'),
                                          onPressed: () {
                                            changePlaybackSpeed(1.5);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('2.0x'),
                                          onPressed: () {
                                            changePlaybackSpeed(2.0);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        child: Text('Cancel'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 0,
                      top: 0,
                      child: WhatsevrVideoPlayerSlider(
                        value: volume,
                        min: 0,
                        max: 1,
                        onChanged: changeVolume,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 0,
                      top: 0,
                      child: WhatsevrVideoPlayerSlider(
                        value: brightness,
                        min: 0,
                        max: 1,
                        onChanged: changeBrightness,
                      ),
                    ),
                  ],
                ],
              )
            : WhatsevrLoadingIndicator(),
      ),
    );
  }
}
