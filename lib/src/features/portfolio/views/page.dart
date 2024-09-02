import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/src/features/portfolio/views/widgets/about.dart';
import 'package:whatsevr_app/src/features/portfolio/views/widgets/wtv.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

class PortfolioPage extends StatelessWidget {
  PortfolioPage({super.key});
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                            Text('Portfolio X', style: TextStyle(fontSize: 24)),
                            Text(
                              ' @Portfoliox',
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
                    'Portfolio title xxxxxx xxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxx',
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('1,000', style: TextStyle(fontSize: 24)),
                            Text('Likes', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('1,000', style: TextStyle(fontSize: 24)),
                            Text('Networks', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('1,000', style: TextStyle(fontSize: 24)),
                            Text('Posts', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: DefaultTabController(
                    length: 7,
                    child: Column(
                      children: const <Widget>[
                        Gap(12),
                        WhatsevrTabBarWithViews(
                          tabAlignment: TabAlignment.start,
                          shrinkViews: true,
                          isTabsScrollable: true,
                          tabs: <String>[
                            'About',
                            'Media',
                            'Wtv',
                            'Services',
                            'Flicks',
                            'Offerings',
                            'Tags',
                            'Pdf',
                          ],
                          tabViews: <Widget>[
                            PortfolioPageAboutView(),
                            Text('Media'),
                            PortfolioPageWtvView(),
                            Text('Photos'),
                            Text('Audios'),
                            Text('Documents'),
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
