import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';

import 'package:whatsevr_app/config/api/response_model/public_recommendation/videos.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/dialogs/comments_view.dart';
import 'package:whatsevr_app/config/widgets/dialogs/show_tagged_users_dialog.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/video.dart';
import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/src/features/details/wtv_details/views/page.dart';
import 'package:whatsevr_app/src/features/explore/bloc/explore_bloc.dart';

class ExplorePageWtvPage extends StatelessWidget {
  const ExplorePageWtvPage({super.key, this.scrollController});
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(
      context,
      scrollController: scrollController,
      execute: () {
        context.read<ExploreBloc>().add(
              LoadMoreVideosEvent(
                page: context
                        .read<ExploreBloc>()
                        .state
                        .videoPaginationData!
                        .currentPage +
                    1,
              ),
            );
      },
    );

    return BlocSelector<ExploreBloc, ExploreState, List<RecommendedVideo>>(
      selector: (ExploreState state) => state.recommendationVideos,
      builder: (BuildContext context, List<RecommendedVideo> data) {
        return MyRefreshIndicator(
          onPullDown: () async {
            context.read<ExploreBloc>().add(LoadVideosEvent());
            await Future<void>.delayed(const Duration(seconds: 2));
          },
          child: ContentMask(
            showMask: data.isEmpty,
            customMask: ListView.separated(
              shrinkWrap: data.isEmpty,
              itemCount: 3,
              separatorBuilder: (BuildContext context, int index) =>
                  const Gap(8),
              itemBuilder: (BuildContext context, int index) => SizedBox(
                width: double.infinity,
                height: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.grey[300],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Gap(8),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <StatelessWidget>[
                                Gap(8),
                                Text('XXXXXXXXXXXXXX'),
                                Text('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            child: ListView.separated(
              cacheExtent: MediaQuery.of(context).size.height * 2,
              controller: scrollController,
              shrinkWrap: data.isEmpty,
              itemCount: data.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  const Gap(8),
              itemBuilder: (BuildContext context, int index) {
                if (index == data.length) {
                  return context
                          .read<ExploreBloc>()
                          .state
                          .videoPaginationData!
                          .isLoading
                      ? const WhatsevrLoadingIndicator()
                      : const SizedBox();
                }
                final RecommendedVideo video = data[index];

                return Column(
                  children: [
                    WtvVideoPostFrame(
                      videoPostUid: video.uid,
                      avatarUrl: video.user?.profilePicture,
                      username: data[index].user?.username,
                      title: data[index].title,
                      description: data[index].description,
                      videoUrl: data[index].videoUrl,
                      thumbnail: data[index].thumbnail,
                      timeAgo: GetTimeAgo.parse(
                        data[index].createdAt!,
                      ),
                      totalTags: (data[index].taggedUserUids?.length ?? 0) +
                          (data[index].taggedCommunityUids?.length ?? 0),
                      onTapTags: () {
                        showTaggedUsersBottomSheet(
                          context,
                          taggedUserUids: data[index].taggedUserUids,
                        );
                      },
                      comments: data[index].totalComments,
                      likes: data[index].totalLikes,
                      shares: data[index].totalShares,
                      views: data[index].totalViews,
                      onRequestOfVideoDetails: () {
                        AppNavigationService.newRoute(
                          RoutesName.wtvDetails,
                          extras: WtvDetailsPageArgument(
                            videoPostUid: data[index].uid,
                            thumbnail: data[index].thumbnail,
                            videoUrl: data[index].videoUrl,
                          ),
                        );
                      },
                      onTapComment: () {
                        showCommentsDialog(videoPostUid: data[index].uid);
                      },
                    ),
                    if (index == data.length - 1 &&
                        context
                            .read<ExploreBloc>()
                            .state
                            .videoPaginationData!
                            .isLoading) ...[
                      const Gap(8),
                      WhatsevrLoadingIndicator(),
                      const Gap(8),
                    ],
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
