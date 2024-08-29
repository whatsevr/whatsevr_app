import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/src/features/flicks/views/widgets/player.dart';

import 'package:whatsevr_app/config/widgets/animated_like_icon_button.dart';

class FlicksPage extends StatelessWidget {
  const FlicksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: MockData.portraitVideos.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
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
                    children: <Widget>[
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
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
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(MockData.imageAvatar),
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Username'),
                                    Text('Caption'),
                                  ],
                                ),
                              ),
                              const Icon(Icons.more_vert),
                            ],
                          ),
                          const Gap(8),
                          Row(children: <Widget>[
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
                          ],),
                        ],
                      ),
                      const Gap(16),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
