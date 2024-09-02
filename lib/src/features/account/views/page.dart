import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/src/features/search_pages/account/views/page.dart';

import '../../../../config/mocks/mocks.dart';
import '../../../../config/widgets/animated_search_field.dart';
import '../../../../config/widgets/content_upload_button_sheet.dart';
import '../../../../config/widgets/tab_bar.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PadHorizontal(
            child: WhatsevrAnimatedSearchField(
              hintTexts: const [
                'Search for Account',
                'Search for Portfolio',
                'Search for Community',
              ],
              readOnly: true,
              onTap: () {
                AppNavigationService.newRoute(RoutesName.accountSearch,
                    extras: const AccountSearchPage(
                      hintTexts: [
                        'Search for Account',
                        'Search for Portfolio',
                        'Search for Community',
                      ],
                    ));
              },
            ),
          ),
          const Gap(8),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: PageView(
                        controller: controller,
                        children: [
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
                            onDotClicked: (index) {}),
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
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('John Doe', style: TextStyle(fontSize: 24)),
                            Text(' @johndoe', style: TextStyle(fontSize: 16)),
                            Gap(8),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_box_rounded),
                        onPressed: () {
                          showContentUploadBottomSheet(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          AppNavigationService.newRoute(RoutesName.settings);
                        },
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: PadHorizontal.paddingValue,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('1,000', style: TextStyle(fontSize: 24)),
                            Text('Likes', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('1,000', style: TextStyle(fontSize: 24)),
                            Text('Networks', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('1,000', style: TextStyle(fontSize: 24)),
                            Text('Connections', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                const PadHorizontal(
                  child: Row(
                    children: [
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
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 8 : 0, right: 8),
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                  const Text('John Doe',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            minWidth: 150,
                            color: Colors.blue,
                            onPressed: () {},
                            child: const Text('Follow'),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
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
                  child: Column(
                    children: [
                      const Gap(12),
                      const WhatsevrTabBarWithViews(
                        shrinkViews: true,
                        tabAlignment: TabAlignment.start,
                        isTabsScrollable: true,
                        tabs: [
                          'About',
                          'Media',
                          'Videos',
                          'Flicks',
                          'Tags',
                          'Offerings',
                        ],
                        tabViews: [
                          AccountPageAboutView(),
                          const Text('Media'),
                          const Text('Videos'),
                          const Text('Flicks'),
                          const Text('Tags'),
                          const Text('Offerings'),
                        ],
                      ),
                      const Gap(8),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountPageAboutView extends StatelessWidget {
  const AccountPageAboutView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(12),
        for ((String label, String info) itm in [
          ('Bio', 'XXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Address', 'XXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Education', 'XXXXXXXXXXXXXXXXXXXXXX'),
          ('Working', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Email', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Birthday', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Join On', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Account link', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('About', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Total Connection', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Total Post', '2524'),
        ])
          CheckboxListTile(
            visualDensity: VisualDensity.compact,
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: false,
            onChanged: (value) {},
            title: Text(
              itm.$1,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              itm.$2,
              style: const TextStyle(fontSize: 12),
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
