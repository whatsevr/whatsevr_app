import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_video_player_plus/flutter_cached_video_player_plus.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

class WTVMiniPlayer extends StatefulWidget {
  final bool autoPlay;

  final String? videoUrl;
  final String? thumbnail;
  final Function()? onTapFreeArea;
  final bool? loopVideo;
  final double? thumbnailHeightAspectRatio;
  const WTVMiniPlayer({
    super.key,
    this.autoPlay = false,
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
  CachedVideoPlayerController? videoPlayerController;
  @override
  void initState() {
    super.initState();
    if (widget.autoPlay) {
      initiateVideoPlayer();
    }
  }

  Future<void> initiateVideoPlayer() async {
    videoPlayerController ??= CachedVideoPlayerController.networkUrl(
      Uri.parse('${widget.videoUrl}'),
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        videoPlayerController?.play();
        setState(() {});
        videoPlayerController?.addListener(() async {
          if (videoPlayerController?.value.position ==
              videoPlayerController?.value.duration) {
            if (widget.loopVideo == true) {
              await Future<void>.delayed(const Duration(seconds: 2));
              videoPlayerController?.seekTo(Duration.zero);
              videoPlayerController?.play();
            } else {
              videoPlayerController?.pause();
            }
            setState(() {});
          }
        });
      });
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (widget.onTapFreeArea != null) {
              if (videoPlayerController?.value.isInitialized == true &&
                  videoPlayerController!.value.isPlaying) {
                videoPlayerController?.pause();
                setState(() {});
              }

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
                    widget.thumbnail ?? MockData.imagePlaceholder('Thumbnail'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    enableLoadState: false,
                  ),
                );
              }
              return AspectRatio(
                  aspectRatio: videoPlayerController?.value.aspectRatio ??
                      WhatsevrAspectRatio.landscape.ratio,
                  child: CachedVideoPlayer(videoPlayerController!));
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
              await initiateVideoPlayer();
              setState(() {
                if (videoPlayerController?.value.isPlaying == true) {
                  videoPlayerController?.pause();
                } else {
                  videoPlayerController?.play();
                }
              });
            },
          ),
        if (videoPlayerController?.value.isPlaying == true) ...<Widget>[
          Positioned(
            top: 2,
            right: 2,
            child: Row(
              children: <Widget>[
                IconButton(
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
    );
  }
}
