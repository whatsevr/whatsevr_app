import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:iconify_flutter/icons/jam.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:video_player/video_player.dart';

import '../../../../config/mocks/mocks.dart';
import '../../../../config/widgets/pad_horizontal.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(8),
          PadHorizontal(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search),
                  const Gap(8),
                  Expanded(
                    child: AnimatedTextField(
                      animationType:
                          Animationtype.slide, // Use Animationtype.slide for Slide animations

                      decoration: InputDecoration.collapsed(
                        hintText: '',
                      ),
                      hintTexts: [
                        'Search for "Posts"',
                        'Search for "Profile"',
                        'Search for "Fliks"',
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(8),
          SizedBox(
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                Gap(8),
                for ((String label,) item in [
                  ('Wtv',),
                  ('Media',),
                  ('Trending',),
                  ('Memories',),
                  ('Live',),
                  ('Your onces',),
                ])
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.$1,
                        style: TextStyle(
                          fontWeight: item.$1 == 'Wtv' ? FontWeight.bold : null,
                        )),
                  ),
                Gap(8),
              ],
            ),
          ),
          const Gap(8),
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    WTVPlayerMini(
                      videoUrl:
                          'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2FAMPLIFIER%20x%20PUBG%20MOBILE%20MONTAGE%20(ULTRA%20HD)%20_%2069%20JOKER.mp4?alt=media&token=580b20c1-a339-4802-9c60-7379b0917ea3',
                    ),
                    const Gap(8),
                    PadHorizontal(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(MockData.imageAvatar),
                              ),
                              const Gap(8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Short Fast Video Performance Test',
                                    ),
                                    Gap(4),
                                    Text(
                                      'Lorem ipsum TV: 2.5M views | 2 days ago',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(8),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite),
                                color: Colors.red,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.comment),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {},
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.bookmark),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_vert),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Column(
                  children: [
                    WTVPlayerMini(
                      videoUrl:
                          'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2FKingdom%20of%20the%20Planet%20of%20the%20Apes%20_%20Official%20Trailer.mp4?alt=media&token=c549118a-ad29-4060-95a7-ada5db621528',
                    ),
                    const Gap(8),
                    PadHorizontal(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(MockData.imageAvatar),
                              ),
                              const Gap(8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Long Demo Video Test',
                                    ),
                                    Gap(4),
                                    Text(
                                      'Lorem ipsum TV: 2.5M views | 2 days ago',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(8),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite),
                                color: Colors.red,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.comment),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {},
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.bookmark),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_vert),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(50),
                Center(child: CircularProgressIndicator()),
                const Gap(50),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Builder(
          builder: (context) {
            List<Widget> children = [
              IconButton(
                icon: Iconify(MaterialSymbols.explore),
                onPressed: () {},
              ),
              IconButton(
                icon: Iconify(Heroicons.home_solid),
                onPressed: () {},
              ),
              IconButton(
                icon: const Iconify(Ri.heart_add_fill),
                onPressed: () {},
              ),
              IconButton(
                icon: Iconify(Pepicons.play_print),
                onPressed: () {},
              ),
              IconButton(
                icon: Iconify(Ph.chat_circle_text_fill),
                onPressed: () {},
              ),
              IconButton(
                icon: Iconify(Ic.twotone_notifications_none),
                onPressed: () {},
              ),
              IconButton(
                icon: Iconify(AkarIcons.settings_horizontal),
                onPressed: () {},
              ),
              IconButton(
                icon: Iconify(Jam.gamepad_f),
                onPressed: () {},
              ),
              IconButton(
                icon: Iconify(IconParkSolid.shop),
                onPressed: () {},
              ),
              IconButton(
                icon: Iconify(Ic.sharp_account_circle),
                onPressed: () {},
              ),
            ];
            return SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return children[index];
                },
                separatorBuilder: (context, index) {
                  return Gap(10);
                },
                itemCount: children.length,
              ),
            );
          },
        ),
      ),
    );
  }
}

class WTVPlayerMini extends StatefulWidget {
  final String? videoUrl;
  const WTVPlayerMini({
    super.key,
    required this.videoUrl,
  });

  @override
  State<WTVPlayerMini> createState() => _WTVPlayerMiniState();
}

class _WTVPlayerMiniState extends State<WTVPlayerMini> {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
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
                    if (controller.value.isPlaying) {
                      return VideoPlayer(controller);
                    }
                    return ExtendedImage.network(
                      MockData.imageLandscape,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    );
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
        ),
      ],
    );
  }
}
