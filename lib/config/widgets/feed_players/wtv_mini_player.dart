import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';

import 'package:whatsevr_app/config/routes/router.dart';

import '../../../src/features/full_video_player/views/page.dart';

class WTVMiniPlayer extends StatefulWidget {
  final bool autoPlay;

  final String? videoUrl;
  final String? thumbnail;
  final Function()? onTapFreeArea;
  final bool? loopVideo;
  final bool showFullScreenButton;
  const WTVMiniPlayer({
    super.key,
    this.autoPlay = false,
    required this.videoUrl,
    this.thumbnail,
    this.onTapFreeArea,
    this.loopVideo,
    this.showFullScreenButton = true,
  });

  @override
  State<WTVMiniPlayer> createState() => _WTVMiniPlayerState();
}

class _WTVMiniPlayerState extends State<WTVMiniPlayer> {
  VideoPlayerController? controller;
  @override
  void initState() {
    super.initState();
    if (widget.autoPlay) {
      initiateVideoPlayer();
    }
  }

  Future<void> initiateVideoPlayer() async {
    controller ??=
        VideoPlayerController.networkUrl(Uri.parse('${widget.videoUrl}'))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            controller?.play();
            setState(() {});
            controller?.addListener(() async {
              if (controller?.value.position == controller?.value.duration) {
                await Future<void>.delayed(const Duration(seconds: 1));
                controller?.seekTo(Duration.zero);
                if (widget.loopVideo == true) {
                  controller?.play();
                } else {
                  controller?.pause();
                  controller = null;
                }
                setState(() {});
              }
            });
          });
  }

  @override
  void dispose() {
    controller?.dispose();
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
              widget.onTapFreeArea?.call();
              if (controller != null) {
                controller?.pause();
                controller = null;
                setState(() {});
              }
            }
          },
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Builder(
              builder: (BuildContext context) {
                if (controller == null) {
                  return ExtendedImage.network(
                    widget.thumbnail ?? MockData.imagePlaceholder('Thumbnail'),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    enableLoadState: false,
                  );
                }
                return VideoPlayer(controller!);
              },
            ),
          ),
        ),
        if (controller?.value.isPlaying != true)
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
                if (controller?.value.isPlaying == true) {
                  controller?.pause();
                } else {
                  controller?.play();
                }
              });
            },
          ),
        if (controller?.value.isPlaying == true) ...<Widget>[
          Positioned(
            top: 2,
            right: 2,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (controller!.value.volume == 0) {
                        controller!.setVolume(1);
                      } else {
                        controller!.setVolume(0);
                      }
                    });
                  },
                  icon: Icon(
                    controller?.value.volume == 0
                        ? Icons.volume_off
                        : Icons.volume_up,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          if (widget.showFullScreenButton)
            Positioned(
              bottom: 2,
              right: 2,
              child: IconButton(
                icon: const Icon(Icons.fullscreen),
                color: Colors.white,
                onPressed: () {
                  AppNavigationService.newRoute(
                    RoutesName.fullVideoPlayer,
                    extras: FullVideoPlayerPageArguments(
                      videoPlayerController: controller!,
                      videoUrl: widget.videoUrl!,
                    ),
                  );
                },
              ),
            ),
        ],
      ],
    );
  }
}
