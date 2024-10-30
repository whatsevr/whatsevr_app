import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../../../../config/mocks/mocks.dart';
import '../../../../../config/widgets/pad_horizontal.dart';
import '../../../../../config/widgets/post_tiles/flick.dart';
import '../../../../../config/widgets/post_tiles/photo.dart';
import '../../../../../config/widgets/post_tiles/video.dart';

class HomePageForYouPage extends StatelessWidget {
  const HomePageForYouPage({
    super.key,
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
          child: PadHorizontal(
            child: WaterfallFlow.builder(
              //cacheExtent: 0.0,

              gridDelegate:
                  const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index % 3 == 0) return const PhotoPostTile();
                if (index % 3 == 1) return const FlickPostTile();
                if (index % 3 == 2) return const VideoPostTile();
                return const SizedBox();
              },
            ),
          ),
        ),
      ],
    );
  }
}
