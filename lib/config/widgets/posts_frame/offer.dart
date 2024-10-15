import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import 'package:iconify_flutter/icons/la.dart';

import 'package:iconify_flutter/icons/octicon.dart';

import 'package:iconify_flutter/icons/ph.dart';

import 'package:iconify_flutter/icons/system_uicons.dart';
import 'package:whatsevr_app/config/api/response_model/recommendation_offers.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/animated_like_icon_button.dart';
import 'package:whatsevr_app/config/widgets/dynamic_height_views.dart';
import 'package:whatsevr_app/config/widgets/feed_players/wtv_mini_player.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import '../../../utils/conversion.dart';

import '../two_state_ui.dart';

class OfferPostFrame extends StatelessWidget {
  final String? title;
  final String? description;
  final String? status;
  final List<FilesDatum>? filesData;
  final String? ctaAction;
  final String? ctaActionUrl;
  final int? views;
  final String? timeAgo;
  final String? avatarUrl;
  final int? likes;
  final int? shares;
  final int? comments;
  final String? username;
  final String? fullName;

  final int? totalTags;
  final Function()? onTapTags;
  final Function()? onRequestOfOfferDetails;

  const OfferPostFrame({
    super.key,
    this.title,
    this.description,
    this.status,
    this.filesData,
    this.ctaAction,
    this.ctaActionUrl,
    this.views,
    this.timeAgo,
    this.avatarUrl,
    this.likes,
    this.shares,
    this.comments,
    this.username,
    this.fullName,
    this.totalTags,
    this.onTapTags,
    this.onRequestOfOfferDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onRequestOfOfferDetails?.call();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (filesData?.isNotEmpty ?? false) ...[
            const Gap(8),
            Stack(
              children: <Widget>[
                SwipeAbleDynamicHeightViews(
                  key: UniqueKey(),
                  children: [
                    if (filesData != null && filesData!.isNotEmpty)
                      for (final FilesDatum file in filesData!)
                        if (file.type == 'image')
                          ExtendedImage.network(
                            file.imageUrl ?? MockData.imagePlaceholder("Offer"),
                            width: double.infinity,
                            fit: BoxFit.contain,
                            enableLoadState: false,
                            cache: true,
                          )
                        else if (file.type == 'video')
                          WTVMiniPlayer(
                            videoUrl: file.videoUrl,
                            thumbnail: file.videoThumbnailUrl,
                            onTapFreeArea: () {
                              onRequestOfOfferDetails?.call();
                            },
                            loopVideo: true,
                          ),
                  ],
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
            )
          ],
          const Gap(8),
          PadHorizontal(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$title',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Gap(8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    '$status',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                if (filesData?.isEmpty ?? true) ...[
                  const Gap(8),
                  Text(
                    '$description',
                    maxLines: filesData?.isNotEmpty ?? false ? 2 : 12,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ]
              ],
            ),
          ),
          const Gap(8),
          PadHorizontal(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: ExtendedNetworkImageProvider(
                    avatarUrl ?? MockData.imageAvatar,
                    cache: true,
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '$fullName',
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          Text(
                            '$username',
                            style: const TextStyle(
                              fontSize: 12,
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
          ),
          const Gap(8),
          Row(
            children: <Widget>[
              Gap(8),
              const AnimatedLikeIconButton(),
              Text(likes == null || likes == 0
                  ? ''
                  : formatCountToKMBTQ(likes) ?? ''),
              IconButton(
                icon: const Iconify(Octicon.comment_24),
                onPressed: () {},
              ),
              Text(comments == null || comments == 0
                  ? ''
                  : formatCountToKMBTQ(comments) ?? ''),
              IconButton(
                icon: const Iconify(La.share),
                onPressed: () {},
              ),
              Text(shares == null || shares == 0
                  ? ''
                  : formatCountToKMBTQ(shares) ?? ''),
              const Spacer(),
              const TwoStateWidget(
                firstStateUi: Iconify(Ph.bookmark_simple_thin),
                secondStateUi: Iconify(Ph.bookmark_fill),
              ),
              IconButton(
                icon: const Iconify(SystemUicons.menu_vertical),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <ListTile>[
                          ListTile(
                            title: Text('View Account'),
                            leading: Icon(Icons.account_box_rounded),
                          ),
                          ListTile(
                            title: Text('Report'),
                            leading: Icon(Icons.report),
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
    );
  }
}
