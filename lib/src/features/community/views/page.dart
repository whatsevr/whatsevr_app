import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

import '../../../../config/mocks/mocks.dart';
import '../../../../config/widgets/pad_horizontal.dart';
import '../../../../config/widgets/tab_bar.dart';

class CommunityPageX extends StatelessWidget {
  CommunityPageX({super.key});
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: PageView(
                        controller: controller,
                        children: <Widget>[
                          CoverVideo(videoUrl: MockData.demoVideo),
                          CoverVideo(videoUrl: MockData.demoVideo),
                          ExtendedImage.network(
                            MockData.randomImage(),
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                            enableLoadState: false,
                          ),
                          ExtendedImage.network(
                            MockData.randomImage(),
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                            enableLoadState: false,
                          ),
                          ExtendedImage.network(
                            MockData.randomImage(),
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                            enableLoadState: false,
                          ),
                        ],
                      ),
                    ),

                    ///3 dot
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 8,
                      child: UnconstrainedBox(
                        child: SmoothPageIndicator(
                          controller: controller, // PageController
                          count: 5,
                          effect: const WormEffect(
                            dotWidth: 8.0,
                            dotHeight: 8.0,
                            activeDotColor: Colors.black,
                            dotColor: Colors.white,
                          ), // your preferred effect
                          onDotClicked: (int index) {},
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: ExtendedImage.network(
                          MockData.randomImageAvatar(),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          enableLoadState: false,
                        ).image,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                PadHorizontal(
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Community X', style: TextStyle(fontSize: 24)),
                            Text(
                              ' @Communityx',
                              style: TextStyle(fontSize: 16),
                            ),
                            Gap(8),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_box_rounded),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const PadHorizontal(
                  child: Text(
                    'Community title xxxxxx xxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxx',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Gap(8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PadHorizontal.paddingValue,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.15),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '2.5 Million Members',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.circle_rounded, size: 16, color: Colors.green),
                    Gap(8),
                    Text(
                      '230K Online',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                const PadHorizontal(
                  child: Row(
                    children: <Widget>[
                      Text('Suggestions', style: TextStyle(fontSize: 14)),
                      Spacer(),
                      Text('See All', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
                const Gap(8),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                left: index == 0 ? 8 : 0,
                                right: 8,
                              ),
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Gap(8),
                                  Expanded(
                                    child: ExtendedImage.network(
                                      MockData.randomImageAvatar(),
                                      shape: BoxShape.circle,
                                      fit: BoxFit.cover,
                                      enableLoadState: false,
                                    ),
                                  ),
                                  const Gap(8),
                                  const Text(
                                    'John Doe',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minWidth: 150,
                            color: Colors.blue,
                            onPressed: () {},
                            child: const Text('Follow'),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Gap(8);
                    },
                    itemCount: 10,
                  ),
                ),
                const Gap(8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PadHorizontal.paddingValue,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: const DefaultTabController(
                    length: 7,
                    child: Column(
                      children: <Widget>[
                        Gap(12),
                        WhatsevrTabBarWithViews(
                          shrinkViews: true,
                          tabAlignment: TabAlignment.start,
                          isTabsScrollable: true,
                          tabViews: [
                            ('About', _AboutView()),
                            ('Media', _AboutView()),
                            ('Wtv', _AboutView()),
                            ('Services', _AboutView()),
                            ('Flicks', _AboutView()),
                            ('Offerings', _AboutView()),
                            ('Tags', _AboutView()),
                            ('Pdf', _AboutView()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutView extends StatelessWidget {
  const _AboutView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Gap(8),

        ///Join and Leave
        Row(
          children: <Widget>[
            Expanded(
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.black,
                onPressed: () {},
                child:
                    const Text('Join', style: TextStyle(color: Colors.white)),
              ),
            ),
            const Gap(8),
            Expanded(
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.blue,
                onPressed: () {},
                child: const Text(
                  'Message',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Gap(8),
                  Text(
                    'Status',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscinquam.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Gap(8),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Gap(8),
                  Text(
                    'Serve',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscinquam.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Gap(8),
                ],
              ),
            ),
          ),
        ),
        for ((String?, String) item in <(String?, String)>[
          ('Bio', 'Lorem ipsum dolor sit amet, consectetur adipiscinquam.'),
          (
            'Invite Link',
            'Lorem ipsum dolor sit amet, consectetur adipiscinquam.'
          ),
          (
            'Location',
            'Lorem ipsum dolor sit amet, consectetur adipiscinquam.'
          ),
          (
            'Last seen of Admin',
            'Lorem ipsum dolor sit amet, consectetur adipiscinquam.'
          ),
          (
            'Description',
            'Lorem ipsum dolor sit amet, consectetur adipiscinquam.'
          ),
          ('Total Post', '2355'),
        ])
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: false,
            onChanged: (bool? value) {},
            title: Text(
              '${item.$1}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              item.$2,
            ),
            isThreeLine: true,
          ),
      ],
    );
  }
}

class CoverVideo extends StatefulWidget {
  final String? videoUrl;
  const CoverVideo({super.key, required this.videoUrl});

  @override
  State<CoverVideo> createState() => _CoverVideoState();
}

class _CoverVideoState extends State<CoverVideo> {
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
            aspectRatio: 16 / 9,
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
                return VideoPlayer(controller);
              },
            ),
          ),
        ),
        if (!controller.value.isPlaying)
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(
                Icons.play_arrow,
                size: 40,
                color: Colors.white,
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
          ),
      ],
    );
  }
}
