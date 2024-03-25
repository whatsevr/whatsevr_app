import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/src/features/flicks/views/widgets/player.dart';

class FlicksPage extends StatelessWidget {
  const FlicksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: MockData.portraitVideos.length,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.bottomCenter,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.favorite, color: Colors.red, size: 30),
                          Gap(16),
                          const Icon(Icons.link, size: 30),
                          Gap(16),
                          const Icon(Icons.share, size: 30),
                        ],
                      ),
                      Gap(16),
                      Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(MockData.imageAvatar),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Username'),
                                    const Text('Caption'),
                                  ],
                                ),
                              ),
                              const Icon(Icons.more_vert),
                            ],
                          ),
                          Gap(8),
                          Row(children: [
                            Gap(8),
                            CircleAvatar(
                              radius: 10,
                              backgroundImage: NetworkImage(MockData.imageAvatar),
                            ),
                            Gap(8),
                            Expanded(child: Text('Comment')),
                            IconButton(
                              icon: const Icon(Icons.library_music),
                              onPressed: () {},
                            ),
                          ]),
                        ],
                      ),
                      Gap(16),
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
