import 'package:flutter/material.dart';

import '../../../../../config/widgets/tab_bar.dart';

class HomePageActivitiesPage extends StatelessWidget {
  const HomePageActivitiesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const WhatsevrTabBarWithViews(
      tabs: [
        'History',
        'Downloads',
        'Saved Videos',
        'Playlists',
      ],
      tabViews: [
        Text('History'),
        Text('Downloads'),
        Text('Playlists'),
        Text('Saved'),
      ],
    );
  }
}
