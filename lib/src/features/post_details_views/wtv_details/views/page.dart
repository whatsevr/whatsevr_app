import 'package:detectable_text_field/detector/text_pattern_detector.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/services/launch_url.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/feed_players/wtv_full_player.dart';
import 'package:whatsevr_app/src/features/post_details_views/wtv_details/bloc/wtv_details_bloc.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:whatsevr_app/src/features/post_details_views/wtv_details/views/widgets/related_videos.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/utils/conversion.dart';

class WtvDetailsPageArgument {
  final String? videoPostUid;
  final String? thumbnail;
  final String? videoUrl;

  WtvDetailsPageArgument({
    required this.videoPostUid,
    this.thumbnail,
    this.videoUrl,
  });
}

class WtvDetailsPage extends StatelessWidget {
  final WtvDetailsPageArgument pageArgument;

  const WtvDetailsPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WtvDetailsBloc()..add(InitialEvent(pageArgument)),
      child: Builder(builder: (context) {
        return buildPage(context);
      }),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<WtvDetailsBloc, WtvDetailsState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              if (state.videoUrl != null)
                WtvFullPlayer(
                  key: ValueKey('wtv-details-${state.videoPostUid}'),
                  videoUrl: state.videoUrl,
                  thumbnail: state.thumbnail,
                ),
              Expanded(
                child: ContentMask(
                  showMask: state.videoPostDetailsResponse == null,
                  child: ListView(
                    children: <Widget>[
                      Gap(8),
                      if (state.videoPostDetailsResponse?.videoPostDetails
                              ?.hashtags?.isNotEmpty ??
                          false) ...[
                        PadHorizontal(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (String hashtag in state
                                    .videoPostDetailsResponse!
                                    .videoPostDetails!
                                    .hashtags!)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    margin: const EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '#$hashtag',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Gap(8)
                      ],
                      PadHorizontal(
                        child: Text(
                          '${state.videoPostDetailsResponse?.videoPostDetails?.title}',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (state.videoPostDetailsResponse?.videoPostDetails
                              ?.description?.isNotEmpty ??
                          false) ...[
                        Gap(8),
                        PadHorizontal(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DetectableText(
                              text:
                                  '${state.videoPostDetailsResponse?.videoPostDetails?.description}',
                              trimLines: 3,
                              trimMode: TrimMode.Line,
                              colorClickableText: Colors.blue,
                              moreStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              lessStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              detectionRegExp: detectionRegExp(
                                hashtag: false,
                              )!,
                              detectedStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.blue,
                              ),
                              basicStyle: TextStyle(
                                fontSize: 13,
                              ),
                              onTap: (tappedText) {
                                print(tappedText);
                                if (TextPatternDetector.isDetected(
                                    tappedText, atSignUrlRegExp)) {
                                } else if (TextPatternDetector.isDetected(
                                    tappedText, urlRegex)) {
                                  launchWebURL(context, url: tappedText);
                                }
                              },
                            ),
                          ),
                        )
                      ],
                      Gap(8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            // Channel name
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                state.videoPostDetailsResponse?.videoPostDetails
                                        ?.user?.profilePicture ??
                                    '',
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.videoPostDetailsResponse?.videoPostDetails?.user?.name}',
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Gap(2),
                                  Wrap(
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: [
                                      Text(
                                        '${state.videoPostDetailsResponse?.videoPostDetails?.user?.username}',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${formatCountToKMBTQ(state.videoPostDetailsResponse?.videoPostDetails?.user?.totalFollowers)} followers',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gap(8),
                            // Subscribe button
                            WhatsevrButton.filled(
                              shrink: true,
                              miniButton: true,
                              onPressed: () {},
                              label: 'Follow',
                            ),
                          ],
                        ),
                      ),
                      //like, dislike, share, save, download buttons
                      PadHorizontal(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              // Like button
                              for ((String label, IconData icon) record
                                  in <(String, IconData)>[
                                ('Like', Icons.thumb_up),
                                ('Share', Icons.share),
                                ('Save', Icons.bookmark),
                              ])
                                MaterialButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: <Widget>[
                                      Icon(record.$2),
                                      const Gap(5),
                                      Text(record.$1),
                                    ],
                                  ),
                                ),

                              // Share button
                            ],
                          ),
                        ),
                      ),
                      //comments

                      const Gap(10),
                      const WtvVideoDetailsRelatedVideosView(),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
