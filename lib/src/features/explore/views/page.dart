import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/config/widgets/textfield/animated_search_field.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/memories/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/mix_posts/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/offers/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/photos/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/wtv/views/page.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});
  final ScrollController searchBoxHideController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PadHorizontal(
          child: WhatsevrAnimatedSearchField(
            hideOnScrollController: searchBoxHideController,
            hintTexts: const <String>[
              'Search for Wtv',
              'Search for Media',
              'Search for Memories',
              'Search for Flicks',
            ],
            readOnly: true,
            onTap: () {
              AppNavigationService.newRoute(
                RoutesName.allSearch,
              );
            },
          ),
        ),
        Expanded(
          child: WhatsevrTabBarWithViews(
            spaceBetween: 2,
            isTabsScrollable: true,
            tabAlignment: TabAlignment.start,
            tabViews: [
              (
                'Wtv',
                ExplorePageWtvPage(
                  scrollController: searchBoxHideController,
                )
              ),
              (
                'Explore',
                ExploreMixPostsView(
                  scrollController: searchBoxHideController,
                )
              ),
              (
                'Offers',
                ExplorePageOffersPage(
                  scrollController: searchBoxHideController,
                )
              ),
              (
                'Posts',
                ExplorePagePhotosPage(
                  scrollController: searchBoxHideController,
                )
              ),
              (
                'Memories',
                ExplorePageMemoriesPage(
                  scrollController: searchBoxHideController,
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
