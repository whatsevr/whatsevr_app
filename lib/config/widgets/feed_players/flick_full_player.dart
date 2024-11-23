import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

class FlicksFullPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnail;

  final Function(CachedVideoPlayerPlusController?)? onPlayerInitialized;
  const FlicksFullPlayer({
    super.key,
    required this.videoUrl,
    this.thumbnail,
    this.onPlayerInitialized,
  });

  @override
  State<FlicksFullPlayer> createState() => _FlicksFullPlayerState();
}

class _FlicksFullPlayerState extends State<FlicksFullPlayer> {
  // Create a [VideoController] to handle video output from [Player].

  CachedVideoPlayerPlusController? controller;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  void initializePlayer() async {
    if (controller?.value.isPlaying == true) {
      return;
    }
    final String adaptiveVideoUrl = generateOptimizedCloudinaryVideoUrl(
      originalUrl: widget.videoUrl!,
    );
    controller = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse(adaptiveVideoUrl),
      invalidateCacheIfOlderThan: const Duration(days: 90),
    );
    await controller?.initialize();
    setState(() {});
    controller?.setLooping(true);
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

        if (visibleFraction > 0.7) {
          controller?.play();
          widget.onPlayerInitialized?.call(controller);
        } else {
          controller?.pause();
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
                    controller?.value.isInitialized == true) {
                  return AspectRatio(
                    aspectRatio: controller?.value.aspectRatio ??
                        WhatsevrAspectRatio.vertical9by16.ratio,
                    child: Stack(
                      children: [
                        CachedVideoPlayerPlus(controller!),
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
                    ),
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
