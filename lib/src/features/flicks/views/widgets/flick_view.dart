import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/src/features/flicks/views/widgets/player.dart';

import '../../../../../config/mocks/mocks.dart';
import '../../../../../config/widgets/animated_like_icon_button.dart';
import '../../../../../config/widgets/pad_horizontal.dart';

class FlickPageFlickView extends StatelessWidget {
  final int index;
  const FlickPageFlickView({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        //Reels
        FlicksPlayer(
          videoUrl: MockData.portraitVideos[index],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: PadHorizontal(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedLikeIconButton(
                      size: 30,
                    ),
                    Gap(16),
                    Icon(Icons.link, size: 30),
                    Gap(16),
                    Icon(Icons.share, size: 30),
                  ],
                ),
                const Gap(16),
                Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(MockData.imageAvatar),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Username'),
                              Text('Caption'),
                            ],
                          ),
                        ),
                        const Icon(Icons.more_vert),
                      ],
                    ),
                    const Gap(8),
                    Row(children: [
                      const Gap(8),
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(MockData.imageAvatar),
                      ),
                      const Gap(8),
                      const Expanded(child: Text('Comment')),
                      IconButton(
                        icon: const Icon(Icons.library_music),
                        onPressed: () {},
                      ),
                    ]),
                  ],
                ),
                const Gap(16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}