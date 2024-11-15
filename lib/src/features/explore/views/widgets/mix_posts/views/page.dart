import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import 'package:whatsevr_app/config/widgets/post_tiles/flick.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/photo.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/video.dart';

class ExploreMixPostsView extends StatelessWidget {
  final ScrollController? scrollController;
  const ExploreMixPostsView({super.key, this.scrollController});

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
            const QuiltedGridTile(2, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
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
