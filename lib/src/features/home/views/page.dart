import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import '../../../../config/mocks/mocks.dart';
import '../../../../config/widgets/animated_search_field.dart';
import '../../../../config/widgets/post_tiles/flick.dart';
import '../../../../config/widgets/post_tiles/photo.dart';
import '../../../../config/widgets/post_tiles/video.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PadHorizontal(
            child: WhatsevrAnimatedSearchField(
              hintTexts: const [
                'Search for Wtv from connections',
                'Search for Media from connections',
                'Search for Memories from connections',
                'Search for Flicks from connections',
              ],
            ),
          ),
          Gap(8.0),
          SizedBox(
            height: 120.0,
            child: Builder(builder: (context) {
              List<Widget> children = [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        width: 100.0,
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ),
                    Gap(24.0),
                  ],
                ),
                for (int i = 0; i < 5; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.primaries[i % Colors.primaries.length],
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
                      Gap(5.0),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: ExtendedNetworkImageProvider(
                              MockData.imageAvatar,
                            ),
                            radius: 10.0,
                          ),
                          Gap(5.0),
                          Text('Username'),
                        ],
                      )
                    ],
                  ),
              ];
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? PadHorizontal.padding : 0.0,
                        right: index == children.length - 1 ? PadHorizontal.padding : 0.0),
                    child: children[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Gap(5.0);
                },
                itemCount: children.length,
              );
            }),
          ),
          Gap(8.0),
          Expanded(
            child: PadHorizontal(
              child: WaterfallFlow.builder(
                //cacheExtent: 0.0,

                gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index % 3 == 0) return PhotoPostTile();
                  if (index % 3 == 1) return FlickPostTile();
                  if (index % 3 == 2) return VideoPostTile();
                  return SizedBox();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
