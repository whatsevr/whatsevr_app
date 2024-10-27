import 'package:carousel_slider/carousel_slider.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/services/launch_url.dart';
import 'package:whatsevr_app/config/widgets/animated_like_icon_button.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/comments_view.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/detectable_text.dart';
import 'package:whatsevr_app/config/widgets/feed_players/wtv_full_player.dart';
import 'package:whatsevr_app/src/features/details/wtv_details/bloc/wtv_details_bloc.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:whatsevr_app/src/features/details/wtv_details/views/widgets/related_videos.dart';
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
                  title:
                      state.videoPostDetailsResponse?.videoPostDetails?.title,
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
                            child: WhatsevrDetectableText(
                              text:
                                  '${state.videoPostDetailsResponse?.videoPostDetails?.description}',
                            ),
                          ),
                        )
                      ],

                      //latest comments
                      ...[
                        Gap(8),
                        PadHorizontal(
                          child: GestureDetector(
                            onTap: () {
                              showCommentsDialog(
                                videoPostUid: state.videoPostDetailsResponse
                                    ?.videoPostDetails?.uid,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Comments',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Gap(8),
                                      Text(
                                        '${formatCountToKMBTQ(state.videoPostDetailsResponse?.videoPostDetails?.totalComments)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'View all',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Builder(builder: (context) {
                                    if (state
                                            .videoPostDetailsResponse
                                            ?.videoPostDetails
                                            ?.userComments
                                            ?.isEmpty ??
                                        true) {
                                      return ListTile(
                                        title: Text(
                                          'Be the first to comment',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      );
                                    }
                                    return CarouselSlider.builder(
                                      itemCount: state
                                          .videoPostDetailsResponse
                                          ?.videoPostDetails
                                          ?.userComments
                                          ?.length,
                                      options: CarouselOptions(
                                        height: 60,
                                        viewportFraction: 1,
                                        initialPage: 0,
                                        enableInfiniteScroll: false,
                                        autoPlay: true,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                      itemBuilder: (BuildContext context,
                                          int index, int realIndex) {
                                        return ListTile(
                                          dense: true,
                                          visualDensity: VisualDensity.compact,
                                          leading: CircleAvatar(
                                            radius: 15,
                                            backgroundImage:
                                                ExtendedNetworkImageProvider(
                                              state
                                                      .videoPostDetailsResponse
                                                      ?.videoPostDetails
                                                      ?.userComments?[index]
                                                      .author
                                                      ?.profilePicture ??
                                                  MockData.blankProfileAvatar,
                                            ),
                                          ),
                                          title: Text(
                                            '${state.videoPostDetailsResponse?.videoPostDetails?.userComments?[index].author?.name}',
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${state.videoPostDetailsResponse?.videoPostDetails?.userComments?[index].commentText}',
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                ],
                              ),
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
                              backgroundImage: ExtendedNetworkImageProvider(
                                state.videoPostDetailsResponse?.videoPostDetails
                                        ?.author?.profilePicture ??
                                    MockData.blankProfileAvatar,
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.videoPostDetailsResponse?.videoPostDetails?.author?.name}',
                                    maxLines: 1,
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
                                        '${state.videoPostDetailsResponse?.videoPostDetails?.author?.username}',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${formatCountToKMBTQ(state.videoPostDetailsResponse?.videoPostDetails?.author?.totalFollowers)} followers',
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
                              WhatsevrLikeButton(),
                              const Gap(8),
                              WhatsevrBookmarkButton(),
                              const Gap(8),
                              WhatsevrCommentButton(
                                onTapComment: () {
                                  showCommentsDialog(
                                    videoPostUid: state.videoPostDetailsResponse
                                        ?.videoPostDetails?.uid,
                                  );
                                },
                              ),
                              const Gap(8),
                              const Gap(8),
                              WhatsevrShareButton(
                                onTapShare: () {},
                              ),
                              // Share button
                            ],
                          ),
                        ),
                      ),

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
