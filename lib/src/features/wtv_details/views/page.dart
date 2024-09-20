import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/src/features/wtv_details/views/widgets/related_videos.dart';

import 'package:whatsevr_app/config/widgets/feed_players/wtv_mini_player.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

class WtvDetailsPageArgument {
  final String? videoPostUid;
  final String? thumbnail;
  final String? videoUrl;
  WtvDetailsPageArgument({
    required this.videoPostUid,
    this.thumbnail,
    this.videoUrl,
  });
}

class WtvDetailsPage extends StatelessWidget {
  final WtvDetailsPageArgument pageArgument;
  const WtvDetailsPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Video player
          WTVMiniPlayer(
            videoUrl: pageArgument.videoUrl,
            thumbnail: pageArgument.thumbnail,
            loopVideo: false,
            autoPlay: true,
          ),
          // Video title
          Expanded(
            child: ListView(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Video title XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //channnel name and subscribe button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      // Channel name
                      Expanded(
                        child: Text(
                          'Channel name XXXXXXXXXXXXXXXXXXXXXXXXXXX',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Subscribe button
                      MaterialButton(
                        onPressed: () {},
                        shape: StadiumBorder(),
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text('Follow'),
                      ),
                    ],
                  ),
                ),
                //like, dislike, share, save, download buttons
                PadHorizontal(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        // Like button
                        for ((String label, IconData icon) record
                            in <(String, IconData)>[
                          ('Like', Icons.thumb_up),
                          ('Share', Icons.share),
                          ('Save', Icons.bookmark),
                        ])
                          MaterialButton(
                            onPressed: () {},
                            child: Row(
                              children: <Widget>[
                                Icon(record.$2),
                                Gap(5),
                                Text(record.$1),
                              ],
                            ),
                          ),

                        // Share button
                      ],
                    ),
                  ),
                ),
                //comments

                Gap(10),
                WtvVideoDetailsRelatedVideosView(),
                Gap(10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
