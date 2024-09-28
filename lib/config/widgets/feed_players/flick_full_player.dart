import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_video_player_plus/flutter_cached_video_player_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

import '../../services/file_upload.dart';

class FlicksFullPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnail;
  final Function(CachedVideoPlayerController?)? onPlayerInitialized;
  const FlicksFullPlayer(
      {super.key,
      required this.videoUrl,
      this.thumbnail,
      this.onPlayerInitialized});

  @override
  State<FlicksFullPlayer> createState() => _FlicksFullPlayerState();
}

class _FlicksFullPlayerState extends State<FlicksFullPlayer> {
  // Create a [VideoController] to handle video output from [Player].

  CachedVideoPlayerController? controller;
  @override
  void initState() {
    super.initState();
  }

  void initializePlayer() {
    if (controller?.value.isPlaying == true) {
      return;
    }
    String adaptiveVideoUrl = generateOptimizedCloudinaryVideoUrl(
      originalUrl: widget.videoUrl!,
    );
    controller =
        CachedVideoPlayerController.networkUrl(Uri.parse(adaptiveVideoUrl))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
            controller?.play();
            controller?.addListener(() {
              if (controller?.value.position == controller?.value.duration) {
                controller?.play();
              }
            });
            widget.onPlayerInitialized?.call(controller);
          });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.videoUrl}'),
      onVisibilityChanged: (VisibilityInfo info) {
        final visibleFraction = info.visibleFraction;

        if (visibleFraction == 1.0) {
          // Play the video when 100% visible
          initializePlayer();
        } else {
          // Pause the video when 60% or more is hidden
          if (mounted) controller?.pause();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                if (controller?.value.volume == 0) {
                  controller?.setVolume(1);
                } else {
                  controller?.setVolume(0);
                }
              });
            },
            child: Builder(
              builder: (BuildContext context) {
                if (controller != null &&
                    controller?.value.isInitialized == true &&
                    controller?.value.isPlaying == true) {
                  return AspectRatio(
                    aspectRatio: controller?.value.aspectRatio ??
                        WhatsevrAspectRatio.vertical9by16.ratio,
                    child: Stack(
                      children: [
                        CachedVideoPlayer(controller!),
                        if (controller?.value.volume == 0)
                          const Center(
                            child: Icon(
                              Icons.volume_off,
                              color: Colors.white54,
                              size: 48,
                            ),
                          ),
                      ],
                    ),
                  );
                }
                return Stack(
                  children: [
                    ExtendedImage.network(
                      '${widget.thumbnail}',
                      height: double.infinity,
                      fit: BoxFit.cover,
                      enableLoadState: false,
                      cache: true,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CupertinoActivityIndicator(),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
