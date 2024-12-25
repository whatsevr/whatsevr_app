import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:extended_image/extended_image.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/dynamic_mix_post_tile.dart';

 

class ExploreMixPostsView extends StatelessWidget {
  final ScrollController? scrollController;
  const ExploreMixPostsView({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      controller: scrollController,
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(2, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final isInvertedPattern = (index ~/ 5) % 2 == 1;
          final positionInPattern = index % 5;

          if (isInvertedPattern) {
            // Inverted pattern: Video, Photo, Flick, Photo, Photo
            if (positionInPattern == 0) return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.video);
            if (positionInPattern == 2) return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.flick);
            return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.photo);
          } else {
            // Normal pattern: Flick, Photo, Photo, Photo, Video
            if (positionInPattern == 0) return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.flick);
            if (positionInPattern == 4) return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.video);
            return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.photo);
          }
        },
      ),
    );
  }
}
