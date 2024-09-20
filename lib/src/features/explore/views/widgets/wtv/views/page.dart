import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/video.dart';

import 'package:whatsevr_app/config/api/response_model/recommendation_videos.dart';
import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/show_tagged_users_dialog.dart';
import 'package:whatsevr_app/src/features/explore/bloc/explore_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class ExplorePageWtvPage extends StatelessWidget {
  const ExplorePageWtvPage({super.key, this.scrollController});
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ExploreBloc, ExploreState, List<RecommendedVideo>?>(
      selector: (ExploreState state) => state.recommendationVideos,
      builder: (BuildContext context, List<RecommendedVideo>? data) {
        return MyRefreshIndicator(
          onPullDown: () async {
            context.read<ExploreBloc>().add(ExploreInitialEvent());
            await Future<void>.delayed(const Duration(seconds: 2));
          },
          onScrollFinished: () async {
            await Future<void>.delayed(const Duration(seconds: 2));
          },
          child: ContentMask(
            showMask: data == null || data.isEmpty,
            customMask: ListView.separated(
              shrinkWrap: data == null || data.isEmpty,
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <StatelessWidget>[
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
              controller: scrollController,
              shrinkWrap: data == null || data.isEmpty,
              itemCount: data?.length ?? 3,
              separatorBuilder: (BuildContext context, int index) =>
                  const Gap(8),
              itemBuilder: (BuildContext context, int index) {
                return WtvVideoPostFrame(
                  avatarUrl: data?[index].user?.profilePicture,
                  username: data?[index].user?.username,
                  title: data?[index].title,
                  description: data?[index].description,
                  videoUrl: data?[index].videoUrl,
                  thumbnail: data?[index].thumbnail,
                  timeAgo: timeago.format(
                    data![index].createdAt!,
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
                    AppNavigationService.newRoute(RoutesName.wtvDetails);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
