import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/response_model/public_recommendation/mix_content.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/dynamic_mix_post_tile.dart';
import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/src/features/explore/bloc/explore_bloc.dart';

class ExploreMixPostsView extends StatefulWidget {
  final ScrollController? scrollController;
  const ExploreMixPostsView({super.key, this.scrollController});

  @override
  State<ExploreMixPostsView> createState() => _ExploreMixPostsViewState();
}

class _ExploreMixPostsViewState extends State<ExploreMixPostsView> {
  @override
  void initState() {
    super.initState();
        onReachingEndOfTheList(
      widget.scrollController,
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
  }
  @override
  Widget build(BuildContext context) {


    return BlocSelector<ExploreBloc, ExploreState, List<MixContent>?>(
      selector: (ExploreState state) => state.mixContent,
      builder: (BuildContext context, List<MixContent>? data) {
        return MyRefreshIndicator(
          onPullDown: () async {
            context.read<ExploreBloc>().add(LoadMixContentEvent());
            await Future<void>.delayed(const Duration(seconds: 2));
          },
          child: GridView.custom(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            controller: widget.scrollController,
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
                if (data == null || data.isEmpty) {
                  return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.photo);
                }

                if (index == data.length) {
                  return context.read<ExploreBloc>().state.mixContentPaginationData!.isLoading
                      ? WhatsevrLoadingIndicator()
                      : const SizedBox();
                }

                final content = data[index];
                final isInvertedPattern = (index ~/ 5) % 2 == 1;
                final positionInPattern = index % 5;

                if (isInvertedPattern) {
                  if (positionInPattern == 0) {
                    return WhatsevrMixPostTile(
                      type: WhatsevrMixPostTile.video,
                      thumbnailUrl: content.content?.thumbnail,
                    );
                  }
                  if (positionInPattern == 2) {
                    return WhatsevrMixPostTile(
                      type: WhatsevrMixPostTile.flick,
                        thumbnailUrl: content.content?.thumbnail,
                    );
                  }
                  return WhatsevrMixPostTile(
                    type: WhatsevrMixPostTile.photo,
                       thumbnailUrl: content.content?.thumbnail,
                  );
                } else {
                  if (positionInPattern == 0) {
                    return WhatsevrMixPostTile(
                      type: WhatsevrMixPostTile.flick,
                         thumbnailUrl: content.content?.thumbnail,
                    );
                  }
                  if (positionInPattern == 4) {
                    return WhatsevrMixPostTile(
                      type: WhatsevrMixPostTile.video,
                       thumbnailUrl: content.content?.thumbnail,
                    );
                  }
                  return WhatsevrMixPostTile(
                    type: WhatsevrMixPostTile.photo,
                       thumbnailUrl: content.content?.thumbnail,
                  );
                }
              },
              childCount: (data?.length ?? 0) + 1,
            ),
          ),
        );
      },
    );
  }
}
