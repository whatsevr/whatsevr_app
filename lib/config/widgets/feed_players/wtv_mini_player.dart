import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

class WTVMiniPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnail;
  final Function()? onTapFreeArea;
  final bool? loopVideo;
  final double? thumbnailHeightAspectRatio;
  const WTVMiniPlayer({
    super.key,
    required this.videoUrl,
    this.thumbnail,
    this.onTapFreeArea,
    this.loopVideo,
    this.thumbnailHeightAspectRatio,
  });

  @override
  State<WTVMiniPlayer> createState() => _WTVMiniPlayerState();
}

class _WTVMiniPlayerState extends State<WTVMiniPlayer> {
  CachedVideoPlayerPlusController? videoPlayerController;
  @override
  void initState() {
    super.initState();
    initiateVideoPlayer();
  }

  Future<void> initiateVideoPlayer() async {
    final String adaptiveVideoUrl = generateOptimizedCloudinaryVideoUrl(
      originalUrl: widget.videoUrl!,
      quality: 30,
    );
    videoPlayerController ??= CachedVideoPlayerPlusController.networkUrl(
      Uri.parse(adaptiveVideoUrl),invalidateCacheIfOlderThan: const Duration(days: 90),
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
    );
    await videoPlayerController!.initialize();
    videoPlayerController!.setLooping(widget.loopVideo ?? false);
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.videoUrl}'),
      onVisibilityChanged: (VisibilityInfo info) {
        final visibleFraction = info.visibleFraction;

        if (visibleFraction < 0.1 &&
            videoPlayerController?.value.isPlaying == true) {
          videoPlayerController?.pause();
          setState(() {});
        }
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (videoPlayerController?.value.isPlaying == true) {
                    videoPlayerController?.pause();
                    setState(() {});
                  } else {
                    videoPlayerController?.pause();
                    setState(() {});
                    widget.onTapFreeArea?.call();
                  }
                },
                child: Builder(
                  builder: (BuildContext context) {
                    if (videoPlayerController?.value.isInitialized != true ||
                        videoPlayerController?.value.isPlaying != true) {
                      return AspectRatio(
                        aspectRatio: widget.thumbnailHeightAspectRatio ??
                            WhatsevrAspectRatio.landscape.ratio,
                        child: ExtendedImage.network(
                          widget.thumbnail ??
                              MockData.imagePlaceholder('Thumbnail'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          enableLoadState: false,
                        ),
                      );
                    }
                    return AspectRatio(
                        aspectRatio: videoPlayerController?.value.aspectRatio ??
                            WhatsevrAspectRatio.landscape.ratio,
                        child: CachedVideoPlayerPlus(videoPlayerController!),);
                  },
                ),
              ),
              if (videoPlayerController?.value.isPlaying != true)
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.black.withOpacity(0.3)),
                  ),
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 45,
                  ),
                  onPressed: () async {
                    setState(() {
                      if (videoPlayerController?.value.isPlaying == true) {
                        videoPlayerController?.pause();
                        setState(() {});
                      } else {
                        videoPlayerController?.play();
                        setState(() {});
                      }
                    });
                  },
                ),
              if (videoPlayerController?.value.isPlaying == true) ...<Widget>[
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          videoPlayerController!.seekTo(
                            videoPlayerController!.value.position -
                                const Duration(seconds: 20),
                          );
                        },
                        icon: Icon(
                          Icons.fast_rewind,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      //fast forward
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          videoPlayerController!.seekTo(
                            videoPlayerController!.value.position +
                                const Duration(seconds: 20),
                          );
                        },
                        icon: Icon(
                          Icons.fast_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),

                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          setState(() {
                            if (videoPlayerController!.value.volume == 0) {
                              videoPlayerController!.setVolume(1);
                            } else {
                              videoPlayerController!.setVolume(0);
                            }
                          });
                        },
                        icon: Icon(
                          videoPlayerController?.value.volume == 0
                              ? Icons.volume_off
                              : Icons.volume_up,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          //linear progress bar
          if (videoPlayerController?.value.isPlaying == true)
            VideoProgressIndicator(
              videoPlayerController!,
              allowScrubbing: true,
              padding: EdgeInsets.zero,
              colors: VideoProgressColors(
                playedColor: Colors.red,
                bufferedColor: Colors.red.withOpacity(0.5),
                backgroundColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
