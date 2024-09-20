import 'package:flutter/material.dart';

import 'package:whatsevr_app/config/widgets/tab_bar.dart';

class HomePageActivitiesPage extends StatelessWidget {
  const HomePageActivitiesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const WhatsevrTabBarWithViews(
      tabViews: [
        ('History', Text('History')),
        ('Saved', Text('Saved')),
      ],
    );
  }
}
