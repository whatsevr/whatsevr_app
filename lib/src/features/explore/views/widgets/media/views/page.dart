import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/flick.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/photo.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

import '../../../../../../../config/widgets/post_tiles/flick.dart';
import '../../../../../../../config/widgets/post_tiles/photo.dart';
import '../../../../../../../config/widgets/post_tiles/portfolio_video.dart';
import '../../../../../../../config/widgets/post_tiles/video.dart';

class ExplorePageMediaPage extends StatelessWidget {
  const ExplorePageMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WhatsevrTabBarWithViews(tabs: [
      'Explore',
      'Flicks',
      'Posts',
    ], tabViews: [
      _ExploreView(),
      _FlicksView(),
      _PostsView(),
    ]);
  }
}

class _PostsView extends StatelessWidget {
  const _PostsView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (context, index) => const Gap(8),
      itemBuilder: (context, index) {
        return const PhotoFrame();
      },
    );
  }
}

class _FlicksView extends StatelessWidget {
  const _FlicksView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (context, index) => const Gap(8),
      itemBuilder: (context, index) {
        return const FlickFrame();
      },
    );
  }
}

class _ExploreView extends StatelessWidget {
  const _ExploreView();

  @override
  Widget build(BuildContext context) {
    return PadHorizontal(
      child: Expanded(
        child: GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              QuiltedGridTile(2, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index % 5 == 0) return const FlickPostTile();
              if (index % 5 == 1) return const PhotoPostTile();
              if (index % 5 == 2) return const PhotoPostTile();
              if (index % 5 == 3) return const PhotoPostTile();
              return const VideoPostTile();
            },
          ),
        ),
      ),
    );
  }
}
