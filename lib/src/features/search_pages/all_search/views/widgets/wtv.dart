part of '../page.dart';

class _WtvView extends StatelessWidget {
  _WtvView();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(
               context,
     scrollController: _scrollController,
      execute: () {
        context.read<AllSearchBloc>().add(SearchMoreVideoPosts());
      },
    );
    return BlocBuilder<AllSearchBloc, AllSearchState>(
      builder: (context, state) {
        return ListView.separated(
          padding: PadHorizontal.padding,
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.searchedVideoPosts?.videoPosts?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            final video = state.searchedVideoPosts?.videoPosts?[index];
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                AppNavigationService.newRoute(
                  RoutesName.wtvDetails,
                  extras: WtvDetailsPageArgument(
                    videoPostUid: video.uid,
                    videoUrl: video.videoUrl,
                    thumbnail: video.thumbnail,
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ExtendedImage.network(
                        video?.thumbnail ??
                            MockData.imagePlaceholder('Thumbnail'),
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                        fit: BoxFit.cover,
                        height: 120,
                        width: 170,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${getDurationInText(video?.videoDurationInSec)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${formatCountToKMBTQ(3532626)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Gap(4),
                              const Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '${video?.title}',
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Gap(4),
                            Icon(Icons.more_horiz),
                          ],
                        ),
                        Text(
                          '${formatCountToKMBTQ(video?.totalLikes)} likes • ${formatCountToKMBTQ(video?.totalComments)} comments',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${formatCountToKMBTQ(video?.totalShares)} shares • ${formatCountToKMBTQ(video?.totalViews)} views',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          GetTimeAgo.parse(video!.createdAt!),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
