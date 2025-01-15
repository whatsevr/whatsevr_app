import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:whatsevr_app/config/api/response_model/public_recommendation/mix_content.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/dynamic_mix_post_tile.dart';
import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/src/features/explore/bloc/explore_bloc.dart';

class ExploreMixPostsView extends StatelessWidget {
  final ScrollController? scrollController;
  const ExploreMixPostsView({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(
      context,
      scrollController: scrollController,
      execute: () {
        context.read<ExploreBloc>().add(
              LoadMoreMixContentEvent(
                page: context
                        .read<ExploreBloc>()
                        .state
                        .mixContentPaginationData!
                        .currentPage +
                    1,
              ),
            );
      },
    );

    return BlocSelector<ExploreBloc, ExploreState, List<MixContent>?>(
      selector: (ExploreState state) => state.mixContent,
      builder: (BuildContext context, List<MixContent>? mixContent) {
        return MyRefreshIndicator(
          onPullDown: () async {
            context.read<ExploreBloc>().add(LoadMixContentEvent());
            await Future<void>.delayed(const Duration(seconds: 2));
          },
          child: GridView.custom(
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
                if (mixContent == null || mixContent.isEmpty) {
                  return SizedBox();
                }

                if (index == mixContent.length) {
                  return context
                          .read<ExploreBloc>()
                          .state
                          .mixContentPaginationData!
                          .isLoading
                      ? WhatsevrLoadingIndicator()
                      : const SizedBox();
                }

                final content = mixContent[index];
                final isInvertedPattern = (index ~/ 5) % 2 == 1;
                final positionInPattern = index % 5;
                String? tileType;
                String? thumbnailUrl;

                // Determine tile type based on mixContent.type
                switch (content.type?.toLowerCase()) {
                  case 'wtv':
                    tileType = WhatsevrMixPostTile.wtv;
                    thumbnailUrl = content.content?.thumbnail;
                    break;
                  case 'flick':
                    tileType = WhatsevrMixPostTile.flick;
                    thumbnailUrl = content.content?.thumbnail;
                    break;
                  case 'offer':
                    tileType = WhatsevrMixPostTile.offer;

                    thumbnailUrl =
                        content.content?.filesData?.firstOrNull?.imageUrl;

                    break;
                  case 'photo':
                    tileType = WhatsevrMixPostTile.photo;
                    thumbnailUrl =
                        content.content?.filesData?.firstOrNull?.imageUrl;
                    break;
                }
                // Updated pattern: flick, photo, photo, offer, video
                if (isInvertedPattern) {
                  // Inverted pattern: video, photo, photo, offer, flick
                  switch (positionInPattern) {
                    case 0:
                      return WhatsevrMixPostTile(
                        uid: content.content?.uid,
                        tileType: tileType,
                        thumbnailUrl: thumbnailUrl,
                      );
                    case 1:
                    case 2:
                      return WhatsevrMixPostTile(
                        uid: content.content?.uid,
                        tileType: tileType,
                        thumbnailUrl: thumbnailUrl,
                      );
                    case 3:
                      return WhatsevrMixPostTile(
                        uid: content.content?.uid,
                        tileType: tileType,
                        thumbnailUrl: thumbnailUrl,
                      );
                    case 4:
                      return WhatsevrMixPostTile(
                        uid: content.content?.uid,
                        tileType: tileType,
                        thumbnailUrl: thumbnailUrl,
                      );
                  }
                } else {
                  // Normal pattern: flick, photo, photo, offer, video
                  switch (positionInPattern) {
                    case 0:
                      return WhatsevrMixPostTile(
                        uid: content.content?.uid,
                        tileType: tileType,
                        thumbnailUrl: thumbnailUrl,
                      );
                    case 1:
                    case 2:
                      return WhatsevrMixPostTile(
                        uid: content.content?.uid,
                        tileType: tileType,
                        thumbnailUrl: thumbnailUrl,
                      );
                    case 3:
                      return WhatsevrMixPostTile(
                        uid: content.content?.uid,
                        tileType: tileType,
                        thumbnailUrl: thumbnailUrl,
                      );
                    case 4:
                      return WhatsevrMixPostTile(
                        uid: content.content?.uid,
                        tileType: tileType,
                        thumbnailUrl: thumbnailUrl,
                      );
                  }
                }
                return SizedBox();
              },
              childCount: mixContent?.length,
            ),
          ),
        );
      },
    );
  }
}
