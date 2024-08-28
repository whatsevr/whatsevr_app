import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import '../../../../config/mocks/mocks.dart';
import '../../../../config/widgets/animated_search_field.dart';
import '../../../../config/widgets/post_tiles/flick.dart';
import '../../../../config/widgets/post_tiles/photo.dart';
import '../../../../config/widgets/post_tiles/portfolio_video.dart';
import '../../../../config/widgets/post_tiles/video.dart';
import '../../../../config/widgets/tab_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PadHorizontal(
            child: WhatsevrAnimatedSearchField(
              hintTexts: const [
                'Search for Wtv from connections',
                'Search for Media from connections',
                'Search for Memories from connections',
                'Search for Flicks from connections',
              ],
            ),
          ),
          const Gap(8.0),
          const Expanded(
            child: WhatsevrTabBarWithViews(
              tabs: [
                'For You',
                'Communities',
                'Activities',
              ],
              tabViews: [
                HomePageForYouPage(),
                HomePageCommunitiesPage(),
                HomePageActivitiesPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageActivitiesPage extends StatelessWidget {
  const HomePageActivitiesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const WhatsevrTabBarWithViews(
      tabs: [
        'History',
        'Offers',
        'Saved',
        'Playlists',
      ],
      tabViews: [
        Text('History'),
        Text('Offers'),
        Text('Playlists'),
        Text('Saved'),
      ],
    );
  }
}

class HomePageCommunitiesPage extends StatelessWidget {
  const HomePageCommunitiesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Media');
  }
}

class HomePageForYouPage extends StatelessWidget {
  const HomePageForYouPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120.0,
          child: Builder(builder: (context) {
            List<Widget> children = [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      width: 100.0,
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  ),
                  const Gap(24.0),
                ],
              ),
              for (int i = 0; i < 5; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.primaries[i % Colors.primaries.length],
                          borderRadius: BorderRadius.circular(18.0),
                          image: DecorationImage(
                            image: ExtendedNetworkImageProvider(
                              MockData.randomImage(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 180.0,
                        alignment: Alignment.center,
                      ),
                    ),
                    const Gap(5.0),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: ExtendedNetworkImageProvider(
                            MockData.imageAvatar,
                          ),
                          radius: 10.0,
                        ),
                        const Gap(5.0),
                        const Text('Username'),
                      ],
                    )
                  ],
                ),
            ];
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? PadHorizontal.padding : 0.0,
                      right: index == children.length - 1
                          ? PadHorizontal.padding
                          : 0.0),
                  child: children[index],
                );
              },
              separatorBuilder: (context, index) {
                return const Gap(5.0);
              },
              itemCount: children.length,
            );
          }),
        ),
        const Gap(8.0),
        Expanded(
          child: GridView.custom(
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: [
                QuiltedGridTile(
                  2,
                  1,
                ),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(2, 3),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index % 6 == 0) return const FlickPostTile();

                if (index % 6 == 1) return const PhotoPostTile();
                if (index % 6 == 2) return const PhotoPostTile();
                if (index % 6 == 3) return const PhotoPostTile();
                if (index % 6 == 4) return const VideoPostTile();
                return const PortfolioVideoPostTile();
              },
            ),
          ),
        )
      ],
    );
  }
}
