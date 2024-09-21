import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import 'package:iconify_flutter/icons/la.dart';

import 'package:iconify_flutter/icons/octicon.dart';

import 'package:iconify_flutter/icons/ph.dart';

import 'package:iconify_flutter/icons/system_uicons.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/animated_like_icon_button.dart';
import 'package:whatsevr_app/config/widgets/feed_players/wtv_mini_player.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import '../../../utils/conversion.dart';

class WtvVideoPostFrame extends StatelessWidget {
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

  const WtvVideoPostFrame({
    super.key,
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
                videoUrl: videoUrl,
                thumbnail: thumbnail,
                thumbnailHeightAspectRatio: thumbnailHeightAspectRatio,
                onTapFreeArea: () {
                  onRequestOfVideoDetails?.call();
                },
                loopVideo: true,
              ),
              if (totalTags != null && totalTags! > 0)
                Positioned(
                  bottom: 8,
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
                            '$title',
                          ),
                          Gap(4),
                          Row(
                            children: [
                              Text(
                                '$username',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                ' • $timeAgo',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              if (views != null && views! > 0)
                                Text(
                                  ' • ${formatCountToKMBTQ(views)} views',
                                  style: TextStyle(
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
                    const AnimatedLikeIconButton(),
                    Text(likes == null || likes == 0
                        ? ''
                        : formatCountToKMBTQ(likes) ?? ''),
                    IconButton(
                      icon: Iconify(Octicon.comment_24),
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
                    TwoStateWidget(
                      firstStateUi: Iconify(Ph.bookmark_simple_thin),
                      secondStateUi: Iconify(Ph.bookmark_fill),
                    ),
                    IconButton(
                      icon: const Iconify(SystemUicons.menu_vertical),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <ListTile>[
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
          ),
        ],
      ),
    );
  }
}

class TwoStateWidget extends StatefulWidget {
  final bool? isFirstState;
  final Widget? firstStateUi;
  final Widget? secondStateUi;
  const TwoStateWidget({
    super.key,
    this.isFirstState,
    this.firstStateUi,
    this.secondStateUi,
  });

  @override
  State<TwoStateWidget> createState() => _TwoStateWidgetState();
}

class _TwoStateWidgetState extends State<TwoStateWidget> {
  @override
  void initState() {
    super.initState();
    _firstState = widget.isFirstState ?? true;
  }

  late bool _firstState;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _firstState
          ? widget.firstStateUi ?? Icon(Icons.circle_outlined)
          : widget.secondStateUi ?? Icon(Icons.check_circle),
      onPressed: () {
        setState(() {
          _firstState = !_firstState;
        });
      },
    );
  }
}
