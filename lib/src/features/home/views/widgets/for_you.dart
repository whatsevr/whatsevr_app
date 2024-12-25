import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/dynamic_mix_post_tile.dart';
import 'package:whatsevr_app/src/features/explore/views/widgets/mix_posts/views/page.dart';

class HomePageForYouPage extends StatelessWidget {
    final ScrollController? scrollController;
  const HomePageForYouPage({
    super.key,
    this.scrollController
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 120.0,
          child: Builder(
            builder: (BuildContext context) {
              final List<Widget> children = <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        width: 100.0,
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ),
                    const Gap(24.0),
                  ],
                ),
                for (int i = 0; i < 5; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Colors.primaries[i % Colors.primaries.length],
                            borderRadius: BorderRadius.circular(18.0),
                            image: DecorationImage(
                              image: ExtendedNetworkImageProvider(
                                MockData.randomImage(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 180.0,
                          alignment: Alignment.center,
                        ),
                      ),
                      const Gap(5.0),
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: ExtendedNetworkImageProvider(
                              MockData.blankProfileAvatar,
                            ),
                            radius: 10.0,
                          ),
                          const Gap(5.0),
                          const Text('Username'),
                        ],
                      ),
                    ],
                  ),
              ];
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? PadHorizontal.paddingValue : 0.0,
                      right: index == children.length - 1
                          ? PadHorizontal.paddingValue
                          : 0.0,
                    ),
                    child: children[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(5.0);
                },
                itemCount: children.length,
              );
            },
          ),
        ),
        const Gap(8.0),
        Expanded(
          child:     GridView.custom(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      controller: scrollController,
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(2, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final isInvertedPattern = (index ~/ 5) % 2 == 1;
          final positionInPattern = index % 5;

          if (isInvertedPattern) {
            // Inverted pattern: Video, Photo, Flick, Photo, Photo
            if (positionInPattern == 0) return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.video);
            if (positionInPattern == 2) return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.flick);
            return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.photo);
          } else {
            // Normal pattern: Flick, Photo, Photo, Photo, Video
            if (positionInPattern == 0) return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.flick);
            if (positionInPattern == 4) return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.video);
            return const WhatsevrMixPostTile(type: WhatsevrMixPostTile.photo);
          }
        },
      ),
    )
 ,
        ),
      ],
    );
  }
}
