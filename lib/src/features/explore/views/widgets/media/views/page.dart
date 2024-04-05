import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/flick.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/photo.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

import '../../../../../../../config/widgets/post_tiles/flick.dart';
import '../../../../../../../config/widgets/post_tiles/photo.dart';
import '../../../../../../../config/widgets/post_tiles/video.dart';

class ExplorePageMediaPage extends StatelessWidget {
  const ExplorePageMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WhatsevrTabBarWithViews(tabs: [
      'Explore',
      'Flicks',
      'Photos',
    ], tabViews: [
      _ExploreView(),
      _FlicksView(),
      _PhotosView(),
    ]);
  }
}

class _PhotosView extends StatelessWidget {
  const _PhotosView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (context, index) => const Gap(8),
      itemBuilder: (context, index) {
        return PhotoFrame();
      },
    );
  }
}

class _FlicksView extends StatelessWidget {
  const _FlicksView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (context, index) => const Gap(8),
      itemBuilder: (context, index) {
        return FlickFrame();
      },
    );
  }
}

class _ExploreView extends StatelessWidget {
  const _ExploreView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PadHorizontal(
      child: WaterfallFlow.builder(
        //cacheExtent: 0.0,

        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index % 3 == 0) return PhotoPostTile();
          if (index % 3 == 1) return FlickPostTile();
          if (index % 3 == 2) return VideoPostTile();
          return SizedBox();
        },
      ),
    );
  }
}
