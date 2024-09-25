import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';

class FlicksPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnail;
  const FlicksPlayer({super.key, required this.videoUrl, this.thumbnail});

  @override
  State<FlicksPlayer> createState() => _FlicksPlayerState();
}

class _FlicksPlayerState extends State<FlicksPlayer> {
  // Create a [VideoController] to handle video output from [Player].

  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller =
        VideoPlayerController.networkUrl(Uri.parse('${widget.videoUrl}'))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
    controller.play();
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
              if (controller.value.volume == 0) {
                controller.setVolume(1);
              } else {
                controller.setVolume(0);
              }
            });
          },
          child: Builder(
            builder: (BuildContext context) {
              if (controller.value.isPlaying) {
                return AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                );
              }
              return ExtendedImage.network(
                MockData.randomImage(),
                height: double.infinity,
                fit: BoxFit.cover,
                enableLoadState: false,
              );
            },
          ),
        ),
      ],
    );
  }
}
