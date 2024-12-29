import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/response_model/private_recommendation/mix_content.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/dynamic_mix_post_tile.dart';
import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/src/features/home/bloc/home_bloc.dart';
import 'package:whatsevr_app/src/features/home/views/widgets/memories/views/page.dart';

class HomePageForYouPage extends StatelessWidget {
  final ScrollController? scrollController;
  const HomePageForYouPage({
    super.key,
    this.scrollController
  });

  @override
  Widget build(BuildContext context) {
       onReachingEndOfTheList(
         context,
     scrollController: scrollController,
      execute: () {
        context.read<HomeBloc>().add(
              LoadMoreMixContentEvent(
                page: context
                        .read<HomeBloc>()
                        .state
                        .mixContentPaginationData!
                        .currentPage +
                    1,
              ),
            );
      },
    );
    return ListView(
      controller: scrollController,
      children: <Widget>[
        SizedBox(
          height: 150.h,
          child: HomePageMemoriesView(),
        ),
        const Gap(8.0),
        BlocSelector<HomeBloc, HomeState, List<MixContent>?>(
          selector: (HomeState state) => state.mixContent,
          builder: (BuildContext context, List<MixContent>? mixContent) {
            return MyRefreshIndicator(
              onPullDown: () async {
                context.read<HomeBloc>().add(LoadMixContentEvent());
                await Future<void>.delayed(const Duration(seconds: 2));
              },
              child: GridView.custom(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                physics: NeverScrollableScrollPhysics(),
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
                      return const WhatsevrMixPostTile(tileType: WhatsevrMixPostTile.photo);
                    }
        
                    if (index == mixContent.length) {
                      return context.read<HomeBloc>().state.mixContentPaginationData!.isLoading
                          ? WhatsevrLoadingIndicator()
                          : const SizedBox();
                    }
        
                    final content = mixContent[index];
                    final isInvertedPattern = (index ~/ 5) % 2 == 1;
                    final positionInPattern = index % 5;
        
                    if (isInvertedPattern) {
                      // Inverted pattern: video, photo, photo, offer, flick
                      switch (positionInPattern) {
                        case 0:
                          return WhatsevrMixPostTile(
                            tileType: WhatsevrMixPostTile.video,
                            thumbnailUrl: content.content?.thumbnail,
                          );
                        case 1:
                        case 2:
                          return WhatsevrMixPostTile(
                            tileType: WhatsevrMixPostTile.photo,
                            thumbnailUrl: content.content?.thumbnail,
                          );
                        case 3:
                          return WhatsevrMixPostTile(
                            tileType: WhatsevrMixPostTile.offer,
                            thumbnailUrl: content.content?.thumbnail,
                          );
                        case 4:
                          return WhatsevrMixPostTile(
                            tileType: WhatsevrMixPostTile.flick,
                            thumbnailUrl: content.content?.thumbnail,
                          );
                      }
                    } else {
                      // Normal pattern: flick, photo, photo, offer, video
                      switch (positionInPattern) {
                        case 0:
                          return WhatsevrMixPostTile(
                            tileType: WhatsevrMixPostTile.flick,
                            thumbnailUrl: content.content?.thumbnail,
                          );
                        case 1:
                        case 2:
                          return WhatsevrMixPostTile(
                            tileType: WhatsevrMixPostTile.photo,
                            thumbnailUrl: content.content?.thumbnail,
                          );
                        case 3:
                          return WhatsevrMixPostTile(
                            tileType: WhatsevrMixPostTile.offer,
                            thumbnailUrl: content.content?.thumbnail,
                          );
                        case 4:
                          return WhatsevrMixPostTile(
                            tileType: WhatsevrMixPostTile.video,
                            thumbnailUrl: content.content?.thumbnail,
                          );
                      }
                    }
                    return WhatsevrMixPostTile(
                      tileType: WhatsevrMixPostTile.photo,
                      thumbnailUrl: content.content?.thumbnail,
                    );
                  },
                  childCount: mixContent?.length,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
