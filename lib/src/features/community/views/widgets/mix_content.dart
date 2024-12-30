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

            String tileType = WhatsevrMixPostTile.photo; // default type
            
            // Determine tile type based on mixContent.type
            switch (mixContent.type?.toLowerCase()) {
              case 'video':
                tileType = WhatsevrMixPostTile.video;
                break;
              case 'flick':
                tileType = WhatsevrMixPostTile.flick;
                break;
              case 'offer':
                tileType = WhatsevrMixPostTile.offer;
                break;
              case 'photo':
              default:
                tileType = WhatsevrMixPostTile.photo;
                break;
            }

            return Container(
              color: Colors.grey[200],
              height: tileType == WhatsevrMixPostTile.flick ? 250 : 100,
              child: WhatsevrMixPostTile(
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
