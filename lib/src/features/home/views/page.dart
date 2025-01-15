import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:whatsevr_app/config/api/response_model/tracked_activities/user_tracked_activities.dart';
import 'package:whatsevr_app/config/enums/activity_type.dart';
import 'package:whatsevr_app/config/enums/content_type.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/dynamic_mix_post_tile.dart';
import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/src/features/home/bloc/home_bloc.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/config/widgets/textfield/animated_search_field.dart';
import 'package:whatsevr_app/src/features/home/views/widgets/for_you.dart';
import 'package:whatsevr_app/src/features/home/views/widgets/offers.dart';
part 'widgets/activity_history.dart';
part 'widgets/bookmarks.dart';
part 'widgets/communities.dart';

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
                ('Communities', _CommunityContentView( scrollController: searchBoxHideController,)),
                ( 
                  'Offers',
                  HomePageOffersPage(
                    scrollController: searchBoxHideController,
                  ),
                ),
                (
                  'Activities',
                  WhatsevrTabBarWithViews(
                    onInit: () {
                      context.read<HomeBloc>().add( LoadTrackedActivitiesEvent());
                    },
                    tabViews: [
                      ('History', _ActivityHistoryView()),
                      ('Saved', _BookmarksView()),
                    ],
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
