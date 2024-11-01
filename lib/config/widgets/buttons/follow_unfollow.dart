import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/buttons/two_state_ui.dart';

class WhatsevrFollowButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (AuthUserDb.getLastLoggedUserUid() == followeeUserUid) {
      return const SizedBox();
    }

    final AppTheme theme = context.whatsevrTheme;

    return BlocBuilder<FollowUnfollowBloc, FollowUnfollowState>(
      builder: (context, state) {
        final bool isFollowed = state.followedUserIds.contains(followeeUserUid);

        return WhatsevrTwoStateUi(
          isSecondState: isFollowed,
          onStateChanged: (onFollow, onUnfollow) {
            if (followeeUserUid == null) return;
            final followUnfollowBloc = context.read<FollowUnfollowBloc>();

            followUnfollowBloc.add(ToggleFollow(userUid: followeeUserUid!));
          },
          firstStateUi: filledButton
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
          secondStateUi: filledButton
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
      },
    );
  }
}
