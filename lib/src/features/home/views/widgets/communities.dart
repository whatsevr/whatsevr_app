part of '../page.dart';

class _CommunityContentView extends StatelessWidget {
  final ScrollController? scrollController;

  const _CommunityContentView({
    super.key,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(
      context,
      scrollController: scrollController,
      execute: () {
        context.read<HomeBloc>().add(
              LoadMoreMixCommunityContentEvent(
                page: context
                        .read<HomeBloc>()
                        .state
                        .mixCommunityContentPaginationData
                        .currentPage +
                    1,
              ),
            );
      },
    );

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return MyRefreshIndicator(
          onPullDown: () async {
            context.read<HomeBloc>().add(LoadMixCommunityContentEvent());
            await Future<void>.delayed(const Duration(seconds: 2));
          },
          child: ListView.separated(
            controller: scrollController,
           
            itemCount: state.mixCommunityContent.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              if (index == state.mixCommunityContent.length) {
                return state.mixCommunityContentPaginationData.isLoading
                    ? const WhatsevrLoadingIndicator()
                    : const SizedBox();
              }

              final content = state.mixCommunityContent[index];
              if (content.contentType == 'wtv') {
                final wtv = content.content;
                return WtvVideoPostFrame(
                  videoPostUid: wtv?.uid,
                  title: wtv?.title,
                  description: wtv?.description,
                  videoUrl: wtv?.videoUrl,
                  views: wtv?.totalViews,
                  timeAgo: wtv?.createdAt != null 
                    ? GetTimeAgo.parse(wtv!.createdAt!) 
                    : null,
                  avatarUrl: wtv?.user?.profilePicture,
                  likes: wtv?.totalLikes,
                  shares: wtv?.totalShares,
                  comments: wtv?.totalComments,
                  username: wtv?.user?.username,
                  thumbnail: wtv?.thumbnail,
                  totalTags: (wtv?.taggedUserUids?.length ?? 0) +
                      (wtv?.taggedCommunityUids?.length ?? 0),
                  onTapTags: () {
                    showTaggedUsersBottomSheet(
                      context,
                      taggedUserUids: wtv?.taggedUserUids,
                    );
                  },
                  onRequestOfVideoDetails: () { 
                    AppNavigationService.newRoute(
                      RoutesName.wtvDetails,
                      extras: WtvDetailsPageArgument(
                        videoPostUid: wtv?.uid,
                        thumbnail: wtv?.thumbnail,
                        videoUrl: wtv?.videoUrl,
                      ),
                    );
                  },
                  onTapComment: () {
                    showCommentsDialog(videoPostUid: wtv?.uid);
                  },
                );
              } else if (content.contentType == 'photo') {
                final photo = content.content;
                return PhotosPostFrame(
                  photoPostUid: photo?.uid,
                  title: photo?.title,
                  description: photo?.description,
                  filesData: photo?.filesData?.map(
                    (e) => WhatsevrNetworkFile.fromMap(e.toMap()),
                  ).toList(),
                  impressions: photo?.totalImpressions,
                  timeAgo: photo?.createdAt != null 
                    ? GetTimeAgo.parse(photo!.createdAt!) 
                    : null,
                  avatarUrl: photo?.user?.profilePicture,
                  likes: photo?.totalLikes,
                  shares: photo?.totalShares,
                  comments: photo?.totalComments,
                  username: photo?.user?.username,
                  fullName: photo?.user?.name,
                  totalTags: (photo?.taggedUserUids?.length ?? 0) +
                      (photo?.taggedCommunityUids?.length ?? 0),
                  onTapTags: () {
                    showTaggedUsersBottomSheet(
                      context,
                      taggedUserUids: photo?.taggedUserUids,
                    );
                  },
                  onTapComment: () {
                    showCommentsDialog(photoPostUid: photo?.uid);
                  },
                );
              } else if (content.contentType == 'offer') {
                final offer = content.content;
                return OfferPostFrame(
                  offerPostUid: offer?.uid,
                  title: offer?.title,
                  description: offer?.description,
                  status: offer?.status,
                  filesData: offer?.filesData?.map(
                    (e) => WhatsevrNetworkFile.fromMap(e.toMap()),
                  ).toList(),
                  ctaAction: offer?.ctaAction,
                  ctaActionUrl: offer?.ctaActionUrl,
                  views: offer?.totalImpressions,
                  timeAgo: offer?.createdAt != null 
                    ? GetTimeAgo.parse(offer!.createdAt!) 
                    : null,
                  avatarUrl: offer?.user?.profilePicture,
                  likes: offer?.totalLikes,
                  shares: offer?.totalShares,
                  comments: offer?.totalComments,
                  username: offer?.user?.username,
                  fullName: offer?.user?.name,
                  totalTags: (offer?.taggedUserUids?.length ?? 0) +
                      (offer?.taggedCommunityUids?.length ?? 0),
                  onTapTags: () {
                    showTaggedUsersBottomSheet(
                      context,
                      taggedUserUids: offer?.taggedUserUids,
                    );
                  },
                  onTapComment: () {
                    showCommentsDialog(offerPostUid: offer?.uid);
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
