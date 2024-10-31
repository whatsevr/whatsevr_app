import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/api/methods/user_relations.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/follow_unfollow_middleware.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/buttons/two_state_ui.dart';

class WhatsevrFollowButton extends StatefulWidget {
  final String? followeeUserUid;
  final Color? firstStateColor;
  final Color? secondStateColor;

  final bool filledButton;
  const WhatsevrFollowButton({
    super.key,
    required this.followeeUserUid,
    this.firstStateColor,
    this.secondStateColor,
    this.filledButton = true,
  });

  @override
  State<WhatsevrFollowButton> createState() => _WhatsevrFollowButtonState();
}

class _WhatsevrFollowButtonState extends State<WhatsevrFollowButton> {
  bool? isFollowed;
  @override
  void initState() {
    super.initState();

    //postframe callback to avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && context.mounted) {
        isFollowed =
            FollowUnfollowMiddleware.isFollowed(widget.followeeUserUid!);
        if (isFollowed == true) print('${widget.followeeUserUid} Followed');
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (AuthUserDb.getLastLoggedUserUid() == widget.followeeUserUid ||
        isFollowed == null) {
      return SizedBox();
    }
    final AppTheme theme = context.whatsevrTheme;
    return WhatsevrTwoStateUi(
      isSecondState: isFollowed,
      onStateChanged: (onFollow, onUnfollow) {
        if (onFollow) {
          FollowUnfollowMiddleware.toggleFollow(
            widget.followeeUserUid!,
          );
        } else if (onUnfollow) {
          FollowUnfollowMiddleware.toggleFollow(
            widget.followeeUserUid!,
          );
        }
      },
      firstStateUi: widget.filledButton
          ? WhatsevrButton.filled(
              miniButton: true,
              shrink: true,
              label: 'Follow',
            )
          : WhatsevrButton.outlined(
              miniButton: true,
              shrink: true,
              label: 'Follow',
            ),
      secondStateUi: widget.filledButton
          ? WhatsevrButton.text(
              miniButton: true,
              shrink: true,
              label: 'Unfollow',
            )
          : WhatsevrButton.text(
              miniButton: true,
              shrink: true,
              label: 'Unfollow',
            ),
    );
  }
}
