import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/flick.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/photo.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

import 'package:whatsevr_app/config/widgets/post_tiles/flick.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/photo.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/video.dart';

class ExplorePageMediaPage extends StatelessWidget {
  const ExplorePageMediaPage({super.key, this.scrollController});
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    return WhatsevrTabBarWithViews(
      tabViews: [
        ('Explore', _ExploreView(scrollController: scrollController)),
        ('Flicks', _FlicksView(scrollController: scrollController)),
        (
          'Posts',
          _PostsView(
            scrollController: scrollController,
          )
        ),
      ],
    );
  }
}

class _PostsView extends StatelessWidget {
  final ScrollController? scrollController;
  const _PostsView({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Gap(8),
      itemBuilder: (BuildContext context, int index) {
        return const PhotoFrame();
      },
    );
  }
}

class _FlicksView extends StatelessWidget {
  final ScrollController? scrollController;
  const _FlicksView({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Gap(8),
      itemBuilder: (BuildContext context, int index) {
        return const FlickFrame();
      },
    );
  }
}

class _ExploreView extends StatelessWidget {
  final ScrollController? scrollController;
  const _ExploreView({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return PadHorizontal(
      child: GridView.custom(
        controller: scrollController,
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: <QuiltedGridTile>[
            QuiltedGridTile(2, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (index % 5 == 0) return const FlickPostTile();
            if (index % 5 == 1) return const PhotoPostTile();
            if (index % 5 == 2) return const PhotoPostTile();
            if (index % 5 == 3) return const PhotoPostTile();
            return const VideoPostTile();
          },
        ),
      ),
    );
  }
}
