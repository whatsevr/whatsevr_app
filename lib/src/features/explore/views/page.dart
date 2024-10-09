import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/media/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/memories/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/offers/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/wtv/views/page.dart';

import 'package:whatsevr_app/config/widgets/animated_search_field.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

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
          ),
        ),
        Expanded(
          child: WhatsevrTabBarWithViews(
            isTabsScrollable: true,
            tabViews: [
              (
                'Wtv',
                ExplorePageWtvPage(
                  scrollController: searchBoxHideController,
                )
              ),
              (
                'Media',
                ExplorePageMediaPage(
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
