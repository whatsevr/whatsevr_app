part of '../page.dart';

class _FlicksView extends StatelessWidget {
  _FlicksView();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(
            context,
     scrollController: _scrollController,
      execute: () {
        context.read<AllSearchBloc>().add(SearchMoreFlickPosts());
      },
    );
    return BlocBuilder<AllSearchBloc, AllSearchState>(
      builder: (context, state) {
        return GridView.builder(
          controller: _scrollController,
          padding: PadHorizontal.padding,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 9 / 21,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: state.searchedFlickPosts?.flicks?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final flick = state.searchedFlickPosts?.flicks?[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Stack(
                    children: <Widget>[
                      ExtendedImage.network(
                        flick?.thumbnail ??
                            MockData.imagePlaceholder('Thumbnail'),
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        enableLoadState: false,
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
                            '${getDurationInText(flick?.videoDurationInSec)}',
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
                              '${flick?.title}',
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
                        '${formatCountToKMBTQ(flick?.totalViews)} Views',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${formatCountToKMBTQ(flick?.totalLikes)} Likes • ${formatCountToKMBTQ(flick?.totalComments)} Comments',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        GetTimeAgo.parse(flick!.createdAt!),
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
            );
          },
        );
      },
    );
  }
}
