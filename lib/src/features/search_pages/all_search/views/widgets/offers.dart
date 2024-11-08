part of '../page.dart';

class _OffersView extends StatelessWidget {
  _OffersView();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllSearchBloc, AllSearchState>(
      builder: (context, state) {
        return ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const Gap(4);
          },
          itemCount: state.searchedOffers?.offers?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final offer = state.searchedOffers?.offers?[index];
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'offer[status]',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Gap(4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'offer[title]',
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Gap(4),
                          const Icon(Icons.more_horiz),
                        ],
                      ),
                      if (offer?.description?.isNotEmpty ?? false) ...[
                        const Gap(4),
                        Text(
                          '${offer?.description}',
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (offer['filesData'].isNotEmpty) ...[
                    const Gap(8),
                    SizedBox(
                      height: 120,
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: offer['filesData'].length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Gap(8);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final Map<String, dynamic> fileData =
                              offer['filesData'][index];
                          if (fileData['type'] == 'image' ||
                              fileData['type'] == 'video') {
                            return ExtendedImage.network(
                              fileData['imageUrl'] ??
                                  fileData['videoThumbnailUrl'] ??
                                  '',
                              fit: BoxFit.cover,
                              enableLoadState: false,
                              cache: true,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ],
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final record in [
                        (
                          offer['totalImpressions'].toString(),
                          Icons.remove_red_eye
                        ),
                        (offer['totalLikes'].toString(), Icons.thumb_up_sharp),
                        (offer['totalComments'].toString(), Icons.comment),
                        (offer['totalShares'].toString(), Icons.share_sharp),
                      ])
                        Row(
                          children: [
                            Text(
                              record.$1,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const Gap(4),
                            Icon(
                              record.$2,
                              size: 16,
                            ),
                            const Gap(8),
                          ],
                        ),
                    ],
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
