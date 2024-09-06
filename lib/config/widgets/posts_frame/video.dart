import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/charm.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ph.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/animated_like_icon_button.dart';
import 'package:whatsevr_app/config/widgets/feed_players/wtv_player.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';

class VideoFrame extends StatelessWidget {
  final String? title;
  final String? description;
  final String? videoUrl;
  final String? views;
  final String? timeAgo;
  final String? avatarUrl;
  final String? likes;
  final String? username;
  final String? thumbnail;

  const VideoFrame({
    super.key,
    this.title,
    this.description,
    this.videoUrl,
    this.views,
    this.timeAgo,
    this.avatarUrl,
    this.likes,
    this.username,
    this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        AppNavigationService.newRoute(RoutesName.wtvDetails);
      },
      child: Column(
        children: <Widget>[
          WTVFeedPlayer(
            videoUrl: videoUrl,
            thumbnail: thumbnail,
            onTapFreeArea: () {
              AppNavigationService.newRoute(RoutesName.wtvDetails);
            },
          ),
          const Gap(8),
          PadHorizontal(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: ExtendedNetworkImageProvider(
                        avatarUrl ?? MockData.imageAvatar,
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '$title',
                          ),
                          Gap(4),
                          Text(
                            '$username  • $timeAgo',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  children: <Widget>[
                    const AnimatedLikeIconButton(),
                    const Text('2.5M'),
                    IconButton(
                      icon: const Iconify(Ph.chat_centered_dots),
                      onPressed: () {},
                    ),
                    const Text('2.5M'),
                    IconButton(
                      icon: const Iconify(MaterialSymbols.ios_share),
                      onPressed: () {},
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Iconify(Ion.bookmark),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Iconify(Charm.menu_kebab),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <ListTile>[
                                ListTile(
                                  title: Text('Report'),
                                  leading: Icon(Icons.report),
                                ),
                                ListTile(
                                  title: Text('Delete'),
                                  leading: Icon(Icons.block),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
