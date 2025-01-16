import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

import 'package:whatsevr_app/utils/conversion.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/buttons/post_actions.dart';
import 'package:whatsevr_app/config/widgets/feed_players/wtv_mini_player.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

class FlickPostFrame extends StatelessWidget {
  final String? videoPostUid;
  final String? title;
  final String? description;
  final String? videoUrl;
  final int? views;
  final String? timeAgo;
  final String? avatarUrl;
  final int? likes;
  final int? shares;
  final int? comments;
  final String? username;
  final String? thumbnail;
  final int? totalTags;
  final Function()? onTapTags;
  final Function()? onRequestOfVideoDetails;
  final double? thumbnailHeightAspectRatio;
  final VoidCallback? onTapComment;
  const FlickPostFrame({
    super.key,
    this.videoPostUid,
    this.title,
    this.description,
    this.videoUrl,
    this.views,
    this.timeAgo,
    this.avatarUrl,
    this.likes,
    this.shares,
    this.comments,
    this.username,
    this.thumbnail,
    this.totalTags,
    this.onTapTags,
    this.onRequestOfVideoDetails,
    this.thumbnailHeightAspectRatio,
    this.onTapComment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onRequestOfVideoDetails?.call();
      },
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              WTVMiniPlayer( 
                key: ValueKey('home-community-video-$videoUrl'),
                videoUrl: videoUrl, 
                thumbnail: thumbnail,
                thumbnailHeightAspectRatio: WhatsevrAspectRatio.vertical9by16.ratio,
                onTapFreeArea: () {
                  onRequestOfVideoDetails?.call();
                },
                loopVideo: true,
              ),
              if (totalTags != null && totalTags! > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      if (totalTags != null && totalTags! > 0) {
                        onTapTags?.call();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 16,
                          ),
                          const Gap(4),
                          Text(
                            totalTags == null || totalTags == 0
                                ? ''
                                : totalTags.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Gap(8),
          PadHorizontal(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: ExtendedNetworkImageProvider(
                        avatarUrl ?? MockData.blankProfileAvatar,
                        cache: true,
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
                          const Gap(4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '$username',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Text(
                                ' • $timeAgo',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              if (views != null && views! > 0)
                                Text(
                                  ' • ${formatCountToKMBTQ(views)} views',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  children: <Widget>[
                    WhatsevrReactButton(
                      videoPostUid: videoPostUid,
                      reactionCount: likes,
                    ),
                    WhatsevrCommentButton(
                      onTapComment: () {
                        onTapComment?.call();
                      },
                    ),
                    Text(
                      comments == null || comments == 0
                          ? ''
                          : formatCountToKMBTQ(comments) ?? '',
                    ),
                    WhatsevrShareButton(
                      onTapShare: () {},
                    ),
                    Text(
                      shares == null || shares == 0
                          ? ''
                          : formatCountToKMBTQ(shares) ?? '',
                    ),
                    const Spacer(),
                    WhatsevrBookmarkButton(),
                    Whatsevr3DotMenuButton(),
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
