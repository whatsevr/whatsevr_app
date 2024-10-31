import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:whatsevr_app/config/widgets/buttons/follow_unfollow.dart';

import '../../../../config/api/response_model/recommendation_flicks.dart';
import '../../../../config/mocks/mocks.dart';
import '../../../../config/themes/theme.dart';
import '../../../../config/widgets/buttons/animated_like_icon_button.dart';
import '../../../../config/widgets/buttons/button.dart';
import '../../../../config/widgets/buttons/two_state_ui.dart';
import '../../../../config/widgets/content_mask.dart';
import '../../../../config/widgets/dialogs/comments_view.dart';
import '../../../../config/widgets/feed_players/flick_full_player.dart';
import '../../../../config/widgets/max_scroll_listener.dart';
import '../../../../config/widgets/pad_horizontal.dart';
import '../bloc/flicks_bloc.dart';

class FlicksPage extends StatefulWidget {
  const FlicksPage({super.key});

  @override
  State<FlicksPage> createState() => _FlicksPageState();
}

class _FlicksPageState extends State<FlicksPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlicksBloc()..add(FlicksInitialEvent()),
      child: Builder(
        builder: (context) {
          return _buildBody(context);
        },
      ),
    );
  }

  CachedVideoPlayerPlusController? currentVideoController;
  final PreloadPageController scrollController = PreloadPageController();

  Widget _buildBody(BuildContext context) {
    onReachingEndOfTheList(
      scrollController,
      execute: () {
        context.read<FlicksBloc>().add(
              LoadMoreFlicksEvent(
                page: context
                        .read<FlicksBloc>()
                        .state
                        .flicksPaginationData!
                        .currentPage +
                    1,
              ),
            );
      },
    );

    return BlocSelector<FlicksBloc, FlicksState, List<RecommendedFlick>?>(
      selector: (FlicksState state) => state.recommendationFlicks,
      builder: (context, data) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Builder(
            builder: (context) {
              return ContentMask(
                showMask: data == null || data.isEmpty,
                child: PreloadPageView.builder(
                  controller: scrollController,
                  preloadPagesCount: 5,
                  scrollDirection: Axis.vertical,
                  itemCount: data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    final RecommendedFlick? flick = data?[index];

                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        //Reels
                        FlicksFullPlayer(
                          videoUrl: flick?.videoUrl,
                          thumbnail: flick?.thumbnail,
                          onPlayerInitialized: (controller) {
                            currentVideoController = controller;
                            setState(() {});
                            currentVideoController?.addListener(() {
                              if (currentVideoController?.value.isPlaying ==
                                  true) {
                                setState(() {});
                              }
                            });
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: PadHorizontal(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    WhatsevrReactButton(
                                      size: 30,
                                      firstColor: DarkTheme().icon,
                                      arrangeVertically: true,
                                    ),
                                    const Gap(16),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.link,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Gap(16),
                                    WhatsevrShareButton(
                                      iconColor: DarkTheme().icon,
                                    ),
                                  ],
                                ),
                                const Gap(16),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage:
                                              ExtendedNetworkImageProvider(
                                            flick?.user?.profilePicture ??
                                                MockData.blankProfileAvatar,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${flick?.user?.username}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                '${flick?.title} ${flick?.description}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Gap(8),
                                        //follow
                                        WhatsevrFollowButton(
                                          followeeUserUid: flick?.user?.uid,
                                        ),

                                        Gap(12),
                                        Whatsevr3DotMenuButton(
                                          iconColor: DarkTheme().icon,
                                        ),
                                      ],
                                    ),
                                    const Gap(8),
                                    GestureDetector(
                                      onTap: () {
                                        showCommentsDialog(
                                          flickPostUid: flick?.uid,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: CarouselSlider.builder(
                                          itemCount: 15,
                                          options: CarouselOptions(
                                            height: 40,
                                            viewportFraction: 1,
                                            enableInfiniteScroll: true,
                                            enlargeCenterPage: false,
                                            autoPlay: true,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                          itemBuilder: (
                                            BuildContext context,
                                            int itemIndex,
                                            int pageViewIndex,
                                          ) =>
                                              Row(
                                            children: <Widget>[
                                              const Gap(8),
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundImage: NetworkImage(
                                                  MockData.blankProfileAvatar,
                                                ),
                                              ),
                                              const Gap(8),
                                              const Expanded(
                                                child: Text(
                                                  'Top Comments',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
          //show video progress
          bottomNavigationBar: currentVideoController == null
              ? null
              : VideoProgressIndicator(
                  currentVideoController!,
                  allowScrubbing: true,
                  padding: const EdgeInsets.all(0),
                  colors: VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.red.withOpacity(0.5),
                    backgroundColor: Colors.white.withOpacity(0.2),
                  ),
                ),
        );
      },
    );
  }
}
