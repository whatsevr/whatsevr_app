import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';

import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/config/widgets/show_tagged_users_dialog.dart';
import 'package:whatsevr_app/src/features/explore/bloc/explore_bloc.dart';

import 'package:whatsevr_app/config/api/response_model/recommendation_offers.dart';
import '../../../../../../../config/widgets/posts_frame/offer.dart';

class ExplorePageOffersPage extends StatelessWidget {
  const ExplorePageOffersPage({super.key, this.scrollController});
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    scrollController?.addListener(() {
      if (scrollController?.position.pixels ==
          scrollController?.position.maxScrollExtent) {
        context.read<ExploreBloc>().add(LoadMoreOffersEvent(
              page: context
                      .read<ExploreBloc>()
                      .state
                      .videoPaginationData!
                      .currentPage +
                  1,
            ));
      }
    });
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
              RecommendedOffer offer = data![index];

              return Column(
                children: [
                  OfferPostFrame(
                    avatarUrl: offer.user?.profilePicture,
                    username: data[index].user?.username,
                    title: data[index].title,
                    description: data[index].description,
                    status: data[index].status,
                    filesData: data[index].filesData,
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
                    views: data[index].totalViews,
                  ),
                  if (index == data.length - 1 &&
                      context
                          .read<ExploreBloc>()
                          .state
                          .videoPaginationData!
                          .isLoading) ...[
                    const Gap(8),
                    CupertinoActivityIndicator(),
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
