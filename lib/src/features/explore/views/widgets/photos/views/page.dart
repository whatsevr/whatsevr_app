import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:whatsevr_app/config/api/response_model/recommendation_photo_posts.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';

import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/config/widgets/show_tagged_users_dialog.dart';
import 'package:whatsevr_app/src/features/explore/bloc/explore_bloc.dart';

import '../../../../../../../config/widgets/posts_frame/photos.dart';

class ExplorePagePhotosPage extends StatelessWidget {
  const ExplorePagePhotosPage({super.key, this.scrollController});
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(
      scrollController,
      execute: () {
        context.read<ExploreBloc>().add(LoadMorePhotoPostsEvent(
              page: context
                      .read<ExploreBloc>()
                      .state
                      .videoPaginationData!
                      .currentPage +
                  1,
            ));
      },
    );

    return BlocSelector<ExploreBloc, ExploreState, List<RecommendedPhotoPost>?>(
      selector: (ExploreState state) => state.recommendationPhotoPosts,
      builder: (BuildContext context, List<RecommendedPhotoPost>? data) {
        return MyRefreshIndicator(
          onPullDown: () async {
            context.read<ExploreBloc>().add(LoadPhotoPostsEvent());
            await Future<void>.delayed(const Duration(seconds: 2));
          },
          child: ListView.separated(
            cacheExtent: MediaQuery.of(context).size.height * 2,
            controller: scrollController,
            shrinkWrap: data == null || data.isEmpty,
            itemCount: data?.length ?? 3,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              RecommendedPhotoPost offer = data![index];

              return Column(
                children: [
                  PhotosPostFrame(
                    avatarUrl: offer.user?.profilePicture,
                    username: data[index].user?.username,
                    fullName: data[index].user?.name,
                    title: data[index].title,
                    description: data[index].description,
                    filesData: data[index].filesData,
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
                    impressions: data[index].totalImpressions,
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
        );
      },
    );
  }
}
