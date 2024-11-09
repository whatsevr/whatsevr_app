part of '../page.dart';

class _PhotosView extends StatelessWidget {
  _PhotosView();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(_scrollController, execute: () {
      context.read<AllSearchBloc>().add(SearchMorePhotoPosts());
    });
    return BlocBuilder<AllSearchBloc, AllSearchState>(
      builder: (context, state) {
        return ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.searchedPhotoPosts?.photoPosts?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            final photoPost = state.searchedPhotoPosts?.photoPosts?[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                WhatsevrLoosePageView(
                  children: [
                    for (FilesDatum image in photoPost?.filesData ?? [])
                      ExtendedImage.network(
                        image.imageUrl ?? MockData.imagePlaceholder('Image'),
                        width: double.infinity,
                        fit: BoxFit.contain,
                        enableLoadState: false,
                      ),
                  ],
                ),
                const Gap(8),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: ExtendedNetworkImageProvider(
                          MockData.blankProfileAvatar),
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <StatelessWidget>[
                          Text(
                            '${photoPost?.title}',
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            '${GetTimeAgo.parse(photoPost!.createdAt!)}',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  '${photoPost.description}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
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
