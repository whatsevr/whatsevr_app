import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:whatsevr_app/config/enums/activity_type.dart';
import 'package:whatsevr_app/config/themes/theme.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/config/widgets/textfield/animated_search_field.dart';
import 'package:whatsevr_app/src/features/home/views/widgets/communities.dart';
import 'package:whatsevr_app/src/features/home/views/widgets/for_you.dart';
import 'package:whatsevr_app/src/features/home/views/widgets/offers.dart';
part 'widgets/history.dart';
part 'widgets/bookmarks.dart';
class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ScrollController searchBoxHideController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          PadHorizontal(
            child: WhatsevrAnimatedSearchField(
              hideOnScrollController: searchBoxHideController,
              hintTexts: const <String>[
                'Search for Wtv from connections',
                'Search for Media from connections',
                'Search for Memories from connections',
                'Search for Flicks from connections',
              ],
            ),
          ),
          const Gap(8.0),
          Expanded(
            child: WhatsevrTabBarWithViews(
              spaceBetween: 4,
              tabViews: [
                (
                  'For You',
                  HomePageForYouPage(
                    scrollController: searchBoxHideController,
                  )
                ),
                ('Communities', HomePageCommunitiesPage()),
                (
                  'Offers',
                  HomePageOffersPage(
                    scrollController: searchBoxHideController,
                  ),
                ),
                ('Activities', WhatsevrTabBarWithViews(
      tabViews: [
        ('History', _HistoryView()),
        ('Saved', _BookmarksView()),
      ], 
    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
