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
    return GridView.custom(
      padding: EdgeInsets.symmetric(
        horizontal: 2,
      ),
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
          final isInvertedPattern = (index ~/ 5) % 2 == 1;
          final positionInPattern = index % 5;

            if (isInvertedPattern) {
            // Inverted pattern: Video, Photo, Flick, Photo, Photo
            if (positionInPattern == 0) return const VideoPostTile();
            if (positionInPattern == 2) return const FlickPostTile();
            return const PhotoPostTile();
            } else {
            // Normal pattern: Flick, Photo, Photo, Photo, Video
            if (positionInPattern == 0) return const FlickPostTile();
            if (positionInPattern == 4) return const VideoPostTile();
            return const PhotoPostTile();
            }
        },
      ),
    );
  }
}
