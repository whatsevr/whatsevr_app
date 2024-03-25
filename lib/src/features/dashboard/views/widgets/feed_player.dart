import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';

class WTVFeedPlayer extends StatefulWidget {
  final String? videoUrl;
  const WTVFeedPlayer({
    super.key,
    required this.videoUrl,
  });

  @override
  State<WTVFeedPlayer> createState() => _WTVFeedPlayerState();
}

class _WTVFeedPlayerState extends State<WTVFeedPlayer> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse('${widget.videoUrl}'))
      ..initialize().then((_) {
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
      children: [
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
            aspectRatio: 16 / 9,
            child: Builder(
              builder: (context) {

                if (controller.value.position == Duration.zero && !controller.value.isPlaying) {
                  return ExtendedImage.network(
                    MockData.imagePlaceholderLandscape,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  );
                }
                return VideoPlayer(controller);
              },
            ),
          ),
        ),
        if (!controller.value.isPlaying)
          IconButton(
            icon: const Icon(
              Icons.play_arrow,
              size: 80,
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
        Positioned(
          top: 8,
          right: 8,
          child: Row(
            children: [
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
                    controller.value.volume == 0 ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Gap(8),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('CC', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
