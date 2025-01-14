part of '../page.dart';

class _MixContentView extends StatelessWidget {
  const _MixContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        if (state.communityMixContent.isEmpty) {
          return const Center(
            child: Text('No mix content available'),
          );
        }

        return MasonryGridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          itemCount: state.communityMixContent.length,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final mixContent = state.communityMixContent[index];
            if (mixContent == null) return const SizedBox();

            String? tileType;
            String? thumbnailUrl;

            // Determine tile type based on mixContent.type
            switch (mixContent.type?.toLowerCase()) {
              case 'wtv':
                tileType = WhatsevrMixPostTile.wtv;
                thumbnailUrl = mixContent.content?.thumbnail;
                break;
              case 'flick':
                tileType = WhatsevrMixPostTile.flick;
                thumbnailUrl = mixContent.content?.thumbnail;
                break;
              case 'offer':
                tileType = WhatsevrMixPostTile.offer;

                thumbnailUrl =
                    mixContent.content?.filesData?.firstOrNull?.imageUrl;

                break;
              case 'photo':
                tileType = WhatsevrMixPostTile.photo;
                thumbnailUrl = thumbnailUrl;
                break;
            }

            return Container(
              color: Colors.grey[200],
              height: tileType == WhatsevrMixPostTile.flick ? 250 : 100,
              child: WhatsevrMixPostTile(
                uid: mixContent.content?.uid,
                tileType: tileType,
                thumbnailUrl: mixContent.content?.thumbnail,
              ),
            );
          },
        );
      },
    );
  }
}
