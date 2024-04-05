import 'package:flutter/material.dart';
import 'package:whatsevr_app/src/features/activities/views/widgets/downloads/views/page.dart';
import 'package:whatsevr_app/src/features/activities/views/widgets/history/views/page.dart';
import 'package:whatsevr_app/src/features/activities/views/widgets/playlists/views/page.dart';
import 'package:whatsevr_app/src/features/activities/views/widgets/videos/views/page.dart';

import '../../../../config/widgets/animated_search_field.dart';
import '../../../../config/widgets/pad_horizontal.dart';
import '../../../../config/widgets/tab_bar.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PadHorizontal(
          child: WhatsevrAnimatedSearchField(
            hintTexts: const [
              'My Activities',
              'Activities from connections',
            ],
          ),
        ),
        Expanded(
          child: WhatsevrTabBarWithViews(
            tabs: const [
              'History',
              'Downloads',
              'Saved Videos',
              'Playlists',
            ],
            tabViews: const [
              ActivitiesPageHistoryPage(),
              ActivitiesPageDownloadsPage(),
              ActivitiesPageSavedVideosPage(),
              ActivitiesPagePlaylistsPage(),
            ],
          ),
        ),
      ],
    );
  }
}
