import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/media/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/memories/views/page.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/wtv/views/page.dart';

import 'package:whatsevr_app/config/widgets/animated_search_field.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PadHorizontal(
          child: WhatsevrAnimatedSearchField(
            hintTexts: const <String>[
              'Search for Wtv',
              'Search for Media',
              'Search for Memories',
              'Search for Flicks',
            ],
          ),
        ),
        const Expanded(
          child: WhatsevrTabBarWithViews(
            tabs: <String>[
              'Wtv',
              'Media',
              'Memories',
            ],
            tabViews: <Widget>[
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
