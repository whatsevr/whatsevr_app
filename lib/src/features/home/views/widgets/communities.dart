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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            itemCount: state.mixCommunityContent.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              if (index == state.mixCommunityContent.length) {
                return state.mixCommunityContentPaginationData.isLoading
                    ? const WhatsevrLoadingIndicator()
                    : const SizedBox();
              }

              final content = state.mixCommunityContent[index];
              String? tileType;
              String? thumbnailUrl;

              switch (content.contentType?.toLowerCase()) {
                case 'wtv':
                  tileType = WhatsevrMixPostTile.wtv;
                  thumbnailUrl = content.content?.thumbnail;
                  break;
                case 'flick':
                  tileType = WhatsevrMixPostTile.flick;
                  thumbnailUrl = content.content?.thumbnail;
                  break;
                case 'offer':
                  tileType = WhatsevrMixPostTile.offer;
                  thumbnailUrl = content.content?.filesData?.firstOrNull?.imageUrl;
                  break;
                case 'photo':
                  tileType = WhatsevrMixPostTile.photo;
                  thumbnailUrl = content.content?.filesData?.firstOrNull?.imageUrl;
                  break;
              }

              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(content.contentType ?? ''),
                    ListTile(
                      
                      title: Text(content.content?.community?.title ?? ''),
                      subtitle: Text(content.content?.community?.description ?? ''),
                    ),
                    if (thumbnailUrl != null)
                      WhatsevrMixPostTile(
                        uid: content.content?.uid,
                        tileType: tileType,
                        thumbnailUrl: thumbnailUrl,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (content.content?.title != null)
                            Text(
                              content.content!.title!,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          if (content.content?.description != null)
                            Text(
                              content.content!.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
