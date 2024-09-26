import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsevr_app/config/api/response_model/recommendation_flicks.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:gap/gap.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/animated_like_icon_button.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import '../../../../config/widgets/feed_players/flick_full_player.dart';
import '../bloc/flicks_bloc.dart';

class FlicksPage extends StatelessWidget {
  const FlicksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlicksBloc()..add(FlicksInitialEvent()),
      child: Builder(builder: (context) {
        return _buildBody(context);
      }),
    );
  }

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
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Username',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Caption',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                const Gap(8),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      const Gap(8),
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundImage:
                                            NetworkImage(MockData.imageAvatar),
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
        );
      },
    );
  }
}
