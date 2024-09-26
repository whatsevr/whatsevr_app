import 'package:cached_chewie_plus/cached_chewie_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsevr_app/config/api/response_model/recommendation_flicks.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:gap/gap.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/animated_like_icon_button.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/video.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';

import '../../../../config/widgets/feed_players/flick_full_player.dart';
import '../bloc/flicks_bloc.dart';

class FlicksPage extends StatefulWidget {
  FlicksPage({super.key});

  @override
  State<FlicksPage> createState() => _FlicksPageState();
}

class _FlicksPageState extends State<FlicksPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlicksBloc()..add(FlicksInitialEvent()),
      child: Builder(builder: (context) {
        return _buildBody(context);
      }),
    );
  }

  CachedVideoPlayerController? currentController;

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<FlicksBloc, FlicksState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Builder(builder: (context) {
            if (state.recommendationFlicks == null ||
                state.recommendationFlicks!.isEmpty) {
              return const Center(child: CupertinoActivityIndicator());
            }
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.recommendationFlicks?.length,
              itemBuilder: (BuildContext context, int index) {
                RecommendedFlick? flick = state.recommendationFlicks?[index];
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    //Reels
                    FlicksFullPlayer(
                      videoUrl: flick?.videoUrl,
                      thumbnail: flick?.thumbnail,
                      onPlayerInitialized: (controller) {
                        currentController = controller;
                        setState(() {});
                        currentController?.addListener(() {
                          if (currentController?.value.isPlaying == true) {
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
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                AnimatedLikeIconButton(
                                  size: 30,
                                  firstColor: Colors.white,
                                ),
                                Gap(16),
                                Icon(
                                  Icons.link,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Gap(16),
                                Icon(
                                  Icons.share,
                                  size: 30,
                                  color: Colors.white,
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
                                                  MockData.imageAvatar),
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
                                    TwoStateWidget(
                                      firstStateUi: AbsorbPointer(
                                        child: WhatsevrButton.outlined(
                                          miniButton: true,
                                          shrink: true,
                                          label: 'Follow',
                                          onPressed: () {},
                                        ),
                                      ),
                                      secondStateUi: AbsorbPointer(
                                        child: WhatsevrButton.outlined(
                                          miniButton: true,
                                          shrink: true,
                                          label: 'Following',
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),

                                    Gap(12),
                                    const Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                const Gap(8),
                                CarouselSlider.builder(
                                  itemCount: 15,
                                  options: CarouselOptions(
                                    height: 40,
                                    viewportFraction: 1,
                                    enableInfiniteScroll: true,
                                    enlargeCenterPage: false,
                                    autoPlay: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) =>
                                      GestureDetector(
                                    onTap: () {
                                      showAppModalSheet(child: Container());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          const Gap(8),
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundImage: NetworkImage(
                                                MockData.imageAvatar),
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
            );
          }),
          //show video progress
          bottomNavigationBar: Builder(builder: (context) {
            if (currentController == null) return const SizedBox();
            return SizedBox(
              height: 2,
              child: LinearProgressIndicator(
                value: currentController!.value.position.inMilliseconds /
                    currentController!.value.duration.inMilliseconds,
                backgroundColor: Colors.white,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          }),
        );
      },
    );
  }
}
