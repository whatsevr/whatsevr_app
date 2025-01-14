import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:whatsevr_app/config/api/external/models/network_file.dart';
import 'package:whatsevr_app/config/api/response_model/public_recommendation/offers.dart';

import 'package:whatsevr_app/config/widgets/dialogs/comments_view.dart';
import 'package:whatsevr_app/config/widgets/dialogs/show_tagged_users_dialog.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/offer.dart';
import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/src/features/explore/bloc/explore_bloc.dart';

class ExplorePageOffersPage extends StatelessWidget {
  const ExplorePageOffersPage({super.key, this.scrollController});
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(
      context,
      scrollController: scrollController,
      execute: () {
        context.read<ExploreBloc>().add(
              LoadMoreOffersEvent(
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

    return BlocSelector<ExploreBloc, ExploreState, List<RecommendedOffer>?>(
      selector: (ExploreState state) => state.recommendationOffers,
      builder: (BuildContext context, List<RecommendedOffer>? data) {
        return MyRefreshIndicator(
          onPullDown: () async {
            context.read<ExploreBloc>().add(LoadOffersEvent());
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
              final RecommendedOffer offer = data![index];

              return Column(
                children: [
                  OfferPostFrame(
                    offerPostUid: offer.uid,
                    avatarUrl: offer.user?.profilePicture,
                    username: data[index].user?.username,
                    fullName: data[index].user?.name,
                    title: data[index].title,
                    description: data[index].description,
                    status: data[index].status,
                    filesData: data[index]
                        .filesData
                        ?.map(
                          (e) => WhatsevrNetworkFile.fromMap(
                            e.toMap(),
                          ),
                        )
                        .toList(),
                    ctaAction: data[index].ctaAction,
                    ctaActionUrl: data[index].ctaActionUrl,
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
                    views: data[index].totalImpressions,
                    onTapComment: () {
                      showCommentsDialog(offerPostUid: data[index].uid);
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
        );
      },
    );
  }
}
