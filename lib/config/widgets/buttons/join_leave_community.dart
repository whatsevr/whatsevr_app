import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/join_leave_community/join_leave_community_bloc.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/buttons/two_state_ui.dart';

class WhatsevrCommunityJoinLeaveButton extends StatelessWidget {
  final String? communityUid;
  final Color? firstStateColor;
  final Color? secondStateColor;
  final bool filledButton;

  const WhatsevrCommunityJoinLeaveButton({
    super.key,
    required this.communityUid,
    this.firstStateColor,
    this.secondStateColor,
    this.filledButton = true,
  });

  @override
  Widget build(BuildContext context) {
  

    final AppTheme theme = context.whatsevrTheme;

    return BlocBuilder<JoinLeaveCommunityBloc, JoinLeaveCommunityState>(
      builder: (context, state) {
        final bool isOwner =
            state.userOwnedCommunityUids.contains(communityUid);
        if (isOwner) {
          return MaterialButton(
              onPressed:null,
              
              child :Text('Owner'),
            );
        }
        final bool isJoined =
            state.userJoinedCommunityUids.contains(communityUid);

        return WhatsevrTwoStateUi(
          isSecondState: isJoined,
          onStateChanged: (onJoin, onLeave) {
            if (communityUid == null) return;
            final joinLeaveBloc = context.read<JoinLeaveCommunityBloc>();

            joinLeaveBloc.add(JoinOrLeave(userUid: communityUid!));
          },
          firstStateUi: filledButton
              ? WhatsevrButton.filled(
                  miniButton: true,
                  shrink: true,
                  label: 'Join',
                )
              : WhatsevrButton.outlined(
                  miniButton: true,
                  shrink: true,
                  label: 'Join',
                ),
          secondStateUi: filledButton
              ? WhatsevrButton.text(
                  miniButton: true,
                  shrink: true,
                  label: 'Leave',
                )
              : WhatsevrButton.text(
                  miniButton: true,
                  shrink: true,
                  label: 'Leave',
                ),
        );
      },
    );
  }
}
