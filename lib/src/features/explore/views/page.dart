import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/media/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/memories/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/wtv/views/page.dart';

import '../../../../config/widgets/animated_search_field.dart';
import '../../../../config/widgets/pad_horizontal.dart';
import '../../../../config/widgets/tab_bar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PadHorizontal(
          child: WhatsevrAnimatedSearchField(
            hintTexts: const [
              'Search for Wtv',
              'Search for Media',
              'Search for Memories',
              'Search for Flicks',
            ],
          ),
        ),
        Expanded(
          child: WhatsevrTabBarWithViews(
            tabs: const [
              'Wtv',
              'Media',
              'Memories',
            ],
            tabViews: const [
              ExplorePageWtvPage(),
              ExplorePageMediaPage(),
              ExplorePageMemoriesPage(),
            ],
          ),
        ),
      ],
    );
  }
}
