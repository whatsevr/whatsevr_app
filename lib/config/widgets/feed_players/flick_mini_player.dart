import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';

class FlickMiniPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnail;
  const FlickMiniPlayer({
    super.key,
    required this.videoUrl,
    this.thumbnail,
  });

  @override
  State<FlickMiniPlayer> createState() => _FlickMiniPlayerState();
}

class _FlickMiniPlayerState extends State<FlickMiniPlayer> {
  late CachedVideoPlayerPlusController controller;
  @override
  void initState() {
    super.initState();
    controller = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse(
        '${widget.videoUrl}',
      ),
      invalidateCacheIfOlderThan: const Duration(days: 90),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    controller.addListener(() {
      if (controller.value.position == controller.value.duration) {
        controller.seekTo(Duration.zero);
        controller.play();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            });
          },
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: Builder(
              builder: (BuildContext context) {
                if (controller.value.position == Duration.zero &&
                    !controller.value.isPlaying) {
                  return ExtendedImage.network(
                    MockData.randomImage(),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    enableLoadState: false,
                  );
                }
                return CachedVideoPlayerPlus(controller);
              },
            ),
          ),
        ),
        if (!controller.value.isPlaying)
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
            onPressed: () {
              setState(() {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
              });
            },
          ),
        if (controller.value.isPlaying) ...<Widget>[
          Positioned(
            top: 8,
            right: 8,
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      if (controller.value.volume == 0) {
                        controller.setVolume(1);
                      } else {
                        controller.setVolume(0);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      controller.value.volume == 0
                          ? Icons.volume_off
                          : Icons.volume_up,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const Gap(8),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child:
                        const Text('CC', style: TextStyle(color: Colors.white)),
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
